import 'dart:io';

import 'package:flix_id/domain/entities/movie.dart';
import 'package:flix_id/domain/entities/result.dart';
import 'package:flix_id/domain/entities/user.dart';

/// Interface for user-related data operations.

abstract interface class UserRepository {
  /// Creates a new user in the repository.
  ///
  /// Takes user details like UID, email, name, optional photo URL, and balance.
  /// Returns a [Result] containing the created [User] on success or an error message on failure.
  ///
  /// [uid]: The unique identifier for the user.
  /// [email]: The email address of the user.
  /// [name]: The name of the user.
  /// [photoUrl]: Optional. The URL of the user's profile photo.
  /// [balance]: Optional. The initial balance of the user. Default is 0.
  Future<Result<User>> createUser({
    required String uid,
    required String email,
    required String name,
    String? photoUrl,
    int balance = 0,
  });

  /// Retrieves a user from the repository by their UID.
  ///
  /// Returns a [Result] containing the [User] on success or an error message on failure.
  ///
  /// [uid]: The unique identifier for the user.
  Future<Result<User>> getUser({required String uid});

  /// Updates user information in the repository.
  ///
  /// Takes the updated [User] object and returns a [Result] containing the updated [User] on success or an error message on failure.
  ///
  /// [user]: The user object with updated information.
  Future<Result<User>> updateUser({required User user});

  /// Retrieves the balance of a user by their UID.
  ///
  /// Returns a [Result] containing the balance as an integer on success or an error message on failure.
  ///
  /// [uid]: The unique identifier for the user.
  Future<Result<int>> getUserBalance({required String uid});

  /// Uploads a profile picture for the user.
  ///
  /// Takes the [User] object and the image file to upload.
  /// Returns a [Result] containing the updated [User] with the new photo URL on success or an error message on failure.
  ///
  /// [user]: The user object.
  /// [imageFile]: The image file to be uploaded as the profile picture.
  Future<Result<User>> uploadProfilePicture({
    required User user,
    required File imageFile,
  });

  /// Updates the balance of a user by their UID.
  ///
  /// Takes the UID and the new balance.
  /// Returns a [Result] containing the updated [User] on success or an error message on failure.
  ///
  /// [uid]: The unique identifier for the user.
  /// [balance]: The new balance to be set.
  Future<Result<User>> updateUserBalance({
    required String uid,
    required int balance,
  });

  /// Adds a movie to the user's watchlist.
  ///
  /// Takes the user's UID and the [Movie] object to be added.
  /// Returns a [Result] indicating success or failure of the operation.
  ///
  /// [uid]: The unique identifier for the user.
  /// [movie]: The movie object to be added to the watchlist.
  Future<Result<void>> addToWatchlist({
    required String uid,
    required Movie movie,
  });

  /// Adds a movie to the user's favorite list.
  ///
  /// Takes the user's UID and the [Movie] object to be added.
  /// Returns a [Result] indicating success or failure of the operation.
  ///
  /// [uid]: The unique identifier for the user.
  /// [movie]: The movie object to be added to the favorite list.
  Future<Result<void>> addToFavorite({
    required String uid,
    required Movie movie,
  });

  /// Deletes a movie from the user's watchlist.
  ///
  /// Takes the user's UID and the movie's ID to be removed.
  /// Returns a [Result] indicating success or failure of the operation.
  ///
  /// [uid]: The unique identifier for the user.
  /// [movieId]: The unique identifier for the movie to be removed.
  Future<Result<void>> deleteMovieFromWatchlist({
    required String uid,
    required String movieId,
  });

  /// Deletes a movie from the user's favorite list.
  ///
  /// Takes the user's UID and the movie's ID to be removed.
  /// Returns a [Result] indicating success or failure of the operation.
  ///
  /// [uid]: The unique identifier for the user.
  /// [movieId]: The unique identifier for the movie to be removed.
  Future<Result<void>> deleteMovieFromFavorite({
    required String uid,
    required String movieId,
  });

  /// Retrieves the user's watchlist.
  ///
  /// Returns a [Result] containing a list of [Movie] objects on success or an error message on failure.
  ///
  /// [uid]: The unique identifier for the user.
  Future<Result<List<Movie>>> getWatchlist(String uid);

  /// Retrieves the user's favorite list.
  ///
  /// Returns a [Result] containing a list of [Movie] objects on success or an error message on failure.
  ///
  /// [uid]: The unique identifier for the user.
  Future<Result<List<Movie>>> getFavoriteList(String uid);
}
