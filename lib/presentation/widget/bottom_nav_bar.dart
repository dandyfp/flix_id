import 'package:flutter/material.dart';

import 'package:flix_id/presentation/widget/bottom_nav_bar_item.dart';

class BottomNavBar extends StatelessWidget {
  final List<BottomNavBarItem> items;
  final int selectedIndex;
  final void Function(int index) onTap;
  const BottomNavBar({
    Key? key,
    required this.items,
    required this.selectedIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: const Color.fromARGB(200, 12, 12, 17),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 0,
              offset: const Offset(0, -5),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...items
                .map((e) => GestureDetector(
                      onTap: () => onTap(e.index),
                      child: e,
                    ))
                .toList()
          ],
        ),
      ),
    );
  }
}
