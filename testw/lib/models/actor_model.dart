class ActorModel {
  final String name;
  final String character;
  final String profilePath;

  ActorModel({required this.name, required this.character, required this.profilePath});

  factory ActorModel.fromMap(Map<String, dynamic> map) {
    return ActorModel(
      name: map['name'],
      character: map['character'],
      profilePath: (map['profile_path'] != null && map['profile_path'] != '')
      ? 'https://image.tmdb.org/t/p/w200${map['profile_path']}'
        : 'https://cdn-icons-png.flaticon.com/128/1177/1177568.png',
    );
  }
}
