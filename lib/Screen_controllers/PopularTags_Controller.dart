import 'package:get/get.dart';
import '../Model/NewsModel.dart';
import '../Service/Service.dart';

class PopularController extends GetxController {
  final NewsApiService _apiService = NewsApiService();

  var isLoadingLatest = true.obs;
  var isLoadingRecommended = true.obs;
  var latestNews = <NewsArticle>[].obs;
  var recommendedNews = <NewsArticle>[].obs;

  var selectedTag = '#FitdayMorning'.obs;
  var searchQuery = ''.obs;

  final List<String> popularTags = [
    '#FitdayMorning', '#CollegeColorsDay', '#InstagramDown',
    '#FitdayFeeling', '#ThursdayVibes', '#DigitalCurrency',
    '#Bitcoin', '#Cryptocurrency', '#KnifeTalk'
  ];

  @override
  void onInit() {
    super.onInit();
    fetchLatestNews('environment');
    fetchRecommendedNews('business');
  }

  void fetchLatestNews(String category) async {
    try {
      isLoadingLatest(true);
      var articles = await _apiService.allNews(category);
      latestNews.assignAll(articles);
    } catch (e) {
      Get.snackbar('Error Loading Latest News', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoadingLatest(false);
    }
  }

  void fetchRecommendedNews(String category) async {
    try {
      isLoadingRecommended(true);
      var articles = await _apiService.allNews(category);
      recommendedNews.assignAll(articles);
    } catch (e) {
      Get.snackbar('Error Loading Recommendations', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoadingRecommended(false);
    }
  }

  void onTagSelected(String tag) {
    selectedTag.value = tag;

    String apiCategory = 'top';
    if (tag.contains('Currency') || tag.contains('Bitcoin')) apiCategory = 'business';
    if (tag.contains('Fitday')) apiCategory = 'health';

    fetchLatestNews(apiCategory);
  }
}
