import 'package:flutter/material.dart';

class AvatarProvider extends ChangeNotifier {
  String? _imageUrl;

  String? get imageUrl => _imageUrl;

  void updateImageUrl(String? newImageUrl) {
    _imageUrl = newImageUrl;
    notifyListeners();
  }
}