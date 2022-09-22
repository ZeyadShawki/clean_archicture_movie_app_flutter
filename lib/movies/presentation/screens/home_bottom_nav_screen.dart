import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:movies_app_clean_arch/movies/presentation/screens/movie_screen.dart';
import 'package:movies_app_clean_arch/movies/presentation/screens/profile_screen.dart';
import 'package:movies_app_clean_arch/movies/presentation/screens/search_screen.dart';
import 'package:movies_app_clean_arch/movies/presentation/screens/watch_list_screen.dart';

class HomeBottomNavScreen extends StatefulWidget {
  const HomeBottomNavScreen({Key? key}) : super(key: key);

  @override
  State<HomeBottomNavScreen> createState() => _HomeBottomNavScreenState();
}

class _HomeBottomNavScreenState extends State<HomeBottomNavScreen> {
  final _pageViewController = PageController();
  List<Widget> screens=[
    const HomeMovieScreen(),
    const SearchScreen(),
    const WatchListScreen(),
    const ProfileScreen(),
  ];
  int  _currentIndex=0;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: PageView(
        physics: const BouncingScrollPhysics(),

        controller: _pageViewController,
        onPageChanged: (index){
          setState(() {

            _currentIndex=index;
          });
        },
        children: screens,
      ),
      bottomNavigationBar:   BottomNavyBar(
        backgroundColor: Colors.black,
        selectedIndex: _currentIndex,

        items: [

          BottomNavyBarItem(icon: const Icon(Icons.live_tv), title: const Text('Home',textAlign: TextAlign.center,),activeColor: Colors.deepOrange,inactiveColor: Colors.grey),
          BottomNavyBarItem(icon: const Icon(Icons.search_outlined), title: const Text('Search',textAlign: TextAlign.center,) ,activeColor: Colors.deepOrange,inactiveColor: Colors.grey),
          BottomNavyBarItem(icon: const Icon(Icons.star_border_outlined), title: const Text('Watch List',textAlign: TextAlign.center,),activeColor: Colors.deepOrange,inactiveColor: Colors.grey),
          BottomNavyBarItem(icon: const Icon(Icons.person_outline), title: const Text('profile',textAlign: TextAlign.center,),activeColor: Colors.deepOrange,inactiveColor: Colors.grey),

        ],
        onItemSelected: (int value) {
          setState(() {
            _currentIndex=value;
            _pageViewController.jumpToPage(_currentIndex);
          });
        },


      )
    );
  }


}
