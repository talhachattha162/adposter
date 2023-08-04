import 'package:AdvertiseMe/providers/bottomnavbarprovider.dart';
import 'package:AdvertiseMe/screen/search_screen.dart';
import 'package:AdvertiseMe/utils/route_names.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'my_ads_screen.dart';
import 'my_profile_screen.dart';
import 'package:provider/provider.dart';



class BottomNavBarHome extends StatefulWidget {
  BottomNavBarHome( {super.key});
  @override
  State<BottomNavBarHome> createState() => _BottomNavBarHomeState();
}

class _BottomNavBarHomeState extends State<BottomNavBarHome> {


  final List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    MyAdsScreen(''),
    MyProfileScreen(),
  ];

  void _onTabTapped(int index) {
    Provider.of<BottomNavBarProvider>(context,listen: false).currentIndex=index;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body:
        Selector<BottomNavBarProvider,int>(selector: (p0, p1) => p1.currentIndex,
            builder: (context, value, child) {
      return _screens[value];

        }
    )
    ,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(254, 127, 0, 0.8),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, -2),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, 'Home', 0),
            _buildNavItem(Icons.search, 'Search', 1),
            _buildNavItem(Icons.favorite_border, 'My Ads', 2),
            _buildNavItem(Icons.person, 'Profile', 3),
          ],
        ),
      ),
      floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: FloatingActionButton(enableFeedback: true,mini: true,
          backgroundColor: Colors.blueGrey,
          onPressed: () {
            Navigator.pushNamed(context, RouteNames.publishad);
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildNavItem(IconData icon, String title, int index) {

   return Selector<BottomNavBarProvider,int>(selector: (p0, p1) => p1.currentIndex,
    builder: (context, value, child) {
    final isSelected = value == index;
    final color = isSelected ? Colors.white : Colors.blueGrey;
    return GestureDetector(
      onTap: () => _onTabTapped(index),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: color,
              size: 24,
            ),
            Text(
              title,
              style: TextStyle(color: color),
            ),
          ],
        ),
      ),
    );
    }
    );
  }
}


