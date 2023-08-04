class FavouriteModel {
   String favId;
  final String? userEmail;
  final String adId;

  FavouriteModel(this.favId,{required this.userEmail, required this.adId});

  factory FavouriteModel.fromJson(Map<String, dynamic> json) {
    return FavouriteModel(
      json['favId'],
      userEmail: json['userEmail'],
      adId: json['adId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userEmail': userEmail,
      'adId': adId,
      'favId': favId,
    };
  }

}
