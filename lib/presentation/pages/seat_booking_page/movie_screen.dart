import 'package:flix_id/presentation/misc/constans.dart';
import 'package:flutter/material.dart';

Widget movieScreen() => Container(
      width: 250,
      height: 50,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [saffron.withOpacity(0.33), Colors.transparent],
        ),
      ),
    );
