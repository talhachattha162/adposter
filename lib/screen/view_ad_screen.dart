import 'package:AdvertiseMe/firebase/adrepository.dart';
import 'package:AdvertiseMe/firebase/user_repository.dart';
import 'package:AdvertiseMe/models/admodels.dart';
import 'package:AdvertiseMe/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/userprofileprovider.dart';
import '../widgets/map.dart';
import '../widgets/see_more.dart';
import 'my_ads_screen.dart';

class ViewAdScreen extends StatefulWidget {
AdModel ad;
 ViewAdScreen(this.ad,{super.key});

  @override
  State<ViewAdScreen> createState() => _ViewAdScreenState();
}

class _ViewAdScreenState extends State<ViewAdScreen> {

  @override
void initState() {
    // TODO: implement initState
    super.initState();
WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  Provider.of<UserProfileProvider>(context,listen: false).isLoading=false;
Provider.of<UserProfileProvider>(context,listen: false).user=null;
Provider.of<UserProfileProvider>(context,listen: false).currentPageViewAd=0;
});
    getUser();
  }



  getUser() async {
    Provider.of<UserProfileProvider>(context,listen: false).isLoading=true;

    UserRepository adRepository=UserRepository();
    UserModel? user=await adRepository.getUserByEmail(widget.ad.postedBy);
    Provider.of<UserProfileProvider>(context,listen: false).user=user;

    Provider.of<UserProfileProvider>(context,listen: false).isLoading=false;
  }


  void openWhatsAppChat(String phoneNumber) async {
    final whatsappUrl = "https://wa.me/$phoneNumber";
    await launch(whatsappUrl);
  }


  @override
  Widget build(BuildContext context) {
    // final Map<String,dynamic> arguments=ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    return Scaffold(
      floatingActionButton: Container(
        // padding: EdgeInsets.all(0),
        height: 50,
        // decoration: BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(4)),border: Border(top: BorderSide(color: Colors.black26,width: 2))),
        width: MediaQuery.of(context).size.width ,
        child: ElevatedButton(
          onPressed: () async {

            if(widget.ad.phoneNumber==''){
              openWhatsAppChat(widget.ad.whatsAppNumber);
            }
            else if(widget.ad.whatsAppNumber==''){
              String phoneNumber = widget.ad.phoneNumber; // Replace with the desired phone number
              final url = 'tel:$phoneNumber';
              await launch(url);
            }

    },
          child:Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Icon(Icons.chat),
            SizedBox(width: 15,),
            Text(widget.ad.phoneNumber==''?'Chat on Whats App':'Call on Phone Number'),
          ],)
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: Text('View Ad'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.ad.images.length,
                onPageChanged: (index) {
                  Provider.of<UserProfileProvider>(context,listen: false).currentPageViewAd=index;
                },
                itemBuilder: (context, index) {
                  return Stack(
                    children: [

                    Positioned.fill(child:
                  FadeInImage(image:NetworkImage(widget.ad.images[index]) ,
                  placeholder: AssetImage('lib/assets/placeholder.jpg'),
                  fit: BoxFit.contain ,imageErrorBuilder: (context, error, stackTrace) => Text('$error'),
                  )

                    )

                      ,
                    Padding(
                      padding: const EdgeInsets.all( 16.0),
                      child: Row(
                      mainAxisAlignment:MainAxisAlignment.end,

                        children: [
                          Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                              color:Colors.grey,),
                            height:30,
                            width:50,
                            child: Center(
                              child: Selector<UserProfileProvider,int>(
                                selector:(p0, p1) => p1.currentPageViewAd,
                                builder: (context,currentPage,child) {
                                  return Text(
                                    "${currentPage + 1}/${widget.ad.images.length}"
                                    '',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),
                                  );
                                }
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],);
                },
              ),
            ),

            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Rs ${widget.ad.price}'
                       ,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 5),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.ad.title
                        ,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined),
                          Text(
                            '${widget.ad.location}'
                            '',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            // '${widget.timeposted.day}/${widget.timeposted.month}/${widget.timeposted.year}'
                            '',
                            style: TextStyle(fontSize: 16),
                          ),
                          // Add contact buttons here (e.g., Call and WhatsApp)
                          // ...
                        ],
                      ),

                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,

                    children: [
                      Text('Details',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Condition:',
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${widget.ad.condition}'
                        '',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Text(
                        'Category: ',
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${widget.ad.category}'
                        '',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                    SeeMoreText(
                      text:
                      '${widget.ad.description}'
                      '',
                      maxLines: 2,
                    ),



SizedBox(height: 30,),
Row(
  mainAxisAlignment:MainAxisAlignment.spaceAround ,
  children: [

ClipOval(
child: Image.asset(
'lib/assets/blankpic.png', // Replace with your profile image
  height: 70,
width: 80,
),
            ),

    Selector<UserProfileProvider,bool>(selector: (p0, p1) => p1.isLoading,
        builder: (context,isLoading,child) {
      return Column(
        // crossAxisAlignment: CrossAxisAlignment.,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          isLoading==true?
      Text('',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)
              :
        Selector<UserProfileProvider,UserModel?>(selector: (p0, p1) => p1.user,
          builder: (context,userModel,child) {
            return Text(userModel!.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),);
          }
        ),
        // Text(FirebaseAuth.instance.currentUser!.metadata.creationTime.toString()),
         InkWell(onTap: () {
         UserModel? userModel=  Provider.of<UserProfileProvider>(context,listen: false).user;
           Navigator.push(context, MaterialPageRoute(builder: (context) => Scaffold(body: MyAdsScreen(userModel!.email)),));
         },
           child: Row(
             children: [
               Text("See Profile",style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFFFF8000) ),),
               Icon(Icons.arrow_forward_ios_rounded,size: 12,color: Color(0xFFFF8000) ,)
             ],
           ),
         )
      ],);
    }
  )
],),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Location',
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  MapScreen(widget.ad.location),
                  SizedBox(height: 100),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
