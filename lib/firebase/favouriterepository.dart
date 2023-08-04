import 'package:AdvertiseMe/models/favourite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteRepository {
  final String collectionPath = 'favorites'; // Replace with your collection path
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<void> addFavorite(FavouriteModel favorite) async {
    try {
      DocumentReference newAdRef = _firestore.collection(collectionPath).doc();
      String newFavId = newAdRef.id;
      favorite.favId= newFavId;
      await _firestore.collection(collectionPath).add(favorite.toJson());
    } catch (e) {
      print('Error adding favorite: $e');
    }
  }


  Future<void> deleteFavorite(String favoriteId) async {
    try {
      await _firestore.collection(collectionPath).doc(favoriteId).delete();
    } catch (e) {
      print('Error deleting favorite: $e');
    }
  }


  // Function to fetch all favorites from Firebase for a specific user
  Future<List<FavouriteModel>> fetchAllFavoritesForUser(String? userEmail) async {
    try {
      final snapshot = await _firestore
          .collection(collectionPath)
          .where('userEmail', isEqualTo: userEmail)
          .get();

      final favorites = snapshot.docs
          .map((doc) => FavouriteModel.fromJson(doc.data()))
          .toList();

      return favorites;
    } catch (e) {
      print('Error fetching favorites: $e');
      throw Exception('Failed to fetch favorites.');
    }
  }

}
