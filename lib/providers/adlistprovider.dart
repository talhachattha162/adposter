import 'package:flutter/material.dart';

import '../models/admodels.dart';

class AdListProvider extends ChangeNotifier{

  String _searchText = '';
  bool _isLoading=false;
  List<AdModel> _ads=[];

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }


  List<AdModel> get ads => _ads;

  set ads(List<AdModel> value) {
    _ads = value;
    notifyListeners();
  }

  String get searchText => _searchText;

  set searchText(String value) {
    _searchText = value;
    notifyListeners();
  }
}