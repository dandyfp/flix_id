import 'package:flutter/material.dart';

class NetworkImageCard extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final String? imageUrl;
  final BoxFit? boxFit;
  final VoidCallback? onTap;
  const NetworkImageCard({
    Key? key,
    this.width = 150,
    this.height = 228,
    this.borderRadius = 10,
    this.imageUrl,
    this.boxFit,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Stack(
          children: [
            if (imageUrl != null)
              const Center(
                child: CircularProgressIndicator(),
              ),
            if (imageUrl != null)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl!),
                    fit: boxFit,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
