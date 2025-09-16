import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:characters/characters.dart';
import '../widgets/character_keyboard.dart';
import '../widgets/3d_card.dart';
import '../constants/colors.dart';
import '../services/storage_service.dart';
import '../models/history_model.dart';
import '../models/favorite_model.dart';
import '../l10n/app_localizations.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  String _inputText = '';
  final TextEditingController _textController = TextEditingController();
  double _fontSize = 24.0;
  FontWeight _selectedWeight = FontWeight.normal;
  final StorageService _storageService = StorageService();
  final FocusNode _focusNode = FocusNode();
  Map<String, bool> _favoriteStatus = {};
  bool _isSaving = false;

  final List<FontWeight> _fontWeights = [
    FontWeight.normal,
    FontWeight.w500,
    FontWeight.w600,
    FontWeight.w700,
    FontWeight.w800,
    FontWeight.w900,
  ];

  final List<String> _fontWeightNames = [
    'Regular',
    'Medium',
    'SemiBold',
    'Bold',
    'ExtraBold',
    'Black'
  ];

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    final favorites = await _storageService.getFavorites();
    for (var favorite in favorites) {
      _favoriteStatus[favorite.content] = favorite.isFavorite;
    }
    if (mounted) setState(() {});
  }

  bool _isFavorite(String text) => _favoriteStatus[text] ?? false;

  void _insertCharacter(String character) { /* identique */ 
    final text = _textController.text;
    final selection = _textController.selection;
    final cursorPos = selection.baseOffset.clamp(0, text.length);
    final newText = text.substring(0, cursorPos) + character + text.substring(cursorPos);
    setState(() {
      _inputText = newText;
      _textController.text = _inputText;
      _textController.selection = TextSelection.collapsed(offset: cursorPos + character.length);
    });
    _focusNode.requestFocus();
  }

  void _deleteLastCharacter() { /* identique */
    final text = _textController.text;
    if (text.isEmpty) return;
    final characters = text.characters;
    final newText = characters.skipLast(1).toString();
    setState(() {
      _inputText = newText;
      _textController.text = _inputText;
      _textController.selection = TextSelection.collapsed(offset: newText.length);
    });
    _focusNode.requestFocus();
  }

  void _clearText() { setState(() { _inputText = ''; _textController.clear(); }); _focusNode.requestFocus(); }

  Future<void> _toggleFavorite() async { /* identique */ 
    if (_inputText.trim().isEmpty) return;
    final l10n = AppLocalizations.of(context)!;
    setState(() => _isSaving = true);
    final favorite = Favorite(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: _inputText,
      dateAdded: DateTime.now(),
      type: _inputText.characters.length == 1 ? 'character' : 'word',
      isFavorite: true,
    );
    final existingFavorites = await _storageService.getFavorites();
    final existingFavorite = existingFavorites.firstWhere(
      (fav) => fav.content == _inputText,
      orElse: () => Favorite(id: '', content: '', dateAdded: DateTime.now(), type: '', isFavorite: false),
    );
    if (existingFavorite.id.isNotEmpty) {
      await _storageService.toggleFavorite(existingFavorite.id);
      setState(() => _favoriteStatus[_inputText] = !_isFavorite(_inputText));
    } else {
      await _storage_service_saveFavorite(favorite); // see note below
      setState(() => _favoriteStatus[_inputText] = true);
    }
    setState(() => _isSaving = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isFavorite(_inputText) ? '${_inputText} ${l10n.addToFavorites} ★' : '${_inputText} ${l10n.removeFromFavorites} ☆',
        ),
        backgroundColor: AppColors.gold,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // NOTE: replace call if your StorageService method name differs:
  Future<void> _storage_service_saveFavorite(Favorite favorite) async {
    await _storageService.saveFavorite(favorite);
  }

  Future<void> _saveToHistory() async { /* identique */ 
    final l10n = AppLocalizations.of(context)!;
    if (_inputText.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.emptyTextWarning), backgroundColor: Colors.orange, behavior: SnackBarBehavior.floating));
      return;
    }
    setState(() => _isSaving = true);
    final historyItem = HistoryItem(id: DateTime.now().millisecondsSinceEpoch.toString(), text: _inputText, dateCreated: DateTime.now());
    await _storageService.saveHistoryItem(historyItem);
    setState(() => _isSaving = false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.savedToHistory), backgroundColor: AppColors.gold, behavior: SnackBarBehavior.floating));
  }

  @override
  void dispose() { _focusNode.dispose(); _textController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // prendre en compte le clavier (viewInsets.bottom)
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Material(
      color: Colors.transparent, // laisse le gradient parent visible
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + bottomInset),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // important pour éviter que Column force la hauteur
          children: [
            // Zone texte avec favoris
            ThreeDCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(l10n.typeTextLabel, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.gold)),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: _isSaving
                            ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(AppColors.gold)))
                            : IconButton(
                                key: ValueKey(_isFavorite(_inputText)),
                                icon: Icon(_isFavorite(_inputText) ? Icons.star : Icons.star_border, color: _isFavorite(_inputText) ? AppColors.gold : Colors.grey),
                                onPressed: _inputText.isNotEmpty ? _toggleFavorite : null,
                              ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.whiteOpacity50,
                      border: Border.all(color: AppColors.gold),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: SizedBox(
                      // height fixe pour éviter que le TextField essaie de grandir sans limite
                      height: 100,
                      child: TextField(
                        controller: _textController,
                        focusNode: _focus_node(),
                        showCursor: true,
                        maxLines: 3,
                        style: TextStyle(fontFamily: 'Kedebideri', fontSize: _fontSize, fontWeight: _selectedWeight, color: Colors.white, height: 1.2),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: l10n.typeTextLabel,
                          hintStyle: TextStyle(color: Colors.grey.shade400, fontFamily: 'Kedebideri', fontSize: _fontSize),
                          contentPadding: EdgeInsets.zero,
                        ),
                        onChanged: (value) => setState(() => _inputText = value),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Options de texte (ex : slider, dropdown)
            ThreeDCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.textOptions, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.gold)),
                  const SizedBox(height: 16),
                  // Slider row
                  Row(
                    children: [
                      Expanded(flex: 2, child: Text(l10n.fontSizeLabel, style: const TextStyle(color: Colors.white, fontSize: 14))),
                      Expanded(
                        flex: 5,
                        child: Slider(value: _fontSize, min: 16, max: 48, divisions: 8, label: _fontSize.round().toString(), activeColor: AppColors.gold, inactiveColor: AppColors.goldOpacity03, onChanged: (v) => setState(() => _fontSize = v)),
                      ),
                      Expanded(flex:1, child: Container(padding: const EdgeInsets.symmetric(horizontal:8, vertical:4), decoration: BoxDecoration(color: AppColors.goldOpacity02, borderRadius: BorderRadius.circular(6)), child: Text(_fontSize.round().toString(), textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)))),
                    ],
                  ),

                  const SizedBox(height: 16),
                  // Dropdown row
                  Row(
                    children: [
                      Expanded(flex:2, child: Text(l10n.fontWeightLabel, style: const TextStyle(color: Colors.white, fontSize: 14))),
                      Expanded(
                        flex:3,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal:8),
                          decoration: BoxDecoration(color: AppColors.darkerGreen, borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.goldOpacity03)),
                          child: DropdownButton<FontWeight>(
                            value: _selectedWeight,
                            dropdownColor: AppColors.darkGreen,
                            style: const TextStyle(color: Colors.white),
                            underline: const SizedBox(),
                            isExpanded: true,
                            icon: Icon(Icons.arrow_drop_down, color: AppColors.gold),
                            items: List.generate(_font_weights_length(), (i) => DropdownMenuItem(value: _fontWeights[i], child: Text(_fontWeightNames[i], style: const TextStyle(fontSize:14)))),
                            onChanged: (v) => setState(() => _selectedWeight = v ?? FontWeight.normal),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Clavier (ne prend pas trop d'espace, s'il est volumineux l'utilisateur scrollera)
            ThreeDCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(l10n.charactersLabel, style: const TextStyle(fontSize:18, fontWeight: FontWeight.bold, color: AppColors.gold)),
              const SizedBox(height: 8),
              CharacterKeyboard(onCharacterTap: _insertCharacter, onDelete: _deleteLastCharacter, onClear: _clearText),
            ])),

            const SizedBox(height: 16),

            // Boutons actions (copier, sauvegarder, favoris)
            Row(
              children: [
                Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal:4.0), child: ElevatedButton.icon(onPressed: () { if (_inputText.isNotEmpty) { Clipboard.setData(ClipboardData(text: _inputText)); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.copiedToClipboard), backgroundColor: AppColors.gold, behavior: SnackBarBehavior.floating)); } else { ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.noTextToCopy), backgroundColor: Colors.orange, behavior: SnackBarBehavior.floating)); } }, icon: const Icon(Icons.content_copy, size:18), label: Text(l10n.copy, style: const TextStyle(fontSize:12)), style: ElevatedButton.styleFrom(backgroundColor: AppColors.darkerGreen, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical:12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))))),
                Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal:4.0), child: ElevatedButton.icon(onPressed: _saveToHistory, icon: const Icon(Icons.save, size:18), label: Text(l10n.save, style: const TextStyle(fontSize:12)), style: ElevatedButton.styleFrom(backgroundColor: AppColors.darkerGreen, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical:12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))))),
                Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal:4.0), child: ElevatedButton.icon(onPressed: _toggleFavorite, icon: Icon(_isFavorite(_inputText) ? Icons.star : Icons.star_border, size: 18), label: Text(_isFavorite(_inputText) ? l10n.removeFromFavorites : l10n.addToFavorites, style: const TextStyle(fontSize:12)), style: ElevatedButton.styleFrom(backgroundColor: _isFavorite(_inputText) ? AppColors.goldOpacity02 : AppColors.darkerGreen, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical:12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))))),
              ],
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // petites fonctions utilitaires utilisées dans le code ci-dessus :
  FocusNode _focus_node() => _focusNode;
  int _font_weights_length() => _fontWeights.length;
}
