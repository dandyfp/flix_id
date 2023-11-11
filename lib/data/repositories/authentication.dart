import 'package:flix_id/domain/entities/result.dart';

abstract interface class Authentication {
  Future<Result<String>> login({required String email, required String password});
  Future<Result<String>> register({required String email, required String password});
  Future<Result<void>> logout();
  Future<Result<String>> loginSSO();
  String? getLoggedInUserId();
}
