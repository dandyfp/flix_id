import 'package:flix_id/presentation/extentions/build_context_extension.dart';
import 'package:flix_id/presentation/pages/profile_page/profile_page.dart';
import 'package:flix_id/presentation/providers/router/router_provider.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flix_id/presentation/widget/bottom_nav_bar.dart';
import 'package:flix_id/presentation/widget/bottom_nav_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  PageController pageController = PageController();
  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    ref.listen(
      userDataProvider,
      (previous, next) {
        if (previous != null && next is AsyncData && next.value == null) {
          ref.read(routerProvider).goNamed('login');
        } else if (next is AsyncError) {
          context.showSnackBar(next.error.toString());
        }
      },
    );
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (value) => setState(() {
              selectedPage = value;
            }),
            children: const [
              Center(child: Text('Movie page')),
              Center(child: Text('Ticket page')),
              Center(
                child: ProfilePage(),
              ),
            ],
          ),
          BottomNavBar(
            items: [
              BottomNavBarItem(
                image: 'assets/movie.png',
                selectedImage: 'assets/movie-selected.png',
                title: 'Home',
                isSelected: selectedPage == 0,
                index: 0,
              ),
              BottomNavBarItem(
                image: 'assets/ticket.png',
                selectedImage: 'assets/ticket-selected.png',
                title: 'Ticket',
                isSelected: selectedPage == 1,
                index: 1,
              ),
              BottomNavBarItem(
                image: 'assets/profile.png',
                selectedImage: 'assets/profile-selected.png',
                title: 'Profile',
                isSelected: selectedPage == 2,
                index: 2,
              )
            ],
            selectedIndex: 0,
            onTap: (index) {
              selectedPage = index;
              pageController.animateToPage(
                selectedPage,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
              );
            },
          )
        ],
      ),
    );
  }
}
