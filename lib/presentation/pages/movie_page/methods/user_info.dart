import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget userInfo(WidgetRef ref) => Padding(
      padding: const EdgeInsets.fromLTRB(24, 2, 24, 0),
      child: Row(
        children: [
          Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
                image: DecorationImage(
                    image: ref.watch(userDataProvider).valueOrNull?.photoUrl != null
                        ? NetworkImage(ref.watch(userDataProvider).valueOrNull!.photoUrl!) as ImageProvider
                        : const AssetImage('assets/pp-placeholder.png'))),
          ),
        ],
      ),
    );
