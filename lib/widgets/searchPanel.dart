import 'package:diploma_work/widgets/foregroundWidget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diploma_work/widgets/foregroundWidget.dart';

class searchPanel extends StatefulWidget {
  
  final TextEditingController searchController;

  searchPanel({required this.searchController});

  @override
  State<searchPanel> createState() => _searchPanelState();
}



class _searchPanelState extends State<searchPanel> {

  



  Widget build(BuildContext context) {
    return Container(
      
      width: 370,
      height: 50,
      child: TextField(
        controller: widget.searchController,
        maxLines: 1,
        minLines: 1,
        decoration: InputDecoration(
          prefixIcon: Image.asset('images/search-01.png'),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          labelText: "Поиск",
        ),
      ),
    );
  }
} 
