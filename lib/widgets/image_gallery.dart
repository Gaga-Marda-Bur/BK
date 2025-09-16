import 'package:flutter/material.dart';
import '../constants/colors.dart';

class ImageGallery extends StatelessWidget {
  final List<Map<String, dynamic>> images;
  final Function(Map<String, dynamic>)? onToggleFavorite;
  final bool Function(Map<String, dynamic>)? isFavorite;

  const ImageGallery({
    super.key,
    required this.images,
    this.onToggleFavorite,
    this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        return _buildImageCard(images[index]);
      },
    );
  }

  Widget _buildImageCard(Map<String, dynamic> imageData) {
  final isFav = isFavorite?.call(imageData) ?? false;

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: AppColors.blackOpacity03,
          spreadRadius: 1,
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          // ✅ Image réelle
          Image.asset(
            imageData['path'],
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: AppColors.darkerGreen,
                child: Center(
                  child: Text(
                    imageData['character'] ?? '?',
                    style: const TextStyle(
                      fontFamily: 'Kedebideri',
                      fontSize: 32,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),

          // Bouton favori
          if (onToggleFavorite != null)
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: () => onToggleFavorite!(imageData),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.blackOpacity05,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isFav ? Icons.star : Icons.star_border,
                    color: isFav ? AppColors.gold : Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),

          // Overlay titre
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    AppColors.blackOpacity08,
                    Colors.transparent,
                  ],
                ),
              ),
              child: Text(
                imageData['title']!,
                style: const TextStyle(
                  fontFamily: "Kedebideri",
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

}