import 'package:flutter/material.dart';
import 'package:comics/providers/comic_provider.dart';
import 'package:comics/screens/comic_details_screen.dart';
import 'package:comics/screens/home_screen.dart';
import 'package:provider/provider.dart';


void main() => runApp(AppState());

class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: ( _ ) => ComicProvider(), lazy: false ),
        ],
        child: MyApp(),
    );
  }
}



class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Comics',
      initialRoute: 'home',
      routes: {
        'home': (_) => HomeScreen(),
        'details': (_) => ComicDetailsScreen(),
      },
    );
  }
}
