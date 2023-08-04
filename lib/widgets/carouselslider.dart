import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselSliderWidget extends StatelessWidget {
  final List<String> adImages = [

    "lib/assets/sale1.jpg",
  "lib/assets/sale4.jpg",

  "lib/assets/sale6.jpg",
        // "lib/assets/sale2.jpg",
        "lib/assets/sale3.jpg",


        // , "lib/assets/sale5.png"
    // Add more image URLs here
  ];

  @override
  Widget build(BuildContext context) {
    return  Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
            items: adImages.map((url) {
              return Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child:

                  Image.asset(gaplessPlayback: true,
                    url,
                    fit: BoxFit.contain,
                    width: 1000.0,
                  ),
                ),
              );
            }).toList(),
          ),
          // Add other ad poster fields and buttons below
        ],

    );
  }
}