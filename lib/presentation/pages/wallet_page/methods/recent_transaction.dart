import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/providers/transaction_data/transaction_data_provider.dart';
import 'package:flix_id/presentation/widget/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<Widget> recentTransaction(WidgetRef ref) => [
      const Text(
        'Recent Transaction',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      verticalSpace(24),
      ...ref.watch(transactionDataProvider).when(
            data: (transactions) => transactions.isEmpty
                ? []
                : (transactions
                      ..sort(
                        (a, b) => -a.transactionTime!.compareTo(b.transactionTime!),
                      ))
                    .map((e) => TransactionCard(transaction: e))
                    .toList(),
            error: (error, stackTrace) => [],
            loading: () => [
              const Center(
                child: CircularProgressIndicator(),
              ),
            ],
          ),
    ];
