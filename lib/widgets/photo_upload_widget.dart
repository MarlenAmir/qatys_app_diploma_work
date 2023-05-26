import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../screens/provider/image_provider/user_provider.dart';




class PhotoUploadWidget extends StatefulWidget {
  @override
  _PhotoUploadWidgetState createState() => _PhotoUploadWidgetState();
}

class _PhotoUploadWidgetState extends State<PhotoUploadWidget> {
  late String _userId;
  File? _image;
  String? _uploadedImageUrl;

  @override
  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    // Здесь вы должны получить идентификатор пользователя (например, из Firebase Authentication)
    // Присвойте его значению переменной _userId.
    // Проверьте, существует ли профиль пользователя в Firestore.
    // Если профиль отсутствует, сохраните фото по умолчанию в поле "profileImage".
    _userId = user!.uid; // Замените YOUR_USER_ID на реальный идентификатор пользователя.
    _checkUserProfile();
  }

  Future<void> _checkUserProfile() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('users').doc(_userId).get();

    if (snapshot.exists) {
  var data = snapshot.data();
  // Проверяем, что поле 'profileImage' существует в документе
  if (data != null && data.containsKey('profileImage')) {
    setState(() {
      _uploadedImageUrl = data['profileImage'];
    });
  } else {
    // Если поле 'profileImage' не существует, устанавливаем значение по умолчанию
    setState(() {
      _uploadedImageUrl = null; // Или установите URL к фото по умолчанию
    });
  }
} else {
  // Если документ не существует, устанавливаем значение по умолчанию
  setState(() {
    _uploadedImageUrl = null; // Или установите URL к фото по умолчанию
  });
}
  }

  Future<void> _saveDefaultProfileImage() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageReference = storage.ref().child('images/logo.png');
    UploadTask uploadTask = storageReference.putFile(File('images/logo.png'));

    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    String imageUrl = await taskSnapshot.ref.getDownloadURL();

    await FirebaseFirestore.instance.collection('users').doc(_userId).set({
      'profileImage': imageUrl,
    });
  }

  Future<void> _getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _uploadedImageUrl = null; // Сбрасываем URL при выборе нового изображения
      }
    });
  }

  Future<void> _uploadImage() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageReference = storage.ref().child('profileImages/$_userId.png');
    UploadTask uploadTask = storageReference.putFile(_image!);

    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    String imageUrl = await taskSnapshot.ref.getDownloadURL();

    setState(() {
      _uploadedImageUrl = imageUrl;
    });

    // Сохраняем URL изображения в профиле пользователя
    await FirebaseFirestore.instance.collection('users').doc(_userId).update({
      'profileImage': imageUrl,
    });
    Provider.of<AvatarProvider>(context, listen: false).updateImageUrl(imageUrl);
    
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage:Provider.of<AvatarProvider>(context).imageUrl != null
              ? NetworkImage(Provider.of<AvatarProvider>(context).imageUrl!) as ImageProvider<Object>
              : AssetImage('images/logo.png'),
          backgroundColor: Colors.amberAccent,
        ),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFF3EE07F),
            borderRadius: BorderRadius.circular(15),
          ),
          margin: EdgeInsets.only(left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: _getImage,
                child: Text(
                  "Выбрать фото",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: _uploadImage,
                child: Text(
                  "Загрузить фото",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
