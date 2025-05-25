class VideoModel {
  final String key;
  final String site;
  final String type;

  VideoModel({required this.key, required this.site, required this.type});

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      key: (map['key'] != null && map['key'] != '') 
        ? map['key'] 
        : 'N_yu136hKMQ',
      site: map['site'],
      type: map['type'],
    );
  }
}

