import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetails extends StatelessWidget {
  final Map article;

  NewsDetails({required this.article});

  @override
  Widget build(BuildContext context) {
    // Truncate content if it exceeds 100 characters
    String content = article['description'] ?? 'No Description';
    int overflowChars = 0;

    if (content.length > 100) {
      overflowChars = content.length - 100;
      content = '${content.substring(0, 100)}...[+$overflowChars chars]';
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display article image
            if (article['urlToImage'] != null)
              Image.network(article['urlToImage']!, fit: BoxFit.cover),
            const SizedBox(height: 10),

            // Display article title
            Text(
              article['title'] ?? 'No Title',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Display author
            Text(
              'By ${article['author'] ?? 'Unknown author'}',
            ),
            const SizedBox(height: 5),

            // Display published date
            Text(
              'Published on ${article['publishedAt']?.split('T').first ?? 'Unknown'}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 10),

            // Display article description
            Text(
              content,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
