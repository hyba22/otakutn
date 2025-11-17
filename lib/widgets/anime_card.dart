import 'package:flutter/material.dart';
import '../models/anime.dart';

class AnimeCard extends StatelessWidget {
  final Anime anime;

  const AnimeCard({
    Key? key,
    required this.anime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ListTile(
        leading: (anime.imageUrl?.isNotEmpty ?? false)
            ? ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: Image.network(
                  anime.imageUrl!,
                  width: 60,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.error, size: 30),
                ),
              )
            : const Icon(Icons.movie, size: 40),
        title: Text(
          anime.title ?? 'Titre inconnu',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          (anime.synopsis?.isNotEmpty ?? false) || (anime.description?.isNotEmpty ?? false)
              ? '${(anime.synopsis ?? anime.description ?? '').substring(0, (anime.synopsis?.length ?? anime.description?.length ?? 0) > 50 ? 50 : (anime.synopsis?.length ?? anime.description?.length ?? 0))}...'
              : 'Aucune description disponible',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () {
          // Navigate to anime detail screen when implemented
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => AnimeDetailScreen(anime: anime),
          //   ),
          // );
        },
        trailing: anime.rating > 0
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 16),
                  const SizedBox(width: 4),
                  Text(anime.rating.toStringAsFixed(1)),
                ],
              )
            : null,
      ),
    );
  }
}
