import 'package:flutter/material.dart';

class ObscurePasswordProvider extends ChangeNotifier {
  bool _obscurepassword=true;

  bool get obscurepassword => _obscurepassword;

  set obscurepassword(bool value) {
    _obscurepassword = value;
    notifyListeners();
  }
}