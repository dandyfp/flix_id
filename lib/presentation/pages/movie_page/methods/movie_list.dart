import 'package:dio/dio.dart';
import 'package:flix_id/domain/entities/movie.dart';
import 'package:flix_id/presentation/providers/movie/add_favoritelist_movie_provider.dart';
import 'package:flix_id/presentation/providers/movie/add_watchlist_movie_provider.dart';
import 'package:flix_id/presentation/widget/network_image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

List<Widget> movieList({
  required String title,
  void Function(Movie movie)? onTap,
  required AsyncValue<List<Movie>> movies,
  required WidgetRef ref,
}) =>
    [
      Padding(
        padding: const EdgeInsets.only(
          left: 24,
          bottom: 15,
        ),
        child: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      SizedBox(
        height: 228,
        child: movies.when(
          data: (data) => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: data
                  .sublist(0, title == 'Popular' ? 20 : 6)
                  .map((e) => Padding(
                        padding: EdgeInsets.only(
                            left: e == data.first ? 24 : 10,
                            right: e == data.last ? 24 : 0),
                        child: Stack(
                          children: [
                            NetworkImageCard(
                              imageUrl:
                                  'https://image.tmdb.org/t/p/w500/${e.posterPath}',
                              boxFit: BoxFit.contain,
                              onTap: () => onTap?.call(e),
                            ),
                            Card(
                              color: Colors.black.withOpacity(0.2),
                              child: SizedBox(
                                height: 40,
                                width: 40,
                                child: PopupMenuButton(
                                  icon: const Icon(
                                    Icons.more_vert_outlined,
                                    color: Colors.white,
                                  ),
                                  itemBuilder: (BuildContext context) =>
                                      <PopupMenuEntry>[
                                    PopupMenuItem(
                                      child: const Text('Add to Watchlist'),
                                      onTap: () {
                                        ref
                                            .read(addWatchlistMovieProvider
                                                .notifier)
                                            .addWatchlistMovie(e);
                                      },
                                    ),
                                    PopupMenuItem(
                                      child: const Text('Add to Favorite'),
                                      onTap: () {
                                        ref
                                            .read(addFavoritelistMovieProvider
                                                .notifier)
                                            .addFavoriteMovie(e);
                                      },
                                    ),
                                    PopupMenuItem(
                                      child: const Text('Save image'),
                                      onTap: () {
                                        var fileName =
                                            'https://image.tmdb.org/t/p/w500/${e.posterPath}'
                                                .split('/')
                                                .last;
                                        downloadAndOpenFile(
                                            'https://image.tmdb.org/t/p/w500/${e.posterPath}',
                                            fileName);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
          error: (error, stackTrace) => const SizedBox(),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      )
    ];

/// This func for download an open file
Future<void> downloadAndOpenFile(String url, String fileName,
    {Function(int)? onProgress}) async {
  try {
    Dio dio = Dio();
    var tempDir = await getTemporaryDirectory();
    String filePath = '${tempDir.path}/$fileName';
    await dio.download(
      url,
      filePath,
      onReceiveProgress: (sentBytes, totalBytes) {
        double progress = sentBytes / totalBytes * 100;
        if (onProgress != null) {
          onProgress(progress.toInt());
        }
      },
    );
    OpenFile.open(filePath);
  } catch (e) {
    print('Error while downloading file: $e');
  }
}
