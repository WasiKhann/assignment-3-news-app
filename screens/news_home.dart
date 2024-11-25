import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import '../bloc/news_bloc.dart';
import 'news_details.dart';

class NewsHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png',
              height: 30,
            ),
            const SizedBox(width: 10),
            const Text('Headline News'),
          ],
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsLoading) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ListView.builder(
                itemCount: 6,
                itemBuilder: (_, __) => ListTile(
                  title: Container(
                    height: 20,
                    color: Colors.white,
                  ),
                  subtitle: Container(
                    height: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          } else if (state is NewsLoaded) {
            return ListView.builder(
              itemCount: state.articles.length,
              itemBuilder: (context, index) {
                final article = state.articles[index];
                return ListTile(
                  leading: article['urlToImage'] != null
                      ? Image.network(article['urlToImage'],
                          width: 50, fit: BoxFit.cover)
                      : const Icon(Icons.image),
                  title: Text(article['title'] ?? 'No Title'),
                  subtitle: Text(article['author'] ?? 'Unknown Author'),
                  onTap: () => showModalBottomSheet(
                    context: context,
                    builder: (context) => NewsDetails(article: article),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('Error fetching news.'));
          }
        },
      ),
    );
  }
}
