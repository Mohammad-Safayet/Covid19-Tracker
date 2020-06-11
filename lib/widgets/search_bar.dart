import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final TextEditingController controller;
  final Function filter;
  final double height;

  const SearchBar({
    Key key,
    @required this.controller,
    @required this.filter,
    this.height,
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool _isSearching = false;

  void _cancel() {
    setState(() {
      widget.controller.clear();
      _isSearching = !_isSearching;

      FocusScope.of(context).unfocus();

      widget.filter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13.0),
      height: 80.0,
      child: Stack(
        alignment: Alignment.centerRight,
        children: <Widget>[
          TextField(
            controller: widget.controller,
            onTap: () {
              setState(() {
                _isSearching = !_isSearching;
              });
            },
            onChanged: (_) {
              widget.filter();
            },
            style: TextStyle(
              color: Colors.black,
              fontFamily: "JosefinSlab",
              fontSize: widget.height * 0.30,
              fontWeight: FontWeight.w900,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(13.0),
              fillColor: Colors.white,
              filled: true,
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              hintText: "Search Country",
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: widget.height * 0.30,
              ),
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.cancel,
              color: (_isSearching || widget.controller.text.isNotEmpty)
                  ? Colors.black
                  : Colors.grey,
            ),
            onPressed: (_isSearching || widget.controller.text.isNotEmpty)
                ? _cancel
                : null,
          ),
        ],
      ),
    );
  }
}
