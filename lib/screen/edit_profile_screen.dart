// import 'dart:html';
import 'dart:io';

import 'package:AdvertiseMe/firebase/authentication.dart';
import 'package:AdvertiseMe/firebase/user_repository.dart';
import 'package:AdvertiseMe/models/user.dart';
import 'package:AdvertiseMe/providers/userprofileprovider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel? user;

  EditProfileScreen({required this.user});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}


class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _whatsappNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Remove the Map<String, UserModel>? user; declaration

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.user!.name;
    _phoneNumberController.text = widget.user!.phoneno;
    _whatsappNumberController.text = widget.user!.whatsappno;
  }

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,imageQuality: 30
    );
    if (pickedImage != null) {
      Provider.of<UserProfileProvider>(context,listen: false).setpickedImage(pickedImage);
    }
  }


  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    Selector<UserProfileProvider,XFile?>(
                      selector: (p0, p1) => p1.pickedImage,
                      builder:(context, pickedimage, child)  {
                        return  ClipOval(
      child: pickedimage != null
      ? Image.file(
      File(pickedimage!.path),
      height: 200,
      width: 200,
      fit: BoxFit.contain,
      )
            : widget.user!.imageUrl.isEmpty?
      Image.asset(
      'lib/assets/blankpic.png',
      height: 200,
      width: 200,
      fit: BoxFit.cover,
      )

            :Image.network( widget.user!.imageUrl,  height: 220,
      width: 230,
      fit: BoxFit.cover,),
      );
                      }
      )
      ,
                    Positioned(child: IconButton(icon: Icon(Icons.camera_alt,size: 30),onPressed: () {
_pickImage();
                    },),right: 10,bottom: 10,),
                  ],
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter your name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name.';
                  }
                  // You can add more complex validation checks if needed.
                  return null; // Return null if the input is valid.
                },
              ),
              Row(
                children: [
                  SizedBox(
                    width: width * 0.2,
                    child: Container(
                      alignment: Alignment.bottomCenter, // Align the text at the center vertically
                      child: Text(
                        '+92',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.7,
                    child: TextFormField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        hintText: 'Enter your phone number',
                      ),validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone no.';
                      }
                      // You can add more complex validation checks if needed.
                      return null; // Return null if the input is valid.
                    },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  SizedBox(
                    width: width * 0.2,
                    child: Container(
                      alignment: Alignment.bottomCenter, // Align the text at the center vertically
                      child: Text(
                        '+92',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.7,
                    child: TextFormField(
                      controller: _whatsappNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'WhatsApp Number',
                        hintText: 'Enter your WhatsApp number',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your WhatsApp number.';
                        }
                        // You can add more complex validation checks if needed.
                        return null; // Return null if the input is valid.
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(height: 32),
              Selector<UserProfileProvider,bool>(selector: (p0, p1) => p1.isLoading,
                builder: (context,isLoading,_) {
                  return isLoading
                      ?
                      Center(child: CircularProgressIndicator())
                      :ElevatedButton(
                    onPressed: () async {

      Provider
          .of<UserProfileProvider>(context, listen: false)
          .isLoading = true;
      UserRepository userRepository = UserRepository();
      String imageurl = "";
      if (Provider
          .of<UserProfileProvider>(context, listen: false)
          .pickedImage != null) {
        imageurl = await userRepository.uploadProfilePhoto(File(Provider
            .of<UserProfileProvider>(context, listen: false)
            .pickedImage!
            .path)) ?? '';
      }
      else if (widget.user!.imageUrl.isNotEmpty) {
        imageurl = widget.user!.imageUrl;
      }
      else {
        imageurl = '';
      }
      String imageUrl = imageurl;
      String name = _nameController.text ?? '';
      String whatsappno = _whatsappNumberController.text ?? '';
      String phoneno = _phoneNumberController.text ?? '';
      UserModel user = UserModel(
          name, FirebaseAuth.instance.currentUser!.email, imageUrl, phoneno,
          whatsappno);
      String? display = await userRepository.updateUser(user);
      if (display != null) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$display')));
        Navigator.pop(context, '1');
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Fail to update')));
      }
      Provider
          .of<UserProfileProvider>(context, listen: false)
          .isLoading = false;

                    },
                    child: Text('Save Profile'),
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}

