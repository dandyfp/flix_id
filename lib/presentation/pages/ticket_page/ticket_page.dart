import 'package:flix_id/presentation/providers/transaction_data/transaction_data_provider.dart';
import 'package:flix_id/presentation/widget/ticket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TicketPage extends ConsumerWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: ref.watch(transactionDataProvider).when(
                    data: (transaction) => (transaction
                            .where((element) => element.title != 'Top up' && element.watchingTime! >= DateTime.now().millisecondsSinceEpoch)
                            .toList()
                          ..sort((a, b) => a.watchingTime!.compareTo(b.watchingTime!)))
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Ticket(transaction: e),
                          ),
                        )
                        .toList(),
                    error: (error, stackTrace) => [],
                    loading: () => [const CircularProgressIndicator()],
                  )),
        ),
      ],
    );
  }
}
