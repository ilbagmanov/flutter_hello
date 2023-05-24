import 'package:flutter/material.dart';
import 'package:namer_app/ui/favorites/FavoritesPageViewModel.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class GeopositionPage extends StatelessWidget { // GeopositionPageViewModel
  @override
  Widget build(BuildContext context) {
    var favoritesVm = context.watch<FavoritePageViewModel>();

    if (favoritesVm.favorites.isEmpty) {
      return Center(
        child: Text("No favorites yet"),
      );
    }


    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: Text('You have ${favoritesVm.favorites.length} words:', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
        ),
        for (var favorite in favoritesVm.favorites)
          ListTile(
              leading: Icon(Icons.data_usage_sharp), title: Text(favorite.word.toLowerCase(),)),
      ],
    );
  }
}
