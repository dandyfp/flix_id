import 'dart:math';

import 'package:flix_id/presentation/pages/seat_booking_page/movie_screen.dart';
import 'package:flix_id/presentation/providers/router/router_provider.dart';
import 'package:flix_id/presentation/widget/back_navigation_bar.dart';
import 'package:flix_id/presentation/widget/seat.dart';
import 'package:flutter/material.dart';

import 'package:flix_id/domain/entities/movie_detail.dart';
import 'package:flix_id/domain/entities/transaction.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SeatBookingPage extends ConsumerStatefulWidget {
  final (MovieDetail, Transaction) transactionDetail;
  const SeatBookingPage({
    Key? key,
    required this.transactionDetail,
  }) : super(key: key);

  @override
  ConsumerState<SeatBookingPage> createState() => _SeatBookingPageState();
}

class _SeatBookingPageState extends ConsumerState<SeatBookingPage> {
  List<int> selectedSeats = [];
  List<int> reservedSeats = [];
  @override
  void initState() {
    super.initState();
    Random random = Random();
    int reservedNumber = random.nextInt(36) + 1;

    while (reservedSeats.length < 8) {
      if (!reservedSeats.contains(reservedNumber)) {
        reservedSeats.add(reservedNumber);
      }
      reservedNumber = random.nextInt(36) + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final (movieDetail, transaction) = widget.transactionDetail;
    return Scaffold(
        body: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              BackNavigationBar(
                title: movieDetail.title,
                onTap: () {
                  ref.read(routerProvider).pop();
                },
              ),
              movieScreen(),
              //seats(2 section)
              //legend
              //number of selected screen
              //button
            ],
          ),
        )
      ],
    ));
  }
}
