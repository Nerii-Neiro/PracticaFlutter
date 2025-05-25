 import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:testw/models/popular_model.dart';
import 'package:testw/network/api_detail.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:testw/models/actor_model.dart';  
import 'package:testw/models/video_model.dart';  
import 'package:testw/models/favorites_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter/foundation.dart';



class DetailPopularMovie extends StatefulWidget {
  const DetailPopularMovie({super.key});

  @override
  State<DetailPopularMovie> createState() => _DetailPopularMovieState();
}

class _DetailPopularMovieState extends State<DetailPopularMovie> {
  YoutubePlayerController? _youtubeController;
  final apiDetail = ApiDetail();
  String? trailerKey;
  List<VideoModel> trailer = [];
  List<ActorModel> actors = [];
  bool isFavorite = false;
  late PopularModel movie;
  bool _didLoad = false;


@override
void didChangeDependencies() {
  super.didChangeDependencies();

  if (_didLoad) return; 
  _didLoad = true;

  final args = ModalRoute.of(context)?.settings.arguments;
  if (args is PopularModel) {
    movie = args;
    isFavorite = FavoritesManager().isFavorite(movie.id);

   
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cargarDetalles(movie.id);
    });
  } else {
    Navigator.of(context).pop(); 
  }
}


  @override
  void dispose() {
    _youtubeController?.dispose();
    super.dispose();
  }




Future<void> cargarDetalles(int movieId) async {
  

  final video = await apiDetail.getTrailer(movieId);
  trailerKey = video?.key;


  print('Trailer Key: $trailerKey');

final capturarActores = await apiDetail.getActors(movieId);

if (capturarActores == null || capturarActores.isEmpty) {
  actors = [
    ActorModel(
      name: "Desconocido",
      character: "No disponible",
      profilePath: "https://cdn-icons-png.flaticon.com/512/17/17004.png",
    ),
  ];
} else {
  actors = capturarActores.where((actor) => actor.name.isNotEmpty).toList();

  if (actors.isEmpty) {
    actors = [
      ActorModel(
        name: "Desconocido",
        character: "No disponible",
        profilePath: "https://cdn-icons-png.flaticon.com/512/17/17004.png",
      ),
    ];
  }
}


if (trailerKey != null && trailerKey!.isNotEmpty) {
  _youtubeController = YoutubePlayerController(
    initialVideoId: trailerKey!,
    flags: YoutubePlayerFlags(autoPlay: false, mute: false),
  );
} else {
  _youtubeController = null;
}


  setState(() {});
}



  Widget contruirEstrellas(double rating) {
    int fullStars = rating ~/ 2;
    bool halfStar = (rating / 2) - fullStars >= 0.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < fullStars) {
          return Icon(Icons.star, color: Colors.amber);
        } else if (index == fullStars && halfStar) {
          return Icon(Icons.star_half, color: Colors.amber);
        } else {
          return Icon(Icons.star_border, color: Colors.amber);
        }
      }),
    );
  }

  void toggleFavorite() {
    setState(() {
      if (isFavorite) {
        FavoritesManager().removeFavorite(movie.id);
      } else {
        FavoritesManager().addFavorite(movie.id);
      }
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
appBar: AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  leading: IconButton(
    icon: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 28),
    onPressed: () => Navigator.of(context).pop(),
  ),
  actions: [
    IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
        size: 30,
        shadows: [
          Shadow(
            color: Colors.black45,
            blurRadius: 2,
            offset: Offset(1, 1),
          ),
        ],
      ),
      onPressed: toggleFavorite,
    ),
  ],
),

      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            movie.backdropPath,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Container(color: Colors.black.withOpacity(0.4)),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(color: Colors.black.withOpacity(0.2)),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: movie.id,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      movie.backdropPath,
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  movie.title,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                contruirEstrellas(movie.voteAverage),
                SizedBox(height: 12),
                Text(
                  movie.overview,
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20),

             
      if (!kIsWeb && _youtubeController != null)
        YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: _youtubeController!,
            showVideoProgressIndicator: true,
          ),
          builder: (context, player) => player,
        )
      else
        Container(
          height: 200,
          color: Colors.black12,
          child: Center(
            child: Text(
              kIsWeb
                  ? "Reproductor no disponible en Web"
                  : "No hay tráiler disponible",
              style: TextStyle(color: Colors.white54),
            ),
          ),
        ),


                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Actores",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 150,
                  child: actors.isNotEmpty
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: actors.length,
                          itemBuilder: (context, index) {
                            final actor = actors[index];
                            return Container(
                              width: 100,
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: actor.profilePath.isNotEmpty
                                        ? Image.network(
                                            actor.profilePath,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          )
                                        : Container(
                                            height: 100,
                                            color: Colors.grey[800],
                                            child: Icon(Icons.person,
                                                color: Colors.white70),
                                          ),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    actor.name,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    actor.character,
                                    style: TextStyle(
                                        color: Colors.white54, fontSize: 10),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Text(
                            "No se encontraron actores",
                            style: TextStyle(color: Colors.white54),
                          ),
                        ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}