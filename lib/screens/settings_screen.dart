import 'package:flutter/material.dart';
import '../widgets/3d_card.dart';
import '../constants/colors.dart';
import '../services/storage_service.dart';
import '../l10n/app_localizations.dart';
import '../main.dart'; // Pour MyApp.setLocale

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final StorageService _storageService = StorageService();
  Map<String, dynamic> _settings = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final settings = await _storageService.getSettings();
    setState(() {
      _settings = settings;
      _isLoading = false;
    });
  }

  Future<void> _updateSetting(String key, dynamic value) async {
    setState(() {
      _settings[key] = value;
    });
    await _storageService.saveSettings(_settings);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    if (_isLoading) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.darkGreen, AppColors.darkerGreen],
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(color: AppColors.gold),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.darkGreen, AppColors.darkerGreen],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Paramètres principaux
            ThreeDCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loc.settingsTitle,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.gold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSettingSwitch(
                    title: loc.soundEffects,
                    value: _settings['soundEffects'] ?? true,
                    onChanged: (value) => _updateSetting('soundEffects', value),
                  ),
                  _buildSettingSwitch(
                    title: loc.vibrations,
                    value: _settings['vibrations'] ?? true,
                    onChanged: (value) => _updateSetting('vibrations', value),
                  ),
                  _buildSettingSwitch(
                    title: loc.autoSaveHistory,
                    value: _settings['autoSaveHistory'] ?? true,
                    onChanged: (value) => _updateSetting('autoSaveHistory', value),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Apparence
            ThreeDCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loc.appearance,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.gold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSettingSlider(
                    title: loc.defaultFontSize,
                    value: _settings['defaultFontSize']?.toDouble() ?? 24.0,
                    min: 16,
                    max: 32,
                    onChanged: (value) =>
                        _updateSetting('defaultFontSize', value.round()),
                  ),
                  _buildThemeSelector(),
                  const SizedBox(height: 16),
                  _buildLanguageSelector(),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Gestion des données
            ThreeDCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loc.dataManagement,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.gold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildActionButton(
                    title: loc.clearHistory,
                    onPressed: () async {
                      await _storageService.clearHistory();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(loc.historyCleared),
                          backgroundColor: AppColors.gold,
                        ),
                      );
                    },
                  ),
                  _buildActionButton(
                    title: loc.clearFavorites,
                    onPressed: () {
                      // TODO: Implémenter la suppression des favoris
                    },
                  ),
                  _buildActionButton(
                    title: loc.exportData,
                    onPressed: () {
                      // TODO: Implémenter l'exportation
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingSwitch({
    required String title,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return SwitchListTile(
      title: Text(title, style: const TextStyle(color: Colors.white)),
      value: value,
      onChanged: onChanged,
      activeThumbColor: AppColors.gold,
      inactiveTrackColor: Colors.grey,
    );
  }

  Widget _buildSettingSlider({
    required String title,
    required double value,
    required double min,
    required double max,
    required Function(double) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.white)),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: (max - min).round(),
          label: value.round().toString(),
          activeColor: AppColors.gold,
          inactiveColor: AppColors.goldOpacity03,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildThemeSelector() {
    final loc = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(loc.theme, style: const TextStyle(color: Colors.white)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            _buildThemeOption(loc.classic, 0),
            _buildThemeOption(loc.dark, 1),
            _buildThemeOption(loc.light, 2),
          ],
        ),
      ],
    );
  }

  Widget _buildThemeOption(String name, int value) {
    return ChoiceChip(
      label: Text(name),
      selected: _settings['theme'] == value,
      onSelected: (selected) => _updateSetting('theme', value),
      selectedColor: AppColors.gold,
      labelStyle: TextStyle(
        color: _settings['theme'] == value ? AppColors.darkGreen : Colors.black,
      ),
    );
  }

  Widget _buildLanguageSelector() {
    final loc = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(loc.language, style: const TextStyle(color: Colors.white)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            _buildLanguageOption('Français', 'fr'),
            _buildLanguageOption('English', 'en'),
            _buildLanguageOption('العربية', 'ar'),
          ],
        ),
      ],
    );
  }

  Widget _buildLanguageOption(String name, String localeCode) {
    return ChoiceChip(
      label: Text(name),
      selected: AppLocalizations.of(context)!.localeName == localeCode,
      onSelected: (selected) async {
        if (selected) {
          await _storageService.saveSettings({'locale': localeCode});
          MyApp.setLocale(context, Locale(localeCode));
        }
      },
      selectedColor: AppColors.gold,
      labelStyle: TextStyle(
        color: AppLocalizations.of(context)!.localeName == localeCode
            ? AppColors.darkGreen
            : Colors.black,
      ),
    );
  }

  Widget _buildActionButton({
    required String title,
    required Function() onPressed,
  }) {
    return ListTile(
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: Icon(Icons.arrow_forward, color: AppColors.gold),
      onTap: onPressed,
    );
  }
}
