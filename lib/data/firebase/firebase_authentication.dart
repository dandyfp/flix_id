import 'package:firebase_auth/firebase_auth.dart';
import 'package:flix_id/data/repositories/authentication.dart';
import 'package:flix_id/domain/entities/result.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';

/// Implementation of [Authentication] using Firebase Authentication
/// and Google Sign-In for user authentication.
class FirebaseAuthentication implements Authentication {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  /// Constructor for [FirebaseAuthentication].
  ///
  /// [firebaseAuth] is an instance of [FirebaseAuth] used for authentication.
  /// If not provided, the default instance will be used.
  FirebaseAuthentication({firebase_auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  /// Retrieves the user ID of the currently logged-in user.
  ///
  /// Returns the user ID as a string if a user is logged in, or null if no user is logged in.
  @override
  String? getLoggedInUserId() => _firebaseAuth.currentUser?.uid;

  /// Logs in a user with the provided [email] and [password].
  ///
  /// Returns [Result.success] with the user ID if successful,
  /// or [Result.failed] with an error message if failed.
  @override
  Future<Result<String>> login(
      {required String email, required String password}) async {
    try {
      var userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Result.success(userCredential.user!.uid);
    } on firebase_auth.FirebaseException catch (e) {
      return Result.failed(e.message!);
    }
  }

  /// Logs out the currently logged-in user.
  ///
  /// Returns [Result.success] if successful,
  /// or [Result.failed] with an error message if failed.
  @override
  Future<Result<void>> logout() async {
    await _firebaseAuth.signOut();
    if (_firebaseAuth.currentUser == null) {
      return const Result.success(null);
    } else {
      return const Result.failed("failed to sign out");
    }
  }

  /// Registers a new user with the provided [email] and [password].
  ///
  /// Returns [Result.success] with the user ID if successful,
  /// or [Result.failed] with an error message if failed.
  @override
  Future<Result<String>> register(
      {required String email, required String password}) async {
    try {
      var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return Result.success(userCredential.user!.uid);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Result.failed("${e.message}");
    }
  }

  /// Logs in a user using Single Sign-On (SSO) with Google Sign-In.
  ///
  /// Returns [Result.success] with the user ID if successful,
  /// or [Result.failed] with an error message if failed.
  @override
  Future<Result<String>> loginSSO() async {
    try {
      await googleSignIn.signOut();
      await _firebaseAuth.signOut();
      var resultSSO = await googleSignIn.signIn();
      var ggAuth = await resultSSO?.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: ggAuth?.accessToken,
        idToken: ggAuth?.idToken,
      );
      var result = await _firebaseAuth.signInWithCredential(credential);
      return Result.success(result.user!.uid);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Result.failed(e.message ?? '');
    }
  }
}
