import 'package:flix_id/presentation/misc/constans.dart';
import 'package:flutter/material.dart';

class SelectableCard extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool isSelected;
  final bool isEnable;
  const SelectableCard({
    Key? key,
    required this.text,
    this.onTap,
    this.isSelected = false,
    this.isEnable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnable ? onTap : null,
      child: Container(
        decoration: BoxDecoration(
            color: isSelected ? saffron.withOpacity(0.3) : null,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: isEnable ? saffron : Colors.grey)),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isEnable ? ghostWhite : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
