import 'package:flutter/material.dart';

class NetworkImageCard extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final String imageUrl;
  final BoxFit boxFit;
  final VoidCallback onTap;
  const NetworkImageCard({
    Key? key,
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.imageUrl,
    required this.boxFit,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}
