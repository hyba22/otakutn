import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/anime.dart';
import '../pages/anime_detail_page.dart';
import '../providers/anime_provider.dart';

class AnimeCard extends StatelessWidget {
  final Anime anime;
  final VoidCallback? onFavoriteToggle;

  const AnimeCard({
    Key? key,
    required this.anime,
    this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AnimeDetailPage(
                animeId: anime.id,
                animeTitle: anime.title ?? 'Unknown Title',
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
                child: Stack(
                  children: [
                    if (anime.imageUrl?.isNotEmpty ?? false)
                      Image.network(
                        anime.imageUrl!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        errorBuilder: (_, __, ___) => Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.error, size: 40, color: Colors.grey),
                        ),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: Colors.grey[200],
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      )
                    else
                      Container(
                        color: Colors.grey[200],
                        child: const Icon(Icons.movie, size: 60, color: Colors.grey),
                      ),
                    // Favorite button
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () {
                          final provider = Provider.of<AnimeProvider>(context, listen: false);
                          provider.toggleFavorite(anime.id);
                          if (onFavoriteToggle != null) {
                            onFavoriteToggle!();
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            anime.isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: anime.isFavorite ? Colors.red : Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Title and info
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    anime.title ?? 'Titre inconnu',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  if (anime.rating > 0)
                    Row(
                      children: [
                        const Icon(Icons.star, size: 16, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          anime.rating.toStringAsFixed(1),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
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