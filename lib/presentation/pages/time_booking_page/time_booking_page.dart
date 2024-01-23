import 'package:flix_id/domain/entities/movie_detail.dart';
import 'package:flix_id/domain/entities/transaction.dart';
import 'package:flix_id/presentation/extentions/build_context_extension.dart';
import 'package:flix_id/presentation/misc/constans.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/pages/time_booking_page/methods/options.dart';
import 'package:flix_id/presentation/providers/router/router_provider.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flix_id/presentation/widget/back_navigation_bar.dart';
import 'package:flix_id/presentation/widget/network_image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class TimeBookingPage extends ConsumerStatefulWidget {
  final MovieDetail movieDetail;
  const TimeBookingPage(
    this.movieDetail, {
    super.key,
  });

  @override
  ConsumerState<TimeBookingPage> createState() => _TimeBookingPageState();
}

class _TimeBookingPageState extends ConsumerState<TimeBookingPage> {
  final List<String> theathers = [
    'XXI Chadstone',
    'XXI SGC',
    'Cinepolis MLC',
  ];

  final List<DateTime> dates = List.generate(7, (index) {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    return date.add(Duration(days: index));
  });

  final List<int> hours = List.generate(8, (index) => index + 12);
  DateTime? selectedDate;
  int? selectedHour;
  String? selectedTheater;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: BackNavigationBar(
                title: widget.movieDetail.title,
                onTap: () => Navigator.pop(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: NetworkImageCard(
                boxFit: BoxFit.cover,
                width: MediaQuery.of(context).size.width - 48,
                height: (MediaQuery.of(context).size.width - 48) * 0.6,
                borderRadius: 15,
                imageUrl: 'https://image.tmdb.org/t/p/w500${widget.movieDetail.backdropPath}',
              ),
            ),
            ...options(
              title: 'Select a teather',
              options: theathers,
              selectedItem: selectedTheater,
              onTap: (object) => setState(() {
                selectedTheater = object;
              }),
            ),
            verticalSpace(24),
            ...options<DateTime>(
              title: 'Select date',
              options: dates,
              selectedItem: selectedDate,
              converter: (date) => DateFormat('EEE,d MMMMy').format(date),
              onTap: (object) => setState(() {
                selectedDate = object;
              }),
            ),
            verticalSpace(24),
            ...options(
              title: 'Select show time',
              options: hours,
              selectedItem: selectedHour,
              converter: (object) => '$object:00',
              isOptionEnable: (hour) =>
                  selectedDate != null &&
                  DateTime(selectedDate!.year, selectedDate!.month, selectedDate!.day, hour).isAfter(
                    DateTime.now(),
                  ),
              onTap: (object) => setState(() {
                selectedHour = object;
              }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 40,
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: backgroundColor,
                      backgroundColor: saffron,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
                    if (selectedDate == null || selectedHour == null || selectedHour == null) {
                      context.showSnackBar('Please select all options');
                    } else {
                      Transaction transaction = Transaction(
                        uid: ref.read(userDataProvider).value!.uid,
                        title: widget.movieDetail.title,
                        adminFee: 3000,
                        total: 0,
                        transactionImage: widget.movieDetail.posterPath,
                        theaterName: selectedTheater,
                        watchingTime: DateTime(
                          selectedDate!.year,
                          selectedDate!.month,
                          selectedDate!.day,
                          selectedHour!,
                        ).millisecondsSinceEpoch,
                      );
                      ref.read(routerProvider).pushNamed(
                        'seat-booking',
                        extra: (widget.movieDetail, transaction),
                      );
                    }
                  },
                  child: const Text('Next'),
                ),
              ),
            )
          ],
        )
      ],
    ));
  }
}
