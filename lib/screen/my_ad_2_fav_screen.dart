import 'package:flutter/material.dart';

import '../models/admodels.dart';
import '../widgets/adcard.dart';

class FavouriteScreen extends StatefulWidget {
  List<AdModel> ads;
   FavouriteScreen({super.key,required this.ads});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
    final List<AdModel> adList =[];


    @override
    Widget build(BuildContext context) {
    final  height=MediaQuery.sizeOf(context).height;


      return  Container(height: height*0.72,
        child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 2.0,
                mainAxisExtent: 240,
                // childAspectRatio: 2
              ),
              itemCount: adList.length,
              itemBuilder: (context, index) {
                return AdCardWidget(adList[index]);
              },
            ),

        ),
      );
    }
  }
