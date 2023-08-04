import 'package:AdvertiseMe/firebase/adrepository.dart';
import 'package:AdvertiseMe/models/admodels.dart';
import 'package:AdvertiseMe/providers/adlistprovider.dart';
import 'package:AdvertiseMe/screen/my_ad_1_myads_screen.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/shimmer.dart';


class MyAdsScreen extends StatefulWidget {
  String? email;
   MyAdsScreen(this.email,{super.key});

  @override
  State<MyAdsScreen> createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AdListProvider>(context,listen: false).isLoading=false;
      Provider.of<AdListProvider>(context,listen: false).ads=[];
      getAd();
    });

  }




  getAd() async {
   Provider.of<AdListProvider>(context,listen: false).isLoading=true;
    AdRepository adRepository=AdRepository();
    List<AdModel> ads=[];
    if(widget.email!=''){
      ads= await adRepository.fetchAdByEmail(widget.email);
    }
    else
    {
       ads= await adRepository.fetchAdByEmail(FirebaseAuth.instance.currentUser!.email);
    }
   Provider.of<AdListProvider>(context,listen: false).ads=ads;
   Provider.of<AdListProvider>(context,listen: false).isLoading=false;

  }


  @override
  Widget build(BuildContext context) {
    return  Selector<AdListProvider,bool>(selector: (p0, p1) => p1.isLoading,
      builder: (context,isLoading,child) {
      print(isLoading.toString());
        return SafeArea(
          child:
                  isLoading==true
                      ?
                      Column(
                        children: [
                          SizedBox(height: 20,),
                          ShimmerWidget(),
                        ],
                      )
                      :
                      Selector<AdListProvider,List<AdModel>>(selector: (p0, p1) => p1.ads,
                        builder: (context,adList,child) {
                          // print(adList.length.toString());
                          return adList.isEmpty?
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 widget.email==''?
                                 Container()
                                     :
                                 IconButton(onPressed: () {
                                   Navigator.pop(context);
                                 }, icon: Icon(Icons.arrow_back_outlined)),
                                 SizedBox(height:MediaQuery.of(context).size.height*0.7
                                   ,child: Center(child: Text('Nothing Uploaded')),),
                               ],
                             )
                              :
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              widget.email==''?
                              Container()
                                  :
                              IconButton(onPressed: () {
Navigator.pop(context);
                              }, icon: Icon(Icons.arrow_back_outlined)),

                          MyAds1Screen(ad: adList,email:widget.email),
                    ],
                  );
                        }
                      )

        );
      }
    );
  }
}
