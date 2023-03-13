import 'package:flutter/material.dart';

class searchPanel extends StatefulWidget {
  const searchPanel({super.key});

  @override
  State<searchPanel> createState() => _searchPanelState();
}

class _searchPanelState extends State<searchPanel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
      width: 370,
      height: 50,
      child: TextField(
        maxLines: 1,
        minLines: 1,
        decoration: InputDecoration(
          prefixIcon: Image.asset('images/search-01.png'),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          labelText: "Search",
        ),
      ),
    );
  }
}
