import 'package:AdvertiseMe/firebase/adrepository.dart';
import 'package:AdvertiseMe/screen/publish_ad_screen.dart';
import 'package:flutter/material.dart';

import '../models/admodels.dart';
import '../screen/bottom_navbar.dart';

class MyAdCardWidget extends StatelessWidget {

  final AdModel ad;
  String? email;
  MyAdCardWidget(this.ad ,{super.key,required this.email});

  @override
  Widget build(BuildContext context) {
    // print('c3'+email.toString());
    return  Card(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
             email!=''?
      Container()
      : PopupMenuButton(

                onSelected: (value) {
if(value==1){
Navigator.push(context, MaterialPageRoute(builder: (context) => PublishAdScreen(ad: ad),));
}
else{

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Delete Confirmation'),
        content: Text('Are you sure you want to delete this item?'),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          TextButton(
            child: Text('Delete'),
            onPressed: () {

              AdRepository adRepository=AdRepository();
              adRepository.deleteAd(ad.adId);
              Navigator.of(context).pop(); // Close the dialog
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => BottomNavBarHome(),))  ;
            },
          ),
        ],
      );
    },
  );

}
              },
              itemBuilder: (context) {
             return [
               PopupMenuItem(child: Text('Edit'),value: 1,),
               PopupMenuItem(child: Text('Delete'),value: 0,)
             ];

            },
            )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
            SizedBox(height: 100,
                width: 140,
                child:
FadeInImage(image:NetworkImage(ad.images[0]) ,
placeholder: AssetImage('lib/assets/placeholder.jpg'),
  fit: BoxFit.contain ,imageErrorBuilder: (context, error, stackTrace) => Text('$error'),)
            )
                ,
            Column(children: [
              Text(ad.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold)
                ,),
              Text(ad.price),
              SizedBox(height: 20,),
              Row(
                children: [
                  Text('Category:'            ,style: TextStyle(fontWeight: FontWeight.bold)
    ),
                  Text(ad.category),
                ],
              ),
              
            ],)
          ]),
        ],
      ),
    );
  }
}
