import 'package:camera/camera.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/ui/camera/Camera.dart';
import 'package:namer_app/ui/favorites/FavoritesPageViewModel.dart';
import 'package:namer_app/ui/generator/GeneratorPageViewModel.dart';
import 'package:namer_app/ui/weather/WeatherPage.dart';
import 'package:namer_app/ui/weather/WeatherViewModel.dart';
import 'package:provider/provider.dart';

import 'ui/favorites/FavoritesPage.dart';
import 'ui/generator/GeneratorPage.dart';
import 'ui/geoposition/GeopositionPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();

  final camera = cameras.first;
  runApp(MyApp(
    camera: camera,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.camera});

  final CameraDescription camera;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WeatherViewModel()),
        ChangeNotifierProvider(create: (_) => GeneratorPageViewModel()),
        ChangeNotifierProvider(create: (_) => FavoritePageViewModel()),
        ChangeNotifierProvider(create: (_) => GeneratorPageViewModel());
        ChangeNotifierProvider(create: (_) => MyAppState()),
      ],
      child: MaterialApp(
        title: 'Test App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        ),
        home: MyHomePage(
          camera: camera,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.camera});

  final CameraDescription camera;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        Provider.of<FavoritePageViewModel>(context).fetchFavoritesData();
        page = Favorites();
        break;
      case 2:
        page = CameraWidget(camera: widget.camera,);
        break;
      case 3:
        Provider.of<WeatherViewModel>(context).fetchWeatherData();
        page = WeatherWidget();
        break;
      case 4:
        Provider.of<FavoritePageViewModel>(context).fetchFavoritesData();
        page = GeopositionPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_add_outlined),
              label: "Study",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book_outlined),
              label: "Dictionary",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt),
              label: "Camera",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cloud_outlined),
              label: "Weather",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.flag_circle),
              label: "GPS"
            )
          ],
          selectedItemColor: Colors.lightBlue,
          unselectedItemColor: Colors.black,
          currentIndex: selectedIndex,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
        ),
        body: Row(
          children: [
            Container(
              width: constraints.maxWidth,
              color: Theme.of(context).colorScheme.primaryContainer,

              child: page,
            ),
          ],
        ),
      );
    });




  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}
