import 'package:flutter/material.dart';
import '../constants/colors.dart';

class ThreeDCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  
  const ThreeDCard({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkerGreen,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: AppColors.gold.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.darkerGreen,
            AppColors.darkGreen,
          ],
        ),
        border: Border.all(
          color: AppColors.gold.withOpacity(0.3),
          width: 1,
        ),
      ),
      padding: padding ?? const EdgeInsets.all(16.0),
      child: child,
    );
  }
}