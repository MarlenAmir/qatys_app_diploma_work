import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';



class PhotoUploadWidget extends StatefulWidget {
  @override
  _PhotoUploadWidgetState createState() => _PhotoUploadWidgetState();
}

class _PhotoUploadWidgetState extends State<PhotoUploadWidget> {
  File? _image;
  ImageProvider<Object>? _uploadedImageUrl;

  Future _getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _uploadedImageUrl = FileImage(_image!);
      }
    });
  }

  Future _uploadImage() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageReference = storage.ref().child('images/logo.png');
    UploadTask uploadTask = storageReference.putFile(_image!);

    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    String imageUrl = await taskSnapshot.ref.getDownloadURL();

    setState(() {
      _uploadedImageUrl = NetworkImage(imageUrl);
    });

     SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('profileImageUrl', imageUrl);
  }

   Future<void> _loadProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imageUrl = prefs.getString('profileImageUrl');

    setState(() {
      if (imageUrl != null) {
        _uploadedImageUrl = NetworkImage(imageUrl);
      }
    });
  }

   @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: _uploadedImageUrl ?? AssetImage('images/logo.png'),
          backgroundColor: Colors.amberAccent,
        ),
        Container(
          margin: EdgeInsets.only(left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    backgroundColor: Color(0xFF646AFF)),
                onPressed: _getImage,
                child: Text(
                  "Выбрать фото",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.white),
                ),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    backgroundColor: Color(0xFF646AFF)),
                onPressed: _uploadImage,
                child: Text(
                  "Загрузить фото",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
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
