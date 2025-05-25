import 'package:flutter/material.dart';
import 'package:testw/models/popular_model.dart';
import 'package:testw/network/api_popular.dart';
import 'package:testw/models/favorites_manager.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key});

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  ApiPopular? apiPopular;

  @override
  void initState() {
    super.initState();
    apiPopular = ApiPopular();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  leading: IconButton(
    icon: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 28),
    onPressed: () => Navigator.of(context).pop(),
  ),
  title: Text(
    "Películas Populares",
    style: TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.2,
      fontFamily: 'Roboto',
      shadows: [
        Shadow(
          blurRadius: 2,
          color: Color.fromARGB(115, 0, 0, 0),
          offset: Offset(1, 1),
        ),
      ],
    ),
  ),
  backgroundColor: Color.fromARGB(221, 0, 0, 0),
  actions: [
    IconButton(
      icon: Icon(Icons.favorite, color: Colors.redAccent, size: 32),
      onPressed: () {
        Navigator.pushNamed(context, '/favorites');
      },
    ),
  ],
),

      backgroundColor: Colors.black,
      body: FutureBuilder<List<PopularModel>>(
        future: apiPopular!.getPopularMovies(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final movies = snapshot.data!;
            return GridView.builder(
              padding: EdgeInsets.all(12),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, 
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.65,
              ),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return _construirCard(movies[index]);
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString(), style: TextStyle(color: Colors.white)));
          } else {
            return Center(child: CircularProgressIndicator(color: Colors.red));
          }
        },
      ),
    );
  }

  Widget _construirCard(PopularModel movie) {
    bool isFav = FavoritesManager().isFavorite(movie.id);

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/detail', arguments: movie).then((_) => setState(() {})),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Stack(
          children: [
            Hero(
              tag: movie.id,
              child: FadeInImage(
                placeholder: AssetImage('assets/images/loading.gif'),
                image: NetworkImage(movie.backdropPath),
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.85),
                  ],
                  stops: [0.5, 1],
                ),
              ),
            ),
            // Texto con título y favorito
            Positioned(
              bottom: 12,
              left: 12,
              right: 12,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      movie.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        shadows: [
                          Shadow(
                            color: Colors.black87,
                            offset: Offset(1, 1),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      key: ValueKey<bool>(isFav),
                      color: Colors.redAccent,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
