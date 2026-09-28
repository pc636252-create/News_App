import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Model/NewsModel.dart';
import '../../Screen_controllers/PopularTags_Controller.dart';
import '../NewsDetailScreen/NewsDetail.dart';

class PopularTags extends GetView<PopularController> {
  const PopularTags({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 10,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                onChanged: (value) => controller.searchQuery.value = value,
                decoration: const InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.search, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 24),

            _buildSectionHeader('Popular Tags', () {}),
            const SizedBox(height: 12),

            Obx(() => Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: controller.popularTags.map((tag) {
                final isSelected = controller.selectedTag.value == tag;
                return GestureDetector(
                  onTap: () => controller.onTagSelected(tag),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.grey[50],
                      border: Border.all(
                        color: isSelected ? Colors.blue : Colors.grey[200]!,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      tag,
                      style: TextStyle(
                        color: isSelected ? Colors.blue : Colors.grey[600],
                        fontSize: 13,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }).toList(),
            )),
            const SizedBox(height: 28),
            _buildSectionHeader('Latest News', () {}),
            const SizedBox(height: 16),
            SizedBox(
              height: 260,
              child: Obx(() {
                if (controller.isLoadingLatest.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.latestNews.isEmpty) {
                  return const Center(child: Text('No data found'));
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.latestNews.length,
                  itemBuilder: (context, index) {
                    return _buildLatestNewsCard(controller.latestNews[index]);
                  },
                );
              }),
            ),
            const SizedBox(height: 24),

            _buildSectionHeader('Recommendation Topic', () {}),
            const SizedBox(height: 16),
            Obx(() {
              if (controller.isLoadingRecommended.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.recommendedNews.isEmpty) {
                return const Center(child: Text('No recommendations available'));
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.recommendedNews.length,
                itemBuilder: (context, index) {
                  return _buildRecommendedRowCard(controller.recommendedNews[index]);
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onViewAllTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        TextButton(
          onPressed: onViewAllTap,
          child: const Text('View All', style: TextStyle(color: Colors.blue, fontSize: 14)),
        )
      ],
    );
  }
  Widget _buildLatestNewsCard(NewsArticle article) {
    return GestureDetector(
      onTap: () => Get.to(() => NewsDetailScreen(article: article)),
      child: Container(
        width: 260,
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                  article.imageUrl ?? 'https://picsum.photos',
                height: 150,
                width: 260,
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(color: Colors.grey[300], height: 150, child: const Icon(Icons.image)),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              article.title ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, height: 1.3),
            ),
            const SizedBox(height: 6),
            Text(
              '${article.sourceId ?? "Global Channel"} • ${article.pubDate != null ? article.pubDate!.split(" ")[0] : "Just now"}',
              style: TextStyle(color: Colors.grey[400], fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
  Widget _buildRecommendedRowCard(NewsArticle article) {
    return GestureDetector(
      onTap: () => Get.to(() => NewsDetailScreen(article: article)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15, height: 1.3),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${article.sourceId ?? "News Room"} • ${article.pubDate != null ? article.pubDate!.split(" ")[0] : "1h ago"}',
                    style: TextStyle(color: Colors.grey[400], fontSize: 12),
                  )
                ],
              ),
            ),
            const SizedBox(width: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                article.imageUrl ?? 'https://picsum.photos',
                height: 75,
                width: 75,
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(color: Colors.grey[200], height: 75, width: 75, child: const Icon(Icons.broken_image)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
