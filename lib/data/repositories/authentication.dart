import 'package:flix_id/domain/entities/result.dart';

/// An abstract interface class for authentication operations.
abstract interface class Authentication {
  /// Logs in a user with the provided [email] and [password].
  ///
  /// Returns [Result.success] with the user ID if successful,
  /// or [Result.failed] with an error message if failed.
  Future<Result<String>> login(
      {required String email, required String password});

  /// Registers a new user with the provided [email] and [password].
  ///
  /// Returns [Result.success] with the user ID if successful,
  /// or [Result.failed] with an error message if failed.
  Future<Result<String>> register(
      {required String email, required String password});

  /// Logs out the currently logged-in user.
  ///
  /// Returns [Result.success] if successful,
  /// or [Result.failed] with an error message if failed.
  Future<Result<void>> logout();

  /// Logs in a user using Single Sign-On (SSO).
  ///
  /// Returns [Result.success] with the user ID if successful,
  /// or [Result.failed] with an error message if failed.
  Future<Result<String>> loginSSO();

  /// Retrieves the user ID of the currently logged-in user.
  ///
  /// Returns the user ID as a string if a user is logged in, or null if no user is logged in.
  String? getLoggedInUserId();
}
