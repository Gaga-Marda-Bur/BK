import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../l10n/app_localizations.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function()? onMenuPressed;
  final String title;

  const CustomAppBar({
    super.key,
    this.onMenuPressed,
    required this.title,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return AppBar(
      backgroundColor: AppColors.darkGreenWithOpacity(0.5), // Transparent pour voir le dégradé en dessous
      elevation: 4, // Augmenter l'élévation pour l'ombre
      title: Text(
        title,
        style: TextStyle(
          color: AppColors.gold,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          shadows: const [
            Shadow(
              blurRadius: 4.0,
              color: Colors.black,
              offset: Offset(2.0, 2.0),
            ),
          ],
        ),
      ),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.darkerGreen, AppColors.darkGreen],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.blackOpacity05,
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.menu, color: AppColors.gold, size: 28),
        onPressed: onMenuPressed,
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.info_outline, color: AppColors.gold, size: 28),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: AppColors.darkGreen,
                  title: Text(locale.aboutBeriaErfe, style: const TextStyle(color: AppColors.gold)),
                  content: Text(
                    locale.aboutBeriaErfeDescription,
                    style: const TextStyle(color: Colors.white),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(locale.ok, style: const TextStyle(color: AppColors.gold)),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}