import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flix_id/data/repositories/user_repository.dart';
import 'package:flix_id/domain/entities/movie.dart';
import 'package:flix_id/domain/entities/result.dart';
import 'package:flix_id/domain/entities/user.dart';
import 'package:path/path.dart';

/// Implementation of [UserRepository] using Firebase Firestore
/// and Firebase Storage to store and retrieve user data.
class FirebaseUserRepository implements UserRepository {
  final FirebaseFirestore _firebaseFirestore;

  /// Constructor for [FirebaseUserRepository].
  ///
  /// [firebaseFirestore] is an instance of [FirebaseFirestore] used
  /// to access Firestore. If not provided, the default instance will be used.
  FirebaseUserRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  /// Creates a new user in Firestore with [uid], [email], [name],
  /// [photoUrl], and [balance].
  ///
  /// Returns [Result.success] with user data if successful,
  /// or [Result.failed] with an error message if failed.
  @override
  Future<Result<User>> createUser({
    required String uid,
    required String email,
    required String name,
    String? photoUrl,
    int balance = 0,
  }) async {
    CollectionReference<Map<String, dynamic>> users =
        _firebaseFirestore.collection('users');
    await users.doc(uid).set({
      'uid': uid,
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
      'balance': balance,
    });

    DocumentSnapshot<Map<String, dynamic>> result = await users.doc(uid).get();
    if (result.exists) {
      return Result.success(
        User.fromJson(result.data()!),
      );
    } else {
      return const Result.failed('failed to create user');
    }
  }

  /// Retrieves user data from Firestore with [uid].
  ///
  /// Returns [Result.success] with user data if found,
  /// or [Result.failed] with an error message if not found.
  @override
  Future<Result<User>> getUser({required String uid}) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        _firebaseFirestore.doc('users/$uid');

    DocumentSnapshot<Map<String, dynamic>> result =
        await documentReference.get();
    if (result.exists) {
      return Result.success(User.fromJson(result.data()!));
    } else {
      return const Result.failed('User not found');
    }
  }

  /// Retrieves user's balance from Firestore with [uid].
  ///
  /// Returns [Result.success] with user's balance if found,
  /// or [Result.failed] with an error message if not found.
  @override
  Future<Result<int>> getUserBalance({required String uid}) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        _firebaseFirestore.doc('users/$uid');

    DocumentSnapshot<Map<String, dynamic>> result =
        await documentReference.get();
    if (result.exists) {
      return Result.success(result.data()!['balance']);
    } else {
      return const Result.failed('User not found');
    }
  }

  /// Updates user data in Firestore.
  ///
  /// Returns [Result.success] with updated user data if successful,
  /// or [Result.failed] with an error message if failed.
  @override
  Future<Result<User>> updateUser({required User user}) async {
    try {
      DocumentReference<Map<String, dynamic>> documentReference =
          _firebaseFirestore.doc('users/${user.uid}');
      await documentReference.update(user.toJson());

      DocumentSnapshot<Map<String, dynamic>> result =
          await documentReference.get();

      if (result.exists) {
        User updateUser = User.fromJson(result.data()!);
        if (updateUser == user) {
          return Result.success(updateUser);
        } else {
          return const Result.failed('Failed to update user');
        }
      } else {
        return const Result.failed('Failed to update user');
      }
    } on FirebaseException catch (e) {
      return Result.failed(e.message ?? 'Failed to update user');
    }
  }

  /// Updates user's balance in Firestore.
  ///
  /// Returns [Result.success] with updated user data if successful,
  /// or [Result.failed] with an error message if failed.
  @override
  Future<Result<User>> updateUserBalance(
      {required String uid, required int balance}) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        _firebaseFirestore.doc('users/$uid');

    DocumentSnapshot<Map<String, dynamic>> result =
        await documentReference.get();
    if (result.exists) {
      await documentReference.update({'balance': balance});
      DocumentSnapshot<Map<String, dynamic>> updatedResult =
          await documentReference.get();

      if (updatedResult.exists) {
        User updatedUser = User.fromJson(updatedResult.data()!);
        if (updatedUser.balance == balance) {
          return Result.success(updatedUser);
        } else {
          return const Result.failed('Failed to update user balace');
        }
      } else {
        return const Result.failed('Failed to retrive update user balance');
      }
    } else {
      return const Result.failed('User not found');
    }
  }

  /// Uploads user's profile picture to Firebase Storage and updates
  /// the profile picture URL in Firestore.
  ///
  /// Returns [Result.success] with updated user data if successful,
  /// or [Result.failed] with an error message if failed.
  @override
  Future<Result<User>> uploadProfilePicture({
    required User user,
    required File imageFile,
  }) async {
    String fileName = basename(imageFile.path);

    Reference reference = FirebaseStorage.instance.ref().child(fileName);

    try {
      await reference.putFile(imageFile);
      String downloadUrl = await reference.getDownloadURL();
      var updatedUser =
          await updateUser(user: user.copyWith(photoUrl: downloadUrl));

      if (updatedUser.isSuccess) {
        return Result.success(updatedUser.resultValue!);
      } else {
        return const Result.failed('Failed to upload profile picture');
      }
    } catch (e) {
      return const Result.failed('Failed to upload profile picture');
    }
  }

  /// Adds a movie to the user's watchlist in Firestore.
  ///
  /// Returns [Result.success] if successful, or [Result.failed]
  /// with an error message if failed.
  @override
  Future<Result<void>> addToWatchlist({
    required String uid,
    required Movie movie,
  }) async {
    CollectionReference<Map<String, dynamic>> watchlist =
        _firebaseFirestore.collection('watchlist');

    try {
      await watchlist.doc(movie.id.toString()).set({
        'id': movie.id,
        'title': movie.title,
        'poster_path': movie.posterPath,
        'addedAt': FieldValue.serverTimestamp(),
        'uid': uid,
      });
      return const Result.success(null);
    } catch (e) {
      return Result.failed(e.toString());
    }
  }

  /// Adds a movie to the user's favorite list in Firestore.
  ///
  /// Returns [Result.success] if successful, or [Result.failed]
  /// with an error message if failed.
  @override
  Future<Result<void>> addToFavorite({
    required String uid,
    required Movie movie,
  }) async {
    CollectionReference<Map<String, dynamic>> watchlist =
        _firebaseFirestore.collection('favoritelist');

    try {
      await watchlist.doc(movie.id.toString()).set({
        'id': movie.id,
        'title': movie.title,
        'poster_path': movie.posterPath,
        'addedAt': FieldValue.serverTimestamp(),
        'uid': uid,
      });
      return const Result.success(null);
    } catch (e) {
      return Result.failed(e.toString());
    }
  }

  /// Retrieves the user's watchlist from Firestore with [uid].
  ///
  /// Returns [Result.success] with a list of movies if successful,
  /// or [Result.failed] with an error message if failed.
  @override
  Future<Result<List<Movie>>> getWatchlist(String uid) async {
    CollectionReference<Map<String, dynamic>> watchList =
        _firebaseFirestore.collection('watchlist');
    try {
      var result = await watchList.where('uid', isEqualTo: uid).get();

      if (result.docs.isNotEmpty) {
        return Result.success(
          result.docs.map((e) => Movie.fromJSON(e.data())).toList(),
        );
      } else {
        return const Result.success([]);
      }
    } catch (e) {
      return const Result.failed('Failed to get user watchlist');
    }
  }

  /// Retrieves the user's favorite list from Firestore with [uid].
  ///
  /// Returns [Result.success] with a list of movies if successful,
  /// or [Result.failed] with an error message if failed.
  @override
  Future<Result<List<Movie>>> getFavoriteList(String uid) async {
    CollectionReference<Map<String, dynamic>> watchList =
        _firebaseFirestore.collection('favoritelist');
    try {
      var result = await watchList.where('uid', isEqualTo: uid).get();

      if (result.docs.isNotEmpty) {
        return Result.success(
          result.docs.map((e) => Movie.fromJSON(e.data())).toList(),
        );
      } else {
        return const Result.success([]);
      }
    } catch (e) {
      return const Result.failed('Failed to get user favoritelist');
    }
  }

  /// Deletes a movie from the user's watchlist in Firestore.
  ///
  /// Returns [Result.success] if successful, or [Result.failed]
  /// with an error message if failed.
  @override
  Future<Result<void>> deleteMovieFromWatchlist({
    required String uid,
    required String movieId,
  }) async {
    CollectionReference<Map<String, dynamic>> watchlist =
        _firebaseFirestore.collection('watchlist');

    try {
      await watchlist.doc(movieId).delete();
      return const Result.success(null);
    } catch (e) {
      return Result.failed(e.toString());
    }
  }

  /// Deletes a movie from the user's favorite list in Firestore.
  ///
  /// Returns [Result.success] if successful, or [Result.failed]
  /// with an error message if failed.
  @override
  Future<Result<void>> deleteMovieFromFavorite({
    required String uid,
    required String movieId,
  }) async {
    CollectionReference<Map<String, dynamic>> watchlist =
        _firebaseFirestore.collection('favoritelist');

    try {
      await watchlist.doc(movieId).delete();
      return const Result.success(null);
    } catch (e) {
      return Result.failed(e.toString());
    }
  }
}
