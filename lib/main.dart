import 'package:AdvertiseMe/providers/adlistprovider.dart';
import 'package:AdvertiseMe/providers/bottomnavbarprovider.dart';
import 'package:AdvertiseMe/providers/getisloadingprovider.dart';
import 'package:AdvertiseMe/providers/publishadprovider.dart';
import 'package:AdvertiseMe/providers/userprofileprovider.dart';
import 'package:AdvertiseMe/providers/obscurepasswordprovider.dart';
import 'package:AdvertiseMe/utils/route_names.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'utils/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => BottomNavBarProvider(),),
    ChangeNotifierProvider(create: (context) => AdListProvider(),),
    ChangeNotifierProvider(create: (context) => UserProfileProvider(),),
    ChangeNotifierProvider(create: (context) => AdsIsloadingProvider(),),
    ChangeNotifierProvider(create: (context) => PublishAdProvider(),),
    ChangeNotifierProvider(create: (context) => ObscurePasswordProvider(),)
  ],child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Advertise Me',
        theme:  ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Color(0xFFFF8000), // RGB: 255, 128, 0 (Orange color)
            primary: Color(0xFFFF8000),
              onPrimary:  Color(0xFFFF8000),
              secondary:  Color(0xFFFF8000),
              onSecondary:  Color(0xFFFF8000),
              onPrimaryContainer:Color(0xFFFF8000) ),

        ),
      initialRoute: RouteNames.loginscreen,
      onGenerateRoute: Routes.generateRoutes,
      debugShowCheckedModeBanner: false
    );
  }
}

