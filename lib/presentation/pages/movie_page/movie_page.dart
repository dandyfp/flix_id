import 'package:flix_id/presentation/pages/movie_page/methods/search_bar.dart';
import 'package:flix_id/presentation/pages/movie_page/methods/user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoviePage extends ConsumerWidget {
  final List<String> promotionImageFileName = const [
    'popcorn.jpg',
    'buy1get1.jpg',
  ];
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(children: [
      userInfo(ref),
      searchBar(context),
    ]);
  }
}
