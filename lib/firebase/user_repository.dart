import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/user.dart';

class UserRepository {

  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('users');

  // Function to register a new user
  Future<String?> registerUser(UserModel user) async {
    try {
      await usersCollection.doc(user.email).set({
        'name': user.name,
        'email': user.email,
        'imageUrl': user.imageUrl,
        'phoneno': user.phoneno,
        'whatsappno': user.whatsappno,
      });

      return "User registered successfully!";
    } catch (e) {
      print("Error during user registration: $e");
      return null;
    }
  }

  // Function to update user data
  Future<String?> updateUser(UserModel user) async {
    try {
      await usersCollection.doc(user.email).update({
        'name': user.name,
        'imageUrl': user.imageUrl,
        'phoneno': user.phoneno,
        'whatsappno': user.whatsappno,
      });

      return "User data updated successfully!";
    } catch (e) {
      print("Error during user data update: $e");
      return null;
    }
  }

  // Function to fetch user data by email
  Future<UserModel?> getUserByEmail(String? email) async {
    try {
      DocumentSnapshot snapshot =
      await usersCollection.doc(email).get();

      if (snapshot.exists) {
        return UserModel(
          snapshot['name'],
           snapshot['email'],
           snapshot['imageUrl'],
           snapshot['phoneno'],
           snapshot['whatsappno'],
        );
      } else {
        return null;
      }
    } catch (e) {
      print("Error during user data fetching: $e");
      return null;
    }
  }


  Future<String> uploadProfilePhoto(File imageFile) async {
    String profilephoto = "";

    try {

        String? file=FirebaseAuth.instance.currentUser!.email;
        String fileName = DateTime.now().millisecondsSinceEpoch.toString() +file.toString() +'.jpg';

        Reference ref = FirebaseStorage.instance.ref().child('images/$fileName');

        UploadTask uploadTask = ref.putFile(imageFile);

        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();

        profilephoto=downloadUrl;
      }
     catch (e) {
      print('Error uploading images: $e');
    }

    return profilephoto;
  }
  
}
