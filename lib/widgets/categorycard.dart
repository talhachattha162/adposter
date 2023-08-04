
import 'package:AdvertiseMe/screen/category_wise_ad_screen.dart';
import 'package:AdvertiseMe/utils/route_names.dart';
import 'package:AdvertiseMe/utils/routes.dart';
import 'package:flutter/material.dart';

class CategoryCardWidget extends StatelessWidget {
  final String category;

  CategoryCardWidget({required this.category});

  @override
  Widget build(BuildContext context) {
    // Map the category names to corresponding icons
    Map<String, IconData> categoryIcons = {
      'Mobile': Icons.smartphone,
      'Laptops': Icons.laptop,
      'Accessories': Icons.headset,
      'Property for sale': Icons.home,
      'Property for Rent': Icons.home_work,
      'Cars': Icons.directions_car,
      'Motorcycles': Icons.motorcycle,
      'Jobs': Icons.work,
      'Other Vehicles': Icons.directions_car_filled,
      'Electronics': Icons.devices_other,
      'Electrical & Power Tools': Icons.settings,
      'Home Appliances': Icons.kitchen,
      'Music & Instruments': Icons.music_note,
      'Furniture': Icons.chair,
      'Clothing': Icons.shopping_bag,
      'Beauty & Personal Care': Icons.face,
      'Health & Fitness': Icons.health_and_safety,
      'Books': Icons.menu_book,
      'Sports Equipment': Icons.sports_baseball,
      'Kids': Icons.child_care,
      'Services': Icons.build,
      'Pets': Icons.pets,
      'Travel & Tourism': Icons.flight,
      'Food & Beverages': Icons.restaurant,
    };

    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryWiseData(category: category,),));

        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              categoryIcons[category],
              size: 48,
              color: Color.fromRGBO(255,128, 0, 0.8),
            ),
            SizedBox(height: 8),
            Text(
              category,
              // style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
