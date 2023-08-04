import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/admodels.dart';


class AdRepository {

  final CollectionReference _adsCollection =
  FirebaseFirestore.instance.collection('ads');

  Future<void> registerAd(AdModel ads) async {

    DocumentReference newAdRef = _adsCollection.doc();
    String newAdId = newAdRef.id;
    ads.adId = newAdId;
    await newAdRef.set(ads.toMap());

  }

  Future<void> updateAd(String adId, AdModel adModel) async {

      await _adsCollection.doc(adId).update(adModel.toMap());

  }

  Future<void> deleteAd(String adId) async {

      await _adsCollection.doc(adId).delete();

  }


  Future<List<String>> uploadImages(List<File> imageFiles) async {
    List<String> imageUrls = [];

    try {
      for (int i = 0; i < imageFiles.length; i++) {
        File imageFile = imageFiles[i];

        // Create a unique filename for the image
        String fileName = DateTime.now().millisecondsSinceEpoch.toString() + '_$i.jpg';

        // Reference to the Firebase Storage location where the image will be uploaded
        Reference ref = FirebaseStorage.instance.ref().child('images/$fileName');

        // Upload the image to Firebase Storage
        UploadTask uploadTask = ref.putFile(imageFile);

        // Get the download URL of the uploaded image
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();

        imageUrls.add(downloadUrl);
      }
    } catch (e) {
      print('Error uploading images: $e');
    }

    return imageUrls;
  }

  // Fetch ads by category
  Future<List<AdModel>> fetchAdByCategory(String category) async {
    try {
      QuerySnapshot snapshot =
      await _adsCollection.where('category', isEqualTo: category).get();

      List<AdModel> ads = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return AdModel.fromMap(data);
      }).toList();

      return ads;
    } catch (e) {
      print('Error fetching ads by category: $e');
      return [];
    }
  }

  // Fetch ads by email
  Future<List<AdModel>> fetchAdByEmail(String? email) async {
    try {
      QuerySnapshot snapshot =
      await _adsCollection.where('postedBy', isEqualTo: email).get();

      List<AdModel> ads = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return AdModel.fromMap(data);
      }).toList();

      return ads;
    } catch (e) {
      print('Error fetching ads by email: $e');
      return [];
    }
  }

  // Fetch ads by title
  Future<List<AdModel>> fetchAds() async {
    try {
      QuerySnapshot snapshot =
      await _adsCollection.get();

      List<AdModel> ads = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return AdModel.fromMap(data);
      }).toList();

      return ads;
    } catch (e) {
      print('Error fetching ads by title: $e');
      return [];
    }
  }

}
