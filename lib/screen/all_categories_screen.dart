import 'package:flutter/material.dart';

import '../widgets/categorycard.dart';



class AllCategoriesScreen extends StatelessWidget {
  final List<String> _categories = [
    'Mobile',
    'Laptops',
    'Accessories',
    'Property for sale',
    'Property for Rent',
    'Cars',
    'Motorcycles',
    'Jobs',
    'Other Vehicles',
    'Electronics',
    'Electrical & Power Tools',
    'Home Appliances',
    'Music & Instruments',
    'Furniture',
    'Clothing',
    'Beauty & Personal Care',
    'Health & Fitness',
    'Books',
    'Sports Equipment',
    'Kids',
    'Services',
    'Pets',
    'Travel & Tourism',
    'Food & Beverages',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing: 3,mainAxisSpacing: 3),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          return CategoryCardWidget(category: _categories[index]);
        },
      ),
    );
  }
}
