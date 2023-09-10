import 'package:flix_id/domain/entities/result.dart';
import 'package:flix_id/domain/entities/transaction.dart';

abstract interface class TransactionRepository {
  Future<Result<Transaction>> cretateTransaction({required Transaction transaction});
  Future<Result<Transaction>> getUserTransactions({required String uid});
}
