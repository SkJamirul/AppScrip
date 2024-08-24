import 'package:flutter/material.dart';

PreferredSizeWidget appBarHome(
    {required BuildContext context,
    required bool isSearchBarVisible,
    required Function(String) onSearchChanged,
    required Function() toggleSearchBar}) {
  return AppBar(
    title: isSearchBarVisible
        ? TextField(
            autofocus: true,
            onChanged: onSearchChanged,
            decoration: const InputDecoration(
              hintText: 'Search by name...',
              border: InputBorder.none,
            ),
            style: const TextStyle(color: Colors.black, fontSize: 18.0),
          )
        : const Text('AppScrip'),
    actions: [
      IconButton(
        icon: Icon(isSearchBarVisible ? Icons.close : Icons.search),
        onPressed: toggleSearchBar,
      ),
    ],
  );
}
