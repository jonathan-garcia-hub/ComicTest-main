import 'package:flutter/material.dart';
import '../models/comic.dart';
import '../widgets/detail_cards.dart';

class ComicDetailsScreen extends StatefulWidget {
  @override
  _ComicDetailsScreenState createState() => _ComicDetailsScreenState();
}

class _ComicDetailsScreenState extends State<ComicDetailsScreen> {
  bool _showOverlay = false;

  @override
  Widget build(BuildContext context) {

    final Comic comic = ModalRoute.of(context)!.settings.arguments as Comic;

    return Scaffold(
      body:
      GestureDetector(
        onTap: () {
          setState(() {
            _showOverlay = !_showOverlay; // Cambia el estado para mostrar/ocultar la capa de superposición
          });
        },
        child: Hero(
          tag: comic.id,
          child:
          Stack(
            children: [
              Image.network(
                comic.image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  // Handle image loading error
                  print(error); // Log the error for debugging
                  return Image.asset(
                    'assets/no-image.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ); // Show the placeholder image
                },
              ),

              if (_showOverlay) // Mostrar la capa de superposición solo si se toca la imagen
                Container(
                  color: Colors.black.withOpacity(0.5), // Capa semitransparente para el efecto de superposición
                ),

              AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                bottom: _showOverlay ? 0 : -800.0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), // Bordes redondeados de la imagen
                    gradient: LinearGradient( // Gradiente oscuro para la zona inferior
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black.withOpacity(0.1), Colors.black.withOpacity(0.8)],
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${comic.name!} #${comic.issueNumber}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2, // Máximo dos líneas de texto
                        overflow: TextOverflow.ellipsis, // Trunca el texto si es necesario
                      ),
                      SizedBox(height: 5,),
                      Text(
                        '${comic.coverDate.day.toString()} ${getMonthText(comic.coverDate.month)}, ${comic.coverDate.year.toString()}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                        maxLines: 2, // Máximo dos líneas de texto
                        overflow: TextOverflow.ellipsis, // Trunca el texto si es necesario
                      ),
                      SizedBox(height: 20,),

                      //Muestra los 3 primeros actores obtenidos
                      DetailCards( comic.id ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

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
            Navigator.pop(context);
          },
          child: Icon(Icons.close),
          backgroundColor: Colors.transparent,
          elevation: 0,
          heroTag: 'detailsFloatting',
          mini: true,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,

    );
  }
}

String getMonthText(int monthNumber) {
  switch (monthNumber) {
    case 1:
      return "January";
    case 2:
      return "February";
    case 3:
      return "March";
    case 4:
      return "April";
    case 5:
      return "May";
    case 6:
      return "June";
    case 7:
      return "July";
    case 8:
      return "August";
    case 9:
      return "September";
    case 10:
      return "October";
    case 11:
      return "November";
    case 12:
      return "December";
    default:
      return "";
  }
}