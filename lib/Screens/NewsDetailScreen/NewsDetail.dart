import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Model/NewsModel.dart';
import '../../Screen_controllers/News_Controller.dart';
import '../../Widget/NetWork_Video.dart';

class NewsDetailScreen extends StatelessWidget {
  final NewsArticle article;
  const NewsDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final NewsDetailController controller = Get.put(NewsDetailController(article));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: controller.scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _headerMedia(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.title ?? '',
                        style: const TextStyle(
                            fontSize: 21, fontWeight: FontWeight.bold, height: 1.3),
                      ),
                      const SizedBox(height: 18),
                      authorRow(),
                      const SizedBox(height: 18),
                      statsRow(controller),
                      const Divider(height: 32),
                      error(),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 12,
            right: 12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                circleBtn(Icons.arrow_back, () => Get.back()),
                Row(children: [
                  Obx(() => circleBtn(
                      controller.isBookmarked.value
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      controller.toggleBookmark)),
                  const SizedBox(width: 10),
                  circleBtn(Icons.ios_share, controller.sharePost),
                ]),
              ],
            ),
          ),
          Positioned(
            bottom: 24,
            right: 24,
            child: Obx(() => AnimatedOpacity(
              opacity: controller.showScrollToTop.value ? 1 : 0,
              duration: const Duration(milliseconds: 200),
              child: IgnorePointer(
                ignoring: !controller.showScrollToTop.value,
                child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  elevation: 3,
                  onPressed: controller.scrollToTop,
                  child: const Icon(Icons.arrow_upward, color: Colors.black87),
                ),
              ),
            )),
          ),
        ],
      ),
    );
  }

  Widget _headerMedia() {
    final hasVideo = article.videoUrl != null && article.videoUrl!.isNotEmpty;
    final hasImage = article.imageUrl != null && article.imageUrl!.isNotEmpty;

    if (hasVideo) {
      return NetworkVideoWidget(videoUrl: article.videoUrl!);
    }

    return SizedBox(
      height: 300,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          hasImage
              ? Image.network(
            article.imageUrl!,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(color: Colors.grey[300]),
          )
              : Container(color: Colors.grey[300]),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black26, Colors.transparent],
                stops: [0.0, 0.35],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget authorRow() {
    final hasIcon = article.sourceIcon?.isNotEmpty ?? false;
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.grey[300],
          backgroundImage: hasIcon ? NetworkImage(article.sourceIcon!) : null,
          child: hasIcon ? null : const Icon(Icons.person, color: Colors.white),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text('By ${article.sourceName ?? 'Unknown'}',
              style: TextStyle(color: Colors.grey[600], fontSize: 13)),
        ),
        Text(article.pubDate ?? '',
            style: TextStyle(color: Colors.grey[500], fontSize: 12)),
      ],
    );
  }

  Widget statsRow(NewsDetailController c) {
    return Row(
      children: [
        Row(children: [
          const Icon(Icons.mode_comment_outlined, size: 18, color: Colors.grey),
          const SizedBox(width: 6),
          Obx(() => Text('${c.commentCount.value} comments',
              style: const TextStyle(fontSize: 13))),
        ]),
        const SizedBox(width: 24),
        GestureDetector(
          onTap: c.toggleLike,
          child: Row(children: [
            Obx(() => Icon(c.isLiked.value ? Icons.favorite : Icons.favorite_border,
                size: 18, color: c.isLiked.value ? Colors.red : Colors.grey)),
            const SizedBox(width: 6),
            Obx(() =>
                Text('${c.likeCount.value} likes', style: const TextStyle(fontSize: 13))),
          ]),
        ),
        const Spacer(),
        GestureDetector(
          onTap: c.sharePost,
          child: const Row(children: [
            Icon(Icons.share_outlined, size: 18, color: Colors.grey),
            SizedBox(width: 6),
            Text('Share', style: TextStyle(fontSize: 13)),
          ]),
        ),
      ],
    );
  }

  Widget error() {
    final paragraphs = (article.description ?? '')
        .split('\n')
        .where((p) => p.trim().isNotEmpty)
        .toList();
    if (paragraphs.isEmpty) {
      return const Text('No content available.', style: TextStyle(color: Colors.grey));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: paragraphs
          .map((p) => Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Text(p.trim(),
            style: const TextStyle(
                fontSize: 15, height: 1.6, color: Colors.black87)),
      ))
          .toList(),
    );
  }

  Widget circleBtn(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 4)],
        ),
        child: Icon(icon, size: 18, color: Colors.black87),
      ),
    );
  }
}