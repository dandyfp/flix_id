import 'package:firebase_auth/firebase_auth.dart';
import 'package:flix_id/data/repositories/authentication.dart';
import 'package:flix_id/domain/entities/result.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthentication implements Authentication {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  FirebaseAuthentication({firebase_auth.FirebaseAuth? firebaseAuth}) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  @override
  String? getLoggedInUserId() => _firebaseAuth.currentUser?.uid;

  @override
  Future<Result<String>> login({required String email, required String password}) async {
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

  @override
  Future<Result<void>> logout() async {
    await _firebaseAuth.signOut();
    if (_firebaseAuth.currentUser == null) {
      return const Result.success(null);
    } else {
      return const Result.failed("failed to sign out");
    }
  }

  @override
  Future<Result<String>> register({required String email, required String password}) async {
    try {
      var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return Result.success(userCredential.user!.uid);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Result.failed("${e.message}");
    }
  }

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
