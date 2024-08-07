import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flix_id/data/repositories/user_repository.dart';
import 'package:flix_id/domain/entities/movie.dart';
import 'package:flix_id/domain/entities/result.dart';
import 'package:flix_id/domain/entities/user.dart';
import 'package:path/path.dart';

class FirebaseUserRepository implements UserRepository {
  final FirebaseFirestore _firebaseFirestore;

  FirebaseUserRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;
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

  @override
  Future<Result<void>> addToWatchlist({
    required String uid,
    required Movie movie,
  }) async {
    DocumentReference<Map<String, dynamic>> userDoc =
        _firebaseFirestore.doc('users/$uid');
    CollectionReference<Map<String, dynamic>> watchlist =
        userDoc.collection('watchlist');

    try {
      await watchlist.doc(movie.id.toString()).set({
        'movieId': movie.id,
        'movieTitle': movie.title,
        'posterPath': movie.posterPath,
        'addedAt': FieldValue.serverTimestamp(),
      });
      return const Result.success(null);
    } catch (e) {
      return Result.failed(e.toString());
    }
  }

  @override
  Future<Result<void>> addToFavorite({
    required String uid,
    required Movie movie,
  }) async {
    DocumentReference<Map<String, dynamic>> userDoc =
        _firebaseFirestore.doc('users/$uid');
    CollectionReference<Map<String, dynamic>> watchlist =
        userDoc.collection('favoriteList');

    try {
      await watchlist.doc(movie.id.toString()).set({
        'movieId': movie.id,
        'movieTitle': movie.title,
        'posterPath': movie.posterPath,
        'addedAt': FieldValue.serverTimestamp(),
      });
      return const Result.success(null);
    } catch (e) {
      return Result.failed(e.toString());
    }
  }

  @override
  Future<Result<List<Movie>>> getWatchlist(String uid) async {
    CollectionReference<Map<String, dynamic>> watchlist =
        _firebaseFirestore.collection('users/$uid/watchlist');

    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await watchlist.get();
      List<Movie> watchlistItems =
          snapshot.docs.map((doc) => Movie.fromJSON(doc.data())).toList();
      return Result.success(watchlistItems);
    } catch (e) {
      return Result.failed(e.toString());
    }
  }

  @override
  Future<Result<List<Movie>>> getFavoriteList(String uid) async {
    CollectionReference<Map<String, dynamic>> watchlist =
        _firebaseFirestore.collection('users/$uid/favoriteList');

    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await watchlist.get();
      List<Movie> watchlistItems =
          snapshot.docs.map((doc) => Movie.fromJSON(doc.data())).toList();
      return Result.success(watchlistItems);
    } catch (e) {
      return Result.failed(e.toString());
    }
  }

  @override
  Future<Result<void>> deleteMovieFromWatchlist({
    required String uid,
    required String movieId,
  }) async {
    DocumentReference<Map<String, dynamic>> userDoc =
        _firebaseFirestore.doc('users/$uid');
    CollectionReference<Map<String, dynamic>> watchlist =
        userDoc.collection('watchlist');

    try {
      await watchlist.doc(movieId).delete();
      return const Result.success(null);
    } catch (e) {
      return Result.failed(e.toString());
    }
  }

  @override
  Future<Result<void>> deleteMovieFromFavorite({
    required String uid,
    required String movieId,
  }) async {
    DocumentReference<Map<String, dynamic>> userDoc =
        _firebaseFirestore.doc('users/$uid');
    CollectionReference<Map<String, dynamic>> watchlist =
        userDoc.collection('favoriteList');

    try {
      await watchlist.doc(movieId).delete();
      return const Result.success(null);
    } catch (e) {
      return Result.failed(e.toString());
    }
  }
}
