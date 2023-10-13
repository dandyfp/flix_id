import 'package:flutter/material.dart';

class BottomNavBarItem extends StatelessWidget {
  final String image;
  final String selectedImage;
  final String title;
  final bool isSelected;
  final int index;
  const BottomNavBarItem({
    Key? key,
    required this.image,
    required this.selectedImage,
    required this.title,
    required this.isSelected,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 25,
          width: 25,
          child: Image.asset(isSelected ? selectedImage : image),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
