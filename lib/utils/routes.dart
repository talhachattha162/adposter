import 'package:AdvertiseMe/screen/all_categories_screen.dart';
import 'package:AdvertiseMe/screen/bottom_navbar.dart';
import 'package:AdvertiseMe/screen/login_screen.dart';
import 'package:AdvertiseMe/screen/my_ads_screen.dart';
import 'package:AdvertiseMe/screen/publish_ad_screen.dart';
import 'package:AdvertiseMe/screen/signup_screen.dart';
import 'package:AdvertiseMe/screen/view_ad_screen.dart';
import 'package:flutter/material.dart';

import '../screen/category_wise_ad_screen.dart';
import '../screen/edit_profile_screen.dart';
import 'route_names.dart';

class Routes{

 static Route<dynamic> generateRoutes(RouteSettings routeSettings){
    switch(routeSettings.name){
      case RouteNames.home:
       return MaterialPageRoute(builder: (context) => BottomNavBarHome(),);
      // case RouteNames.viewad:
      //   return MaterialPageRoute(builder: (context) => ViewAdScreen(),);
      case RouteNames.loginscreen:
        return MaterialPageRoute(builder: (context) => LoginScreen(),);
      case RouteNames.signup:
        return MaterialPageRoute(builder: (context) => SignupScreen(),);
      case RouteNames.publishad:
        return MaterialPageRoute(builder: (context) => PublishAdScreen(),);
      case RouteNames.allcategories:
        return MaterialPageRoute(builder: (context) => AllCategoriesScreen(),);
      default:
        return MaterialPageRoute(builder: (context) => Text('No route defined'),);

    }
  }

}
