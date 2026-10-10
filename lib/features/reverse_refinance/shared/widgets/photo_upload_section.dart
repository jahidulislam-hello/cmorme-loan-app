import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';

class PhotoUploadSection extends StatefulWidget {
  final List<File> photos;
  final int currentPhotoIndex;
  final VoidCallback onUploadTap;
  final ValueChanged<int>? onPageChanged;
  final int maxPhotos;

  const PhotoUploadSection({
    super.key,
    required this.photos,
    this.currentPhotoIndex = 0,
    required this.onUploadTap,
    this.onPageChanged,
    this.maxPhotos = 10,
  });

  @override
  State<PhotoUploadSection> createState() => _PhotoUploadSectionState();
}

class _PhotoUploadSectionState extends State<PhotoUploadSection> {
  late final PageController _stockPageController;
  Timer? _rotationTimer;
  int _currentStockIndex = 0;

  final List<String> _stockImages = [
    'https://images.unsplash.com/photo-1568605114967-8130f3a36994?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80',
    'https://images.unsplash.com/photo-1570129477492-45c003edd2be?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80',
    'https://images.unsplash.com/photo-1572120360610-d971b9d7767c?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80',
    'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80',
  ];

  @override
  void initState() {
    super.initState();
    _stockPageController = PageController();
    if (widget.photos.isEmpty) {
      _startRotation();
    }
  }

  @override
  void didUpdateWidget(PhotoUploadSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.photos.isEmpty && _rotationTimer == null) {
      _startRotation();
    } else if (widget.photos.isNotEmpty && _rotationTimer != null) {
      _stopRotation();
    }
  }

  @override
  void dispose() {
    _stopRotation();
    _stockPageController.dispose();
    super.dispose();
  }

  void _startRotation() {
    _rotationTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_stockPageController.hasClients) {
        _currentStockIndex = (_currentStockIndex + 1) % _stockImages.length;
        _stockPageController.animateToPage(
          _currentStockIndex,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
        setState(() {});
      }
    });
  }

  void _stopRotation() {
    _rotationTimer?.cancel();
    _rotationTimer = null;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.photos.isEmpty) {
      return _buildStockCarousel();
    }
    return _buildPhotoCarousel();
  }

  Widget _buildStockCarousel() {
    return GestureDetector(
      onTap: widget.onUploadTap,
      child: Container(
        width: double.infinity,
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              PageView.builder(
                controller: _stockPageController,
                itemCount: _stockImages.length,
                onPageChanged: (index) => setState(() => _currentStockIndex = index),
                itemBuilder: (context, index) {
                  return CachedNetworkImage(
                    imageUrl: _stockImages[index],
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: AppColors.containerHighlight,
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: AppColors.containerHighlight,
                      child: const Icon(Icons.home, size: 50, color: AppColors.hintGrey),
                    ),
                  );
                },
              ),
              // Gradient Overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.6),
                      ],
                    ),
                  ),
                ),
              ),
              // Upload Button Overlay
              // Center(
              //   child: GestureDetector(
              //     onTap: widget.onUploadTap,
              //     child: Container(
              //       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              //       decoration: BoxDecoration(
              //         color: AppColors.buttonBlue.withOpacity(0.9),
              //         borderRadius: BorderRadius.circular(30),
              //         boxShadow: [
              //           BoxShadow(
              //             color: Colors.black.withOpacity(0.3),
              //             blurRadius: 8,
              //             offset: const Offset(0, 2),
              //           ),
              //         ],
              //       ),
              //       child: Row(
              //         mainAxisSize: MainAxisSize.min,
              //         children: [
              //           const Icon(Icons.add_a_photo, color: AppColors.white, size: 20),
              //           const SizedBox(width: 8),
              //           Text(
              //             'Upload ${widget.maxPhotos} Photos',
              //             style: const TextStyle(
              //               color: AppColors.white,
              //               fontSize: 14,
              //               fontWeight: FontWeight.bold,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              // Page Indicators
              Positioned(
                bottom: 15,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_stockImages.length, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: _currentStockIndex == index ? 20 : 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: _currentStockIndex == index
                            ? AppColors.white
                            : AppColors.white.withOpacity(0.5),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoCarousel() {
    return SizedBox(
      width: double.infinity,
      height: 180,
      child: Stack(
        children: [
          PageView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: widget.photos.length,
            onPageChanged: widget.onPageChanged,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.file(
                  widget.photos[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              );
            },
          ),
          if (widget.photos.length > 1)
            Positioned(
              left: 0,
              right: 0,
              bottom: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.photos.length, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: widget.currentPhotoIndex == index ? 20 : 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: index == widget.currentPhotoIndex
                          ? AppColors.white
                          : AppColors.white.withOpacity(0.5),
                    ),
                  );
                }),
              ),
            ),
          // Delete/Edit button overlay could be added here if needed
        ],
      ),
    );
  }
}
