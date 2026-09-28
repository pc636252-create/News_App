
  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:news_app/Routes/App_Routes.dart';
  import '../../Screen_controllers/Home_Controller.dart';
  import '../../Model/NewsModel.dart';
  import '../NewsDetailScreen/NewsDetail.dart';

  class HomeScreen extends GetView<HomeController> {
    const HomeScreen({super.key});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () => controller.fetchNews(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTopBar(),
                  _buildCategoryTabs(),
                  const SizedBox(height: 16),
                  _buildNewsSection(),
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget _buildTopBar() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.blue),
                onPressed: () => Get.toNamed(AppRoutes.setting),
              ),
              Obx(() => Text(
                controller.location.value,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              )),
              const Icon(Icons.arrow_drop_down, color: Colors.black87),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.monetization_on, color: Colors.amber, size: 20),
                    const SizedBox(width: 6),
                    Obx(() => Text(
                      '${controller.coins.value}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.refresh, color: Colors.blue),
                onPressed: () => controller.fetchNews(),
              )
            ],
          ),
        ),
      );
    }

    Widget _buildCategoryTabs() {
      return SizedBox(
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.categories.length,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          itemBuilder: (context, index) {
            return Obx(() {
              final isSelected = controller.selectedTab.value == index;
              return GestureDetector(
                onTap: () => controller.selectTab(index),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    border: isSelected
                        ? const Border(bottom: BorderSide(color: Colors.blue, width: 3))
                        : null,
                  ),
                  child: Text(
                    controller.categories[index],
                    style: TextStyle(
                      color: isSelected ? Colors.blue : Colors.grey[500],
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
              );
            });
          },
        ),
      );
    }

    Widget _buildNewsSection() {
      return Obx(() {
        if (controller.isLoading.value) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(controller.errorMessage.value, style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => controller.fetchNews(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (controller.newsList.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: Text('No news found')),
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: controller.newsList.length,
          itemBuilder: (context, index) {
            final currentArticle = controller.newsList[index];

            return GestureDetector(
              onTap: () => Get.to(() => NewsDetailScreen(article: currentArticle)),
              child: _buildNewsCard(currentArticle),
            );
          },
        );
      });
    }

    Widget _buildNewsCard(NewsArticle article) {
      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.imageUrl != null && article.imageUrl!.isNotEmpty)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Stack(
                  children: [
                    Image.network(
                      article.imageUrl!,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        height: 180,
                        color: Colors.grey[200],
                        child: const Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
                      ),
                    ),
                    if (article.videoUrl != null && article.videoUrl!.isNotEmpty)
                      Positioned.fill(
                        child: Center(
                          child: CircleAvatar(
                            radius: 26,
                            backgroundColor: Colors.black.withOpacity(0.6),
                            child: const Icon(Icons.play_arrow, color: Colors.white, size: 30),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (article.sourceName != null)
                    Row(
                      children: [
                        if (article.sourceIcon != null)
                          Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: Image.network(article.sourceIcon!, width: 16, height: 16,
                                errorBuilder: (_, __, ___) => const SizedBox()),
                          ),
                        Expanded(
                          child: Text(
                            article.sourceName!,
                            style: TextStyle(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 6),
                  Text(
                    article.title ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, height: 1.3),
                  ),
                  if (article.description != null && article.description!.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      article.description!,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 13, color: Colors.grey[700], height: 1.3),
                    ),
                  ],
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      if (article.category != null)
                        ...article.category!.map((c) => _tag(c, Colors.blue)),
                      if (article.pubDate != null) _tag(article.pubDate!, Colors.grey),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget _tag(String text, MaterialColor color) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: color[50],
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(text, style: TextStyle(fontSize: 10, color: color[700], fontWeight: FontWeight.w600)),
      );
    }
  }