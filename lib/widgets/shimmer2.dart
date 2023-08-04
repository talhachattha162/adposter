import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Shimmer2 extends StatelessWidget {
final double height;
  const Shimmer2(this.height,{super.key});

  @override
  Widget build(BuildContext context) {
    return  _buildShimmerEffect();
  }

  Widget _buildShimmerEffect() {
    // Create shimmer effects for the GridView items
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
          mainAxisExtent: height*0.29,
        ),
        itemCount: 6, // Show a fixed number of shimmer items (you can adjust this as needed)
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              color: Colors.white, // You can also use your card background color here
            ),
          );
        },
      ),
    );
  }
}
