import 'package:AdvertiseMe/models/user.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileProvider extends ChangeNotifier{

  XFile? pickedImage;
bool _isLoading=false;
  UserModel? _user;
 int _currentPageViewAd=0;

  int get currentPageViewAd => _currentPageViewAd;

  set currentPageViewAd(int value) {
    _currentPageViewAd = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setpickedImage(XFile value) {
    pickedImage = value;
    notifyListeners();
  }

  UserModel? get user => _user;

  set user(UserModel? value) {
    _user = value;
    notifyListeners();
  }

}