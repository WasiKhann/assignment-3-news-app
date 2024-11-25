import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetails extends StatelessWidget {
  final Map article;

  NewsDetails({required this.article});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          article['urlToImage'] != null
              ? Image.network(article['urlToImage'])
              : SizedBox.shrink(),
          SizedBox(height: 10),
          Text(
            article['title'] ?? 'No Title',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(article['description'] ?? 'No Description'),
          SizedBox(height: 10),
          Text('Published At: ${article['publishedAt'] ?? 'Unknown'}'),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final url = article['url'];
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Could not open the article link.'),
                ));
              }
            },
            child: Text('View Article'),
          ),
        ],
      ),
    );
  }
}
