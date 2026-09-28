import 'package:dio/dio.dart';
import '../Model/NewsModel.dart';
import 'NewsResponse/NewsResponse.dart';

class NewsApiService {
  final Dio _dio = Dio();

  static const String _apiKey = 'pub_c5861c8cbb96435fb12d2b607be75211';
  static const String _baseUrl = 'https://newsdata.io/api/1/latest';

  Future<List<NewsArticle>> allNews(String category) async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {
          'apikey': _apiKey,
          'country': 'in',
          'language': 'hi,en',
          'category': category.toLowerCase(),
          'video': 1,
        },
      );

      if (response.statusCode == 200 ) {
        final newsResponse = NewsResponse.fromJson(response.data);
        return newsResponse.results;
      } else {
        throw 'Failed to load news from server';
      }
    } on DioException catch (e) {
      final serverMessage = e.response?.data?['results']?['message'];
      throw serverMessage ?? e.message ?? 'Network error occurred';
    } catch (e) {
      throw e.toString();
    }
  }
}
