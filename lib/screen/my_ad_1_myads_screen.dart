import 'package:AdvertiseMe/widgets/myadcard.dart';
import 'package:flutter/material.dart';
import '../models/admodels.dart';
import '../widgets/shimmer.dart';
import 'view_ad_screen.dart';

class MyAds1Screen extends StatefulWidget {
  String? email;
  List<AdModel> ad;
    MyAds1Screen( {super.key,required this.ad,required this.email, });

  @override
  State<MyAds1Screen> createState() => _MyAds1ScreenState();
}

class _MyAds1ScreenState extends State<MyAds1Screen> {


  @override
  Widget build(BuildContext context) {

    final  height=MediaQuery.sizeOf(context).height;
    return SizedBox(height: height*0.8,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 2.0,
            mainAxisSpacing: 2.0,
            mainAxisExtent: 170,
            // childAspectRatio: 2
          ),
          itemCount: widget.ad.length,
          itemBuilder: (context, index) {
            return InkWell(onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAdScreen(widget.ad[index],),));
            },child:MyAdCardWidget(widget.ad[index],email: widget.email,));
          },
        ),
      ),
    );
  }
}
