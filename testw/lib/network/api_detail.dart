import 'package:dio/dio.dart';
import 'package:testw/models/video_model.dart';
import 'package:testw/models/actor_model.dart';

class ApiDetail {
  final _dio = Dio();
  final _apiKey = '5019e68de7bc112f4e4337a500b96c56';

  Future<VideoModel?> getTrailer(int movieId) async {
    final url = 'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=$_apiKey&language=en-US';

    try {
      final response = await _dio.get(url);
      final List results = response.data['results'];

      final trailer = results.firstWhere(
        (video) => video['site'] == 'YouTube' && video['type'] == 'Trailer',
        orElse: () => null,
      );

      if (trailer != null) {
        return VideoModel.fromMap(trailer);
      }
    } catch (e) {
      print('Error al obtener trailer: $e');
    }

    return VideoModel(key: 'N_yu136hKMQ', site: 'YouTube', type: 'Trailer');
  }

  Future<List<ActorModel>> getActors(int movieId) async {
    try {
      final url = 'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$_apiKey&language=es-MX';
      final response = await _dio.get(url);
      final List cast = response.data['cast'];
      return cast.map((actor) => ActorModel.fromMap(actor)).toList();
    } catch (e) {
      print('Error al obtener actores: $e');
      return [];
    }
  }
}
