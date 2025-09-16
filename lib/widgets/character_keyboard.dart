import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../l10n/app_localizations.dart';

class CharacterKeyboard extends StatelessWidget {
  final void Function(String) onCharacterTap;
  final VoidCallback onDelete;
  final VoidCallback onClear;

  CharacterKeyboard({
    super.key,
    required this.onCharacterTap,
    required this.onDelete,
    required this.onClear,
  });

  final List<String> sampleCharacters = [
    '𖺠', '𖺡', '𖺢', '𖺣', '𖺤', '𖺥', '𖺦', '𖺧', '𖺨', '𖺩',
    '𖺪', '𖺫', '𖺬', '𖺭', '𖺮', '𖺯', '𖺰', '𖺱', '𖺲', '𖺳',
    '𖺴', '𖺵', '𖺶', '𖺷', '𖺸'
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final locale = AppLocalizations.of(context)!;

    final crossAxisCount = _calculateCrossAxisCount(screenWidth);
    final characterSize = _calculateCharacterSize(screenWidth);
    final spacing = _calculateSpacing(screenWidth);

    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
            childAspectRatio: 1,
          ),
          itemCount: sampleCharacters.length,
          itemBuilder: (context, index) {
            final char = sampleCharacters[index];
            return _buildCharacterButton(char, characterSize, spacing);
          },
        ),
        const SizedBox(height: 16),
        _buildActionBar(locale),
      ],
    );
  }

  Widget _buildActionBar(AppLocalizations locale) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWideScreen = constraints.maxWidth > 600;

        return Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: [
            _buildDeleteButton(isWideScreen, locale),
            _buildSpaceButton(isWideScreen, locale),
            _buildClearButton(isWideScreen, locale),
          ],
        );
      },
    );
  }

  Widget _buildDeleteButton(bool isWide, AppLocalizations locale) {
    return SizedBox(
      width: isWide ? 180 : double.infinity,
      child: ElevatedButton.icon(
        onPressed: onDelete,
        icon: const Icon(Icons.backspace),
        label: Text(locale.delete),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkGreen,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: AppColors.gold),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          textStyle: TextStyle(fontSize: isWide ? 16 : 14),
        ),
      ),
    );
  }

  Widget _buildSpaceButton(bool isWide, AppLocalizations locale) {
    return SizedBox(
      width: isWide ? 180 : double.infinity,
      child: ElevatedButton(
        onPressed: () => onCharacterTap(" "),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.gold,
          foregroundColor: AppColors.darkGreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          textStyle: TextStyle(
            fontSize: isWide ? 16 : 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        child: Text(locale.space),
      ),
    );
  }

  Widget _buildClearButton(bool isWide, AppLocalizations locale) {
    return SizedBox(
      width: isWide ? 180 : double.infinity,
      child: ElevatedButton.icon(
        onPressed: onClear,
        icon: const Icon(Icons.delete),
        label: Text(locale.clear),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.shade700,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          textStyle: TextStyle(fontSize: isWide ? 16 : 14),
        ),
      ),
    );
  }

  int _calculateCrossAxisCount(double screenWidth) {
    if (screenWidth > 1000) return 12;
    if (screenWidth > 700) return 10;
    if (screenWidth > 500) return 8;
    if (screenWidth > 400) return 6;
    return 6;
  }

  double _calculateCharacterSize(double screenWidth) {
    if (screenWidth < 400) return 18;
    if (screenWidth < 500) return 20;
    if (screenWidth < 700) return 24;
    return 26;
  }

  double _calculateSpacing(double screenWidth) {
    if (screenWidth > 1000) return 12;
    if (screenWidth > 700) return 10;
    if (screenWidth > 500) return 8;
    if (screenWidth > 400) return 6;
    return 4;
  }

  Widget _buildCharacterButton(String char, double size, double spacing) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onCharacterTap(char),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.all(spacing),
          decoration: BoxDecoration(
            color: AppColors.darkGreen,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.gold),
            boxShadow: [
              BoxShadow(
                color: AppColors.blackOpacity03,
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
              BoxShadow(
                color: AppColors.goldOpacity03,
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, -1),
              ),
            ],
          ),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              char,
              style: TextStyle(
                fontFamily: 'Kedebideri',
                fontSize: size,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
