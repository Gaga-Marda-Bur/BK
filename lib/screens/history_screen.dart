import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../widgets/3d_card.dart';
import '../constants/colors.dart';
import '../services/storage_service.dart';
import '../models/history_model.dart';
import '../l10n/app_localizations.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final StorageService _storageService = StorageService();
  List<HistoryItem> _history = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final history = await _storageService.getHistory();
    if (!mounted) return;
    setState(() {
      _history = history;
      _isLoading = false;
    });
  }

  Future<void> _clearHistory() async {
    await _storageService.clearHistory();
    await _loadHistory();

    if (!mounted) return;
    _showSnackBar(AppLocalizations.of(context)!.historyCleared, AppColors.gold);
  }

  Future<void> _deleteHistoryItem(String id) async {
    await _storageService.deleteHistoryItem(id);
    await _loadHistory();

    if (!mounted) return;
    _showSnackBar(AppLocalizations.of(context)!.itemDeleted, AppColors.gold);
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Material(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.darkGreen, AppColors.darkerGreen],
          ),
        ),
        child: _isLoading 
            ? _buildLoading()
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ThreeDCard(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.history,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.gold,
                            ),
                          ),
                          if (_history.isNotEmpty)
                            IconButton(
                              icon: const Icon(Icons.delete_sweep, color: Colors.red),
                              onPressed: () => _showConfirmationDialog(
                                title: l10n.clearHistory,
                                content: l10n.clearHistoryConfirm,
                                confirmLabel: l10n.clearAll,
                                onConfirm: _clearHistory,
                              ),
                              tooltip: l10n.clearHistory,
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: _history.isEmpty
                          ? _buildEmptyHistory(l10n)
                          : ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: _history.length,
                              itemBuilder: (context, index) {
                                return _buildHistoryItem(_history[index], l10n);
                              },
                            ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildLoading() => const Center(
        child: CircularProgressIndicator(color: AppColors.gold),
      );

  Widget _buildEmptyHistory(AppLocalizations l10n) {
    return ThreeDCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history, size: 64, color: AppColors.goldOpacity05),
          const SizedBox(height: 16),
          Text(
            l10n.noHistory,
            style: const TextStyle(fontSize: 18, color: Colors.white70),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.yourTextsWillAppear,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white54),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(HistoryItem item, AppLocalizations l10n) {
    return Dismissible(
      key: Key(item.id),
      background: _buildSwipeAction(
        color: Colors.blue,
        alignment: Alignment.centerLeft,
        icon: Icons.content_copy,
      ),
      secondaryBackground: _buildSwipeAction(
        color: Colors.red,
        alignment: Alignment.centerRight,
        icon: Icons.delete,
      ),
      direction: DismissDirection.horizontal,
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          return await _showConfirmationDialog(
            title: l10n.deleteItem,
            content: l10n.deleteConfirm(item.text),
            confirmLabel: l10n.delete,
            onConfirm: () => _deleteHistoryItem(item.id),
          );
        } else if (direction == DismissDirection.startToEnd) {
          _copyToClipboard(item.text, l10n);
          return false;
        }
        return false;
      },
      child: ThreeDCard(
        padding: const EdgeInsets.all(12),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: AppColors.goldOpacity02,
            child: const Icon(Icons.history, color: AppColors.gold),
          ),
          title: Text(
            item.text,
            style: const TextStyle(
              fontFamily: 'Kedebideri',
              fontSize: 18,
              color: Colors.white,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            l10n.createdOn(
              DateFormat('dd/MM/yyyy à HH:mm').format(item.dateCreated),
            ),
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
          trailing: Wrap(
            spacing: 4,
            children: [
              IconButton(
                icon: const Icon(Icons.content_copy, color: AppColors.gold),
                onPressed: () => _copyToClipboard(item.text, l10n),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _showConfirmationDialog(
                  title: l10n.deleteItem,
                  content: l10n.deleteConfirm(item.text),
                  confirmLabel: l10n.delete,
                  onConfirm: () => _deleteHistoryItem(item.id),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwipeAction({
    required Color color,
    required Alignment alignment,
    required IconData icon,
  }) {
    return Container(
      color: color,
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Icon(icon, color: Colors.white),
    );
  }

  Future<bool> _showConfirmationDialog({
    required String title,
    required String content,
    required String confirmLabel,
    required VoidCallback onConfirm,
  }) async {
    final l10n = AppLocalizations.of(context)!;
    
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.darkGreen,
        title: Text(title, style: const TextStyle(color: AppColors.gold)),
        content: Text(content, style: const TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel,
                style: const TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              onConfirm();
            },
            child: Text(confirmLabel,
                style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    return confirm ?? false;
  }

  Future<void> _copyToClipboard(String text, AppLocalizations l10n) async {
    try {
      await Clipboard.setData(ClipboardData(text: text));
      _showSnackBar(l10n.copied, AppColors.gold);
    } catch (e) {
      _showSnackBar(l10n.copyError, Colors.red);
    }
  }
}