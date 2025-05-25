import 'package:dio/dio.dart';
import 'package:testw/models/popular_model.dart';

class ApiPopular {

  final String apiKey = '5019e68de7bc112f4e4337a500b96c56';
  final Dio dio = Dio();

  final String popularUrl = 'https://api.themoviedb.org/3/movie/popular';
  
  final URL = 'https://api.themoviedb.org/3/movie/popular?api_key=5019e68de7bc112f4e4337a500b96c56&language=es-MX&page=1';

  Future<List<PopularModel>> getPopularMovies() async{
    final dio = Dio();
    final response = await dio.get(URL);
    final res = response.data['results'] as List;
    return res.map((movie) => PopularModel.fromMap(movie)).toList();
  }

  Future<PopularModel?> getMovieById(int id) async {
    final url = 'https://api.themoviedb.org/3/movie/$id?api_key=$apiKey&language=es-MX';
    try {
      final response = await dio.get(url);
      final data = response.data;
      return PopularModel.fromMap(data);
    } catch (e) {
      print('Error al obtener película por ID: $e');
      return null;
    }
  }

}
