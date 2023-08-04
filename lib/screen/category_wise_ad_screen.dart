import 'package:AdvertiseMe/firebase/adrepository.dart';
import 'package:AdvertiseMe/firebase/favouriterepository.dart';
import 'package:AdvertiseMe/models/favourite.dart';
import 'package:AdvertiseMe/providers/adlistprovider.dart';
import 'package:AdvertiseMe/screen/view_ad_screen.dart';
import 'package:AdvertiseMe/widgets/adcard.dart';
import 'package:AdvertiseMe/widgets/shimmer2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../firebase/user_repository.dart';
import '../models/admodels.dart';
import '../models/user.dart';



class CategoryWiseData extends StatefulWidget {

  final String category;
 const CategoryWiseData({super.key, required this.category});

  @override
  State<CategoryWiseData> createState() => _CategoryWiseDataState();
}

class _CategoryWiseDataState extends State<CategoryWiseData> {


   @override
   void initState(){
     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
       Provider.of<AdListProvider>(context,listen: false).isLoading=false;
     Provider.of<AdListProvider>(context,listen: false).ads=[];
     getAds();
     });

   }



  getAds() async {
     Provider.of<AdListProvider>(context,listen: false).isLoading=true;
    AdRepository adRepository=AdRepository();
  List<AdModel> adList1= await adRepository.fetchAdByCategory(widget.category);
     Provider.of<AdListProvider>(context,listen: false).ads=adList1;
     Provider.of<AdListProvider>(context,listen: false).isLoading=false;
  }

  @override
  Widget build(BuildContext context) {
final height=MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.category}"),
      ),
      body:
          Selector<AdListProvider,bool>(selector: (p0, p1) => p1.isLoading,builder: (context, isLoading, child) {
           return isLoading
               ?
           Shimmer2(height)
               :
           Selector<AdListProvider,List<AdModel>>(selector: (p0, p1) => p1.ads,builder: (context, adList, child) {
             return
               adList.isEmpty
                   ?
               Center(child: Text('Nothing Found'),)
                   :
               Padding(
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
                     return InkWell(onTap: () {
                       Navigator.push(context, MaterialPageRoute(
                         builder: (context) => ViewAdScreen(adList[index],),));
                     }, child: AdCardWidget(adList[index]));
                   },
                 ),
               );
           }
           );
          }

            ,)

    );
  }
}

