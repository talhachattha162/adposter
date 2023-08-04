
import 'package:AdvertiseMe/widgets/shimmerimage.dart';
import 'package:flutter/material.dart';

import '../models/admodels.dart';

class AdCardWidget extends StatelessWidget {
final AdModel ad;
  const AdCardWidget(this.ad,{super.key});

  @override
  Widget build(BuildContext context) {

    return Card(borderOnForeground: false,
      child: Column(
        children: [
          SizedBox(
            height: 120,
            width: double.infinity,
            child:
            FadeInImage(image:NetworkImage(ad.images[0]) ,
              placeholder: AssetImage('lib/assets/placeholder.jpg'),
                fit: BoxFit.fill ,imageErrorBuilder: (context, error, stackTrace) => Text('$error'),)


          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('\$'+
                      ad.price,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Text(
                  ad.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  ad.location,
                  style: TextStyle(color: Colors.grey),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ad.timeposted.hour.toString() + ":" + ad.timeposted.minute.toString(),
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      ad.timeposted.day.toString() + "/" + ad.timeposted.month.toString()+ "/" + ad.timeposted.year.toString(),
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );



  }

}
