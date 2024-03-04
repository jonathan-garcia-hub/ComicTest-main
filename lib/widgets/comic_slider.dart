import 'package:flutter/material.dart';
import '../models/models.dart';

class ComicSlider extends StatefulWidget {

  final List<Comic> comics;
  final String? title;

  const ComicSlider({

    required this.comics,
    this.title,
    super.key,

  });

  @override
  State<ComicSlider> createState() => _ComicSliderState();
}

class _ComicSliderState extends State<ComicSlider> {

  final ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Column(

        children: [
          if (widget.title != null)
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  widget.title!,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
            ),

          const SizedBox(width: 5),

          Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.only(top: 10),
                  controller: scrollController,
                  scrollDirection: Axis.vertical,
                  itemCount: (widget.comics.length / 2).ceil()+1,
                  itemBuilder: (_, int index) {
                    final int firstIndex = index * 2;
                    final int secondIndex = firstIndex + 1;

                    return
                      secondIndex <= widget.comics.length ?
                      _ComicPoster(
                        widget.comics[firstIndex],
                        widget.comics[secondIndex],
                      ) : SizedBox(height: 60,);
                  },
              )
          ),
        ],
      ),
    );
  }
}

class _ComicPoster extends StatelessWidget {

  final Comic comic;
  final Comic comic2;


  const _ComicPoster(this.comic, this.comic2);

  @override
  Widget build(BuildContext context) {

    return Container(

      child: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [

              //Elemento 1
              comic.id != 0 ?
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: GestureDetector(
                            onTap: () => Navigator.pushNamed(context, 'details', arguments: comic),
                            child: Hero(
                              tag: comic.id,
                              child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: FadeInImage(
                                          placeholder: AssetImage('assets/no-image.jpg'),
                                          image: NetworkImage(comic.image),
                                          width: 140,
                                          height: 190,
                                          fit: BoxFit.cover,
                                          imageErrorBuilder: (context, error, stackTrace) {
                                            // Handle image loading error
                                            print(error); // Log the error for debugging
                                            return Image.asset(
                                              'assets/no-image.jpg',
                                              width: 140,
                                              height: 190,
                                              fit: BoxFit.cover,
                                            ); // Show the placeholder image
                                          },
                                        ),
                                      ),
                                      Container(
                                        width: 140,
                                        height: 190,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20), // Bordes redondeados de la imagen
                                          gradient: LinearGradient( // Gradiente oscuro para la zona inferior
                                            begin: Alignment.center,
                                            end: Alignment.bottomCenter,
                                            colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10, bottom: 10, right: 10), // Margen para el texto
                                          child: Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${comic.name!} #${comic.issueNumber}',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                  ),
                                                  maxLines: 2, // Máximo dos líneas de texto
                                                  overflow: TextOverflow.ellipsis, // Trunca el texto si es necesario
                                                ),
                                                Text(
                                                  '${comic.coverDate.day.toString()} ${getMonthText(comic.coverDate.month)}, ${comic.coverDate.year.toString()}',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 8,
                                                  ),
                                                  maxLines: 1, // Máximo una línea de texto
                                                  overflow: TextOverflow.ellipsis, // Trunca el texto si es necesario
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]
                                ),
                            ),

                          ),
              ): SizedBox(),

              //Elemento 2
              comic2.id != 0 ?
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, 'details', arguments: comic2),
                  child: Hero(
                    tag: comic2.id,
                    child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: FadeInImage(
                                placeholder: AssetImage('assets/no-image.jpg'),
                                image: NetworkImage(comic2.image),
                                width: 140,
                                height: 190,
                                fit: BoxFit.cover,
                                imageErrorBuilder: (context, error, stackTrace) {
                                  // Handle image loading error
                                  print(error); // Log the error for debugging
                                  return Image.asset(
                                      'assets/no-image.jpg',
                                      width: 140,
                                      height: 190,
                                      fit: BoxFit.cover,
                                  ); // Show the placeholder image
                                },
                              ),
                            ),
                            Container(
                              width: 140,
                              height: 190,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20), // Bordes redondeados de la imagen
                                gradient: LinearGradient( // Gradiente oscuro para la zona inferior
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 10, bottom: 10, right: 10), // Margen para el texto
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${comic2.name!} #${comic2.issueNumber}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                        maxLines: 2, // Máximo dos líneas de texto
                                        overflow: TextOverflow.ellipsis, // Trunca el texto si es necesario
                                      ),
                                      Text(
                                        '${comic2.coverDate.day.toString()} ${getMonthText(comic2.coverDate.month)}, ${comic2.coverDate.year.toString()}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 8,
                                        ),
                                        maxLines: 1, // Máximo dos líneas de texto
                                        overflow: TextOverflow.ellipsis, // Trunca el texto si es necesario
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ]
                      ),
                  ),

                ),
              ) : SizedBox(),
            ]
          ),
        ],
      ),
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