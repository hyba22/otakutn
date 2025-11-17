
class Episode {
  final String id;
  final String animeId;
  final int number;
  final String title;
  final String description;
  final String videoUrl;
  final String thumbnailUrl;
  final int duration; // en secondes
  final bool isWatched;

  Episode({
    required this.id,
    required this.animeId,
    required this.number,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.duration,
    this.isWatched = false,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['id']?.toString() ?? '',
      animeId: json['animeId']?.toString() ?? '',
      number: json['number'] ?? 0,
      title: json['title'] ?? 'Épisode ${json['number']}',
      description: json['description'] ?? '',
      videoUrl: json['videoUrl'] ?? '',
      thumbnailUrl: json['thumbnailUrl'] ?? '',
      duration: json['duration'] ?? 0,
      isWatched: json['isWatched'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'animeId': animeId,
      'number': number,
      'title': title,
      'description': description,
      'videoUrl': videoUrl,
      'thumbnailUrl': thumbnailUrl,
      'duration': duration,
      'isWatched': isWatched,
    };
  }
}