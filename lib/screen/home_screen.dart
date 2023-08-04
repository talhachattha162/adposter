import 'package:flutter/material.dart';
import '../utils/categories_list.dart';
import '../utils/route_names.dart';
import '../widgets/carouselslider.dart';
import '../widgets/categorycard.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CarouselSliderWidget(),
            SizedBox(height: 10,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Categories',style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold,)),

                Container(
                  height: 35,
                  child: TextButton(onPressed: () {
                    Navigator.pushNamed(context, RouteNames.allcategories);
                  } , child: Text("See all")),
                )
              ],),
            SizedBox(height: 10,),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Number of columns in the grid
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: categories.length >= 9 ? 9 : categories.length,
                itemBuilder: (context, index) {
                  return CategoryCardWidget(category: categories[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}