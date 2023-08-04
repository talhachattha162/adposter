import 'dart:io';
import 'package:flutter/material.dart';

class PublishAdProvider extends ChangeNotifier {

  String? _selectedCondition;
  String _selectedCategory = 'Electronics';
  bool _useWhatsApp = true;
  bool _isLoading = false;
  List<File> _selectedImages = [];
  List<String> _images = [];

  // Implement getters for each field
  String? get selectedCondition => _selectedCondition;
  String get selectedCategory => _selectedCategory;
  bool get useWhatsApp => _useWhatsApp;
  bool get isLoading => _isLoading;
  List<File> get selectedImages => _selectedImages;
  List<String> get images => _images;

  // Implement setters for each field
  set selectedCondition(String? condition) {
    _selectedCondition = condition;
    notifyListeners();
  }

  set images(List<String> value) {
    _images = value;
    notifyListeners();
  }

  set selectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  set useWhatsApp(bool useWhatsApp) {
    _useWhatsApp = useWhatsApp;
    notifyListeners();
  }

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  set selectedImages(List<File> images) {
    _selectedImages=images;
    notifyListeners();
  }

}
