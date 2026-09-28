import '../../Model/NewsModel.dart';

class NewsResponse {
  final String status;
  final int totalResults;
  final List<NewsArticle> results;
  final String? nextPage;

  NewsResponse({
    required this.status,
    required this.totalResults,
    required this.results,
    this.nextPage,
  });

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    return NewsResponse(
      status: json['status'] ?? '',
      totalResults: json['totalResults'] ?? 0,
      results: (json['results'] as List<dynamic>? ?? [])
          .map((e) => NewsArticle.fromJson(e))
          .toList(),
      nextPage: json['nextPage'],
    );
  }
}