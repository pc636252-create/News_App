import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../Model/NewsModel.dart';

class NewsDetailController extends GetxController {
  final NewsArticle article;
  NewsDetailController(this.article);

  final RxBool isBookmarked = false.obs;
  final RxBool isLiked = false.obs;
  final RxInt likeCount = 34.obs;
  final RxInt commentCount = 8.obs;
  final RxBool showScrollToTop = false.obs;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      showScrollToTop.value = scrollController.offset > 300;
    });
  }

  void toggleBookmark() => isBookmarked.toggle();

  void toggleLike() {
    isLiked.toggle();
    likeCount.value += isLiked.value ? 1 : -1;
  }

  void sharePost() {}

  void scrollToTop() {
    scrollController.animateTo(0, duration: const Duration(milliseconds: 400), curve: Curves.easeOut);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}