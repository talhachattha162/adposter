import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class ShimmerWidget extends StatelessWidget {

  Widget buildLoadingWidget() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 2.0,
        mainAxisSpacing: 2.0,
        mainAxisExtent: 120,
      ),
      itemCount: 4, // Number of shimmer items you want to show
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Container(
                  width: 300.0,
                  height: 10.0,
                  color: Colors.white, // This color will be replaced by the shimmer effect
                ),
                SizedBox(height: 20.0),
                Container(
                  width: 200.0,
                  height: 10.0,
                  color: Colors.white, // This color will be replaced by the shimmer effect
                ),
                SizedBox(height: 20.0),
                Container(
                  width: 100.0,
                  height: 10.0,
                  color: Colors.white, // This color will be replaced by the shimmer effect
                ),
                SizedBox(height: 20.0),
                Container(
                  width: 50.0,
                  height: 10.0,
                  color: Colors.white, // This color will be replaced by the shimmer effect
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.sizeOf(context).height;
  return
      SizedBox(height:height*0.7,child:buildLoadingWidget()
    );
  }
}
