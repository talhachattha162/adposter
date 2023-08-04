

import 'package:AdvertiseMe/firebase/authentication.dart';
import 'package:AdvertiseMe/firebase/user_repository.dart';
import 'package:AdvertiseMe/models/user.dart';
import 'package:AdvertiseMe/utils/route_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/bottomnavbarprovider.dart';
import '../providers/userprofileprovider.dart';
import 'edit_profile_screen.dart';



class MyProfileScreen extends StatefulWidget {
  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProfileProvider>(context,listen: false).isLoading=false;
      Provider.of<UserProfileProvider>(context,listen: false).user=null;
      getUser();
    });
  }

  getUser() async {
    Provider.of<UserProfileProvider>(context,listen: false).isLoading=true;

    UserRepository userRepository=UserRepository();
    Provider.of<UserProfileProvider>(context,listen: false).isLoading=true;

    Provider.of<UserProfileProvider>(context,listen: false).user= await userRepository.getUserByEmail(FirebaseAuth.instance.currentUser!.email);
    Provider.of<UserProfileProvider>(context,listen: false).isLoading=false;
  }

  @override
  Widget build(BuildContext context) {
    return Selector<UserProfileProvider,bool>(selector: (p0, p1) => p1.isLoading,
        builder: (context,isLoading,child) {

        return Scaffold(

          body:

          isLoading?Center(child: CircularProgressIndicator(),):Padding(
            padding: const EdgeInsets.all(14.0),
            child: Selector<UserProfileProvider,UserModel?>(selector: (p0, p1) => p1.user,
                builder: (context,user,child) {
print('chattha:'+user!.imageUrl);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                user!.imageUrl.isEmpty
                   ?

                 Image.asset(
                   'lib/assets/blankpic.png', // Replace with your profile image
height: 200,

                   width: 180,
                 )

                     :
                 CircleAvatar(
                   radius: 120,
                  backgroundImage: NetworkImage(user!.imageUrl),
                 )
                    ,
                     Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 16),
                            Text(
                              user!.name, // Replace with the user's name
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text(
                              user!.email.toString(), // Replace with the user's email
                              style: TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                            SizedBox(height: 32),
                          ],
                        )
                     ,
                    ElevatedButton(
                      onPressed: () async {
                        final result=await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfileScreen(user: user),
                          ),
                        );
                        print(result);
                        if(result=='1'){
                          getUser();
                        }

                      },
                      child: Text('Edit Profile'),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async{
                        FirebaseAuthModel firebaseAuthModel=FirebaseAuthModel();
                       await  firebaseAuthModel.signOut();
                       User? user=  firebaseAuthModel.getCurrentUser();
                       // print('talhachattha162'+user.toString());
                       // String check=user?.uid??'';
                       //  print('talhachattha162@'+check);
                       if(user?.uid==null){
                         Provider.of<BottomNavBarProvider>(context,listen: false).currentIndex=0;
                         Navigator.pushNamedAndRemoveUntil(context, RouteNames.loginscreen,(route) => false,);
                       }
                      },
                      child: Text('Logout'),
                    ),
                  ],
                );
              }
            ),
          ),
        );
      }
    );
  }
}
