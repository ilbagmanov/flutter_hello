import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/ui/generator/GeneratorPageViewModel.dart';
import 'package:provider/provider.dart';

import '../../data/local/model/Favorite.dart';
import '../../main.dart';

class GeneratorPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var generatorPageVm = context.watch<GeneratorPageViewModel>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.add_circle;
    } else {
      icon = Icons.add_circle_outline;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair),
          SizedBox(height: 10),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  var word = pair.toLowerCase();
                  if (!appState.favorites.contains(pair)) {
                    generatorPageVm.addFavorite(Favorite.word(word.first));
                  } else {
                    generatorPageVm.removeFavorite(Favorite.word(word.first));
                  }
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Save to dict'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text('I know'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
        color: theme.colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(pair.first,
              style: style, semanticsLabel: pair.first),
        ));
  }
}