import 'package:flix_id/domain/entities/movie_detail.dart';
import 'package:flix_id/domain/entities/result.dart';
import 'package:flix_id/domain/entities/transaction.dart';
import 'package:flix_id/domain/usecases/create_transaction/create_transaction.dart';
import 'package:flix_id/domain/usecases/create_transaction/create_transaction_param.dart';
import 'package:flix_id/presentation/extentions/build_context_extension.dart';
import 'package:flix_id/presentation/extentions/int_extension.dart';
import 'package:flix_id/presentation/misc/constans.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/pages/booking_confirmation_page/metods/transaction_row.dart';
import 'package:flix_id/presentation/providers/router/router_provider.dart';
import 'package:flix_id/presentation/providers/transaction_data/transaction_data_provider.dart';
import 'package:flix_id/presentation/providers/usecase/create_transaction_provider.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flix_id/presentation/widget/back_navigation_bar.dart';
import 'package:flix_id/presentation/widget/network_image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class BookingConfirmationPage extends ConsumerWidget {
  final (MovieDetail, Transaction) transactionDetail;
  const BookingConfirmationPage({required this.transactionDetail, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var (movieDetail, transaction) = transactionDetail;
    transaction = transaction.copyWith(total: transaction.ticketAmound! * transaction.ticketPrice! + transaction.adminFee);

    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
            child: Column(
              children: [
                BackNavigationBar(
                  title: 'Booking Confirmation',
                  onTap: () => ref.read(routerProvider).pop(),
                ),
                verticalSpace(24),
                NetworkImageCard(
                  borderRadius: 15,
                  boxFit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width - 48,
                  height: (MediaQuery.of(context).size.width - 48) * 0.6,
                  imageUrl: "https://image.tmdb.org/t/p/w500${movieDetail.backdropPath ?? movieDetail.posterPath}",
                ),
                verticalSpace(24),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 48,
                  child: Text(
                    transaction.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                verticalSpace(5),
                const Divider(
                  color: ghostWhite,
                ),
                verticalSpace(5),
                transcationRow(
                  title: 'Showing Date',
                  value: DateFormat('EEEE, d MMMM y').format(DateTime.fromMicrosecondsSinceEpoch(transaction.watchingTime ?? 0)),
                  width: MediaQuery.of(context).size.width - 48,
                ),
                transcationRow(
                  title: 'Theater',
                  value: '${transaction.theaterName}',
                  width: MediaQuery.of(context).size.width - 48,
                ),
                transcationRow(
                  title: 'Seat Numbers',
                  value: transaction.seats.join(', '),
                  width: MediaQuery.of(context).size.width - 48,
                ),
                transcationRow(
                  title: '# of Tickets',
                  value: '${transaction.ticketAmound} ticket(s)',
                  width: MediaQuery.of(context).size.width - 48,
                ),
                transcationRow(
                  title: 'Ticket Price',
                  value: '${transaction.ticketPrice?.toIDRCurrencyFormat()}',
                  width: MediaQuery.of(context).size.width - 48,
                ),
                transcationRow(
                  title: 'Adm. Fee',
                  value: transaction.adminFee.toIDRCurrencyFormat(),
                  width: MediaQuery.of(context).size.width - 48,
                ),
                const Divider(
                  color: ghostWhite,
                ),
                transcationRow(
                  title: 'Total Price',
                  value: transaction.total.toIDRCurrencyFormat(),
                  width: MediaQuery.of(context).size.width - 48,
                ),
                verticalSpace(40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      int transactionTime = DateTime.now().millisecondsSinceEpoch;

                      transaction = transaction.copyWith(
                        transactionTime: transactionTime,
                        id: 'flx-$transactionTime-${transaction.uid}',
                      );

                      CreateTransaction createTransaction = ref.read(createTransactionProvider);

                      await createTransaction(CreateTransactionParam(transaction: transaction)).then((result) {
                        switch (result) {
                          case Success(value: _):
                            ref.read(transactionDataProvider.notifier);
                            ref.read(userDataProvider.notifier);
                            ref.read(routerProvider).goNamed('main');
                          case Failed(:final message):
                            context.showSnackBar(message);
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: backgroundColor,
                        backgroundColor: saffron,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    child: const Text('Pay Now'),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
