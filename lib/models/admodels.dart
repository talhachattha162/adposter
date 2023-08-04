
import 'package:cloud_firestore/cloud_firestore.dart';

class AdModel {
    String _adId;

   String get adId => _adId;

   set adId(String value) {
     _adId = value;
   }

  final List<String> images;
  final String title;
  final String description;
  final String price;
  final String? condition;
  final String category;
  final String whatsAppNumber;
  final String phoneNumber;
  final String location;
  final String district;
  final DateTime timeposted;
  final String? postedBy;

  AdModel(
      this._adId,
      {
    required this.images,
    required this.title,
    required this.description,
    required this.price,
    required this.condition,
    required this.category,
    required this.whatsAppNumber,
    required this.phoneNumber,
    required this.location,
    required this.district,
    required this.timeposted,
    required this.postedBy,
  });

  Map<String, dynamic> toMap() {
    return {
      'adId':adId,
      'images': images,
      'title': title,
      'description': description,
      'price': price,
      'condition': condition,
      'category': category,
      'whatsAppNumber': whatsAppNumber,
      'phoneNumber': phoneNumber,
      'location': location,
      'district': district,
      'timePosted': timeposted,
      'postedBy': postedBy,
    };
  }

  // Add a factory method to create AdModel objects from a map
  factory AdModel.fromMap(Map<String, dynamic> map) {
    return AdModel(
    map['adId'] ,
      images: List<String>.from(map['images']),
      title: map['title'],
      description: map['description'],
      price: map['price'],
      condition: map['condition'],
      category: map['category'],
      whatsAppNumber: map['whatsAppNumber'],
      phoneNumber: map['phoneNumber'],
      location: map['location'],
      district: map['district'],
      timeposted: (map['timePosted'] as Timestamp).toDate(),
      postedBy: map['postedBy'],
    );
  }

}




