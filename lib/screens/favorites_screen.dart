import 'package:flutter/material.dart';
import 'package:testw/models/popular_model.dart';
import 'package:testw/network/api_popular.dart';
import 'package:testw/models/favorites_manager.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<int> favoriteIds = [];
  List<PopularModel> favoriteMovies = [];
  bool isLoading = true;
  ApiPopular apiPopular = ApiPopular();

  @override
  void initState() {
    super.initState();
    cargarFavoritos();
  }

  Future<void> cargarFavoritos() async {
    favoriteIds = FavoritesManager().favorites;

    List<PopularModel> movies = [];
    for (int id in favoriteIds) {
      PopularModel? movie = await apiPopular.getMovieById(id);
      if (movie != null) {
        movies.add(movie);
      }
    }

    setState(() {
      favoriteMovies = movies;
      isLoading = false;
    });
  }

  void removeFavorite(int movieId) {
    FavoritesManager().removeFavorite(movieId);
    setState(() {
      favoriteMovies.removeWhere((movie) => movie.id == movieId);
      favoriteIds.remove(movieId);
    });
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
          "Tus Favoritas",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            fontFamily: 'Roboto',
            shadows: [
              Shadow(
                blurRadius: 2,
                color: Colors.black45,
                offset: Offset(1, 1),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black,
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.redAccent))
          : favoriteMovies.isEmpty
              ? Center(
                  child: Text(
                    "No tienes películas favoritas",
                    style: TextStyle(fontSize: 18, color: Colors.white70),
                  ),
                )
              : ListView.separated(
                  padding: EdgeInsets.all(12),
                  separatorBuilder: (_, __) => SizedBox(height: 12),
                  itemCount: favoriteMovies.length,
                  itemBuilder: (context, index) {
                    final movie = favoriteMovies[index];
                    return GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/detail', arguments: movie).then((_) {
                        cargarFavoritos();
                      }),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black87,
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Hero(
                              tag: movie.id,
                              child: ClipRRect(
                                borderRadius: BorderRadius.horizontal(left: Radius.circular(14)),
                                child: FadeInImage(
                                  placeholder: AssetImage('assets/images/loading.gif'),
                                  image: NetworkImage(
                                    movie.posterPath.isNotEmpty
                                        ? 'https://image.tmdb.org/t/p/w200${movie.posterPath}'
                                        : 'https://via.placeholder.com/100x150?text=No+Image',
                                  ),
                                  width: 100,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      movie.title,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(
                                            blurRadius: 2,
                                            color: Colors.black54,
                                            offset: Offset(1, 1),
                                          ),
                                        ],
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      movie.releaseDate,
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                    SizedBox(height: 12),
                                    Text(
                                      movie.overview,
                                      style: TextStyle(color: Colors.white60, fontSize: 14),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red[700], size: 36),
                              onPressed: () => removeFavorite(movie.id),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
