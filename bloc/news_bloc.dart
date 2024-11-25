import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class NewsEvent {}

class FetchNewsEvent extends NewsEvent {}

abstract class NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List articles;

  NewsLoaded(this.articles);
}

class NewsError extends NewsState {}

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsLoading()) {
    on<FetchNewsEvent>(_onFetchNews);
  }

  final String apiKey = 'abb021fcd9124fe4a756d19365dc0136';
  final String baseUrl = 'https://newsapi.org/v2/top-headlines?country=us';

  Future<void> _onFetchNews(
      FetchNewsEvent event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    try {
      final response = await http.get(Uri.parse('$baseUrl&apiKey=$apiKey'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        emit(NewsLoaded(data['articles']));
      } else {
        emit(NewsError());
      }
    } catch (_) {
      emit(NewsError());
    }
  }
}
