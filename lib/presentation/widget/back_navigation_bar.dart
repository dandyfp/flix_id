import 'package:flutter/material.dart';

import 'package:flix_id/presentation/misc/methods.dart';

class BackNavigationBar extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const BackNavigationBar({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: SizedBox(
            height: 40,
            width: 40,
            child: Image.asset('assets/back.png'),
          ),
        ),
        horizontalSpace(20),
        SizedBox(
          width: MediaQuery.of(context).size.width - 60 - 48,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
