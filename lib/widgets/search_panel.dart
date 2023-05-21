
import 'package:flutter/material.dart';

class SearchPanel extends StatefulWidget {
  
  final TextEditingController searchController;

  const SearchPanel({super.key, required this.searchController});

  @override
  State<SearchPanel> createState() => _SearchPanelState();
}



class _SearchPanelState extends State<SearchPanel> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
