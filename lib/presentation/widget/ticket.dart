import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/widget/network_image_card.dart';
import 'package:flutter/material.dart';

import 'package:flix_id/domain/entities/transaction.dart';
import 'package:intl/intl.dart';

class Ticket extends StatelessWidget {
  final Transaction transaction;
  const Ticket({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF252836),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Text(
              transaction.id.toString(),
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: NetworkImageCard(
                  height: 114,
                  width: 75,
                  imageUrl: 'https://image.tmdb.org/t/p/w500${transaction.transactionImage}',
                  boxFit: BoxFit.cover,
                ),
              ),
              Expanded(
                  child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    verticalSpace(10),
                    Text(
                      transaction.theaterName ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    verticalSpace(10),
                    Text(
                      DateFormat('EEE, d MMMM y | HH:mm').format(DateTime.fromMillisecondsSinceEpoch(transaction.watchingTime!)),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    verticalSpace(10),
                    Text(
                      '${transaction.ticketAmound} Ticket (${transaction.seats.join(',')})',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )),
            ],
          )
        ],
      ),
    );
  }
}
