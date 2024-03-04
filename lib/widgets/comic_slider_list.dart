import 'package:flutter/material.dart';

import '../models/comic.dart';

class ComicSliderList extends StatefulWidget {

  final List<Comic> comics;
  final String? title;

  const ComicSliderList({

    required this.comics,
    this.title,
    super.key,

  });

  @override
  State<ComicSliderList> createState() => _ComicSliderListState();
}

class _ComicSliderListState extends State<ComicSliderList> {

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
                  itemCount: widget.comics.length,
                  itemBuilder: (_, int index) {
                    return
                      _ComicPoster(
                        widget.comics[index],
                      );
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


  const _ComicPoster(this.comic);

  @override
  Widget build(BuildContext context) {

    return Container(

      child: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
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
                                        ),
                                      ),
                                    ]
                                ),
                            ),

                          ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, 'details', arguments: comic),
                  child: Container(
                            width: 140,
                            height: 190,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, bottom: 10, right: 10), // Margen para el texto
                              child: Align(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${comic.name!} #${comic.issueNumber}',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                      maxLines: 2, // Máximo dos líneas de texto
                                      overflow: TextOverflow.ellipsis, // Trunca el texto si es necesario
                                    ),
                                    Text(
                                      '${comic.coverDate.day.toString()} ${getMonthText(comic.coverDate.month)}, ${comic.coverDate.year.toString()}',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                      maxLines: 1, // Máximo una línea de texto
                                      overflow: TextOverflow.ellipsis, // Trunca el texto si es necesario
                                    ),
                                    SizedBox(height: 5,),

                                    Text(
                                      comic.description!.replaceAll(RegExp(r'<[^>]*>'), ''), // More robust regular expression
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 8,
                                      ),
                                      maxLines: 6, // Maximum lines of text
                                      overflow: TextOverflow.ellipsis, // Truncate if necessary
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),


                ),
              ),
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