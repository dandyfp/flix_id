import 'package:flix_id/presentation/misc/constans.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/providers/movie/delete_movie_from_favoritelist_provider.dart';
import 'package:flix_id/presentation/providers/movie/movie_favoritelist_provider.dart';
import 'package:flix_id/presentation/widget/network_image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritelistMoviePage extends ConsumerWidget {
  const FavoritelistMoviePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Favoritelist'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 27.0),
        child: Column(
          children: [
            verticalSpace(20),
            ref.watch(movieFavoritelistProvider).when(
                  data: (data) => GridView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                      childAspectRatio: 150 / 260,
                    ),
                    itemBuilder: (context, index) {
                      var item = data[index];
                      return Column(
                        children: [
                          NetworkImageCard(
                            imageUrl:
                                'https://image.tmdb.org/t/p/w500/${item.posterPath}',
                            boxFit: BoxFit.contain,
                          ),
                          verticalSpace(5),
                          SizedBox(
                            width: 150,
                            height: 30,
                            child: ElevatedButton(
                              onPressed: () {
                                ref
                                    .read(deleteDataMovieFavoritelistProvider
                                        .notifier)
                                    .deleteMovie(item);
                              },
                              child: const Text(
                                'Revome from favorite',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 8,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  error: (error, stackTrace) => const SizedBox(),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
