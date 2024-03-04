import 'package:flutter/material.dart';
import 'package:comics/providers/comic_provider.dart';
import 'package:comics/widgets/comic_slider_list.dart';
import 'package:provider/provider.dart';

import '../widgets/comic_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  bool _gridMode = true;

  @override
  Widget build(BuildContext context) {
    final comicsProvider = Provider.of<ComicProvider>(context);

    return Scaffold(
      body:

      comicsProvider.comicsList.isNotEmpty?
      SingleChildScrollView(
            child: Column(

              children: [
                SizedBox(height: 50,),

                _gridMode ?
                ComicSlider(
                  comics: comicsProvider.comicsList,
                  title: 'Latest Comics (grid)',
                ):
                ComicSliderList(
                  comics: comicsProvider.comicsList,
                  title: 'Latest Comics (list)',
                ),
              ],
            ),
          ):
          Center(child: CircularProgressIndicator(),),

      floatingActionButton: Container(
        height: 40,
        width: 40,
        margin: EdgeInsets.only(left: 10, top: 15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.cyanAccent, Colors.blueAccent],
          ),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              _gridMode = !_gridMode;
            });
          },
          mini: true,
          child:
          _gridMode?
            Icon(Icons.grid_view_rounded):Icon(Icons.view_list_rounded),
          backgroundColor: Colors.transparent,
          elevation: 0,
          heroTag: 'homeFloatting',
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}
