import 'package:flutter/material.dart';
import '../services/cloudinary_service.dart';
import '../widgets/video_player_widget.dart';

class VideoPlayerPage extends StatelessWidget {
  final String episodeId;
  final String episodeTitle;
  final String animeTitle;

  const VideoPlayerPage({
    Key? key,
    required this.episodeId,
    required this.episodeTitle,
    required this.animeTitle,
  }) : super(key: key);

  // Map of anime titles to their episode URLs , we took just 3 eps for test 
  static const Map<String, Map<int, String>> _animeEpisodes = <String, Map<int, String>>{
    'Sousou no Frieren': <int, String>{
      1: 'https://res.cloudinary.com/dhth3wpkz/video/upload/v1763633705/Frieren_Magic_Exam_Best_Moments_Frieren_Beyond_Journey_s_End_jkrudd.mp4',
      2: 'https://res.cloudinary.com/dhth3wpkz/video/upload/v1763635375/Frieren_-_ALL_DEMON_FIGHTS_Aura_Linie_Lugner_fn5xik.mp4',
    },
    'Gintama': <int, String>{
      1: 'https://res.cloudinary.com/dhth3wpkz/video/upload/v1763640823/Gintaman_Full_HD_Engsub_d85ocs.mp4',
    },
  };

  String _getVideoUrl() {
    // Extract episode number from episodeId
    final episodeNumber = int.tryParse(episodeId.replaceAll(RegExp(r'[^0-9]'), '')) ?? 1;
    
    // Find the anime in our map
    final animeEntry = _animeEpisodes.entries.firstWhere(
      (entry) => animeTitle.toLowerCase().contains(entry.key.toLowerCase()),
      orElse: () => _animeEpisodes.entries.first,
    );
    
    // Get the specific episode or fallback to first episode
    return animeEntry.value[episodeNumber] ?? animeEntry.value.values.first;
  }

  @override
  Widget build(BuildContext context) {
    final cloudinary = CloudinaryService();
    final videoUrl = _getVideoUrl();

    return Scaffold(
      appBar: AppBar(
        title: Text(episodeTitle),
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: CloudinaryVideoPlayer(
              videoUrl: videoUrl,
              autoPlay: true,
              looping: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              episodeTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ],
      ),
    );
  }
}