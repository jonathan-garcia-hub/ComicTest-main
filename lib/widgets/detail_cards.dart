import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:comics/models/models.dart';
import 'package:provider/provider.dart';

import '../providers/comic_provider.dart';

class DetailCards extends StatelessWidget {

  final int comicId;
  const DetailCards(this.comicId);

  @override
  Widget build(BuildContext context) {

    final comicsProvider = Provider.of<ComicProvider>(context);

    return FutureBuilder(
        future: comicsProvider.getComicDetail(comicId),
        builder: ( _, AsyncSnapshot<Comic> snapshot){

          if (!snapshot.hasData){
            return Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: 150),
                height: 180,
                child: CupertinoActivityIndicator(
                  color: Colors.cyanAccent,
                ),
              ),
            );
          }

          final comic = snapshot.data!;

          return Column(
            children: [

                Column(
                  children: [
                    Text(
                      'Characters',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white,),
                    ),
                    SizedBox(height: 5),
                    comic.characterCredits.isNotEmpty ?
                    Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    child: ListView.builder(
                      itemCount: comic.characterCredits.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ( _, int index) {
                        return _CastCard(
                            image: comic.characterCredits[index].image!,
                            name: comic.characterCredits[index].name,
                        );
                      }
                    ),
              ):
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Text(
                        "No character data",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 8,
                        ),
                        maxLines: 2, // Máximo dos líneas de texto
                        overflow: TextOverflow.ellipsis, // Trunca el texto si es necesario
                      ),
                    ),
                  ],
                ),

                Column(
                  children: [
                    const Divider(
                      height: 10,
                      thickness: 1,
                      color: Colors.white,
                    ),
                    Text(
                      'Teams',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white,),
                    ),
                    SizedBox(height: 5),
                    comic.teamCredits.isNotEmpty ?
                    Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    child: ListView.builder(
                        itemCount: comic.teamCredits.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: ( _, int index) {
                          return _CastCard(
                            image: comic.teamCredits[index].image!,
                            name: comic.teamCredits[index].name,
                          );
                        }
                      ),
                    ):
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Text(
                        "No team data",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 8,
                        ),
                        maxLines: 2, // Máximo dos líneas de texto
                        overflow: TextOverflow.ellipsis, // Trunca el texto si es necesario
                      ),
                    ),

                  ],
                ),

                Column(
                  children: [
                    const Divider(
                      height: 10,
                      thickness: 1,
                      color: Colors.white,
                    ),
                    Text(
                      'Locations',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white,),
                    ),
                    SizedBox(height: 5),
                    comic.locationCredits.isNotEmpty ?
                    Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    child: ListView.builder(
                        itemCount: comic.locationCredits.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: ( _, int index) {
                          return _CastCard(
                            image: comic.locationCredits[index].image!,
                            name: comic.locationCredits[index].name,
                          );
                        }
                      ),
                    ): Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Text(
                        "No location data",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 8,
                        ),
                        maxLines: 2, // Máximo dos líneas de texto
                        overflow: TextOverflow.ellipsis, // Trunca el texto si es necesario
                      ),
                    ),
                  ],
                ),
            ],
          );
        }
    );
  }
}

class _CastCard extends StatelessWidget {

  final String image;
  final String name;

  const _CastCard({
    required this.image,
    required this.name,
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 110,
      height: 100,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {},
            child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: FadeInImage(
                          placeholder: AssetImage('assets/no-image.jpg'),
                          image: NetworkImage(image),
                          width: 100,
                          height: 140,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 140,
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
                                  name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                  maxLines: 2, // Máximo dos líneas de texto
                                  overflow: TextOverflow.ellipsis, // Trunca el texto si es necesario
                                ),
                                // Text(
                                //   character,
                                //   style: const TextStyle(
                                //     color: Colors.white,
                                //     fontWeight: FontWeight.bold,
                                //     fontSize: 8,
                                //   ),
                                //   maxLines: 1, // Máximo dos líneas de texto
                                //   overflow: TextOverflow.ellipsis, // Trunca el texto si es necesario
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]
                ),
          ),
        ],
      ),
    );
  }
}

