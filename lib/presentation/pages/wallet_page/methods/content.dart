import 'package:flix_id/presentation/extentions/int_extension.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget content(WidgetRef ref) => Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 50, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Current Balance',
                style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.5)),
              ),
              Text(
                (ref.watch(userDataProvider).valueOrNull?.balance ?? 0).toIDRCurrencyFormat(),
                style: const TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              verticalSpace(10),
              Text(ref.watch(userDataProvider).valueOrNull?.name ?? ''),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => ref.read(userDataProvider.notifier).topUp(100000),
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey.shade800,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.orange,
                  ),
                ),
              ),
              const Text(
                'Top Up',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                ),
              )
            ],
          )
        ],
      ),
    );
