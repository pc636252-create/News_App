
class NewsArticle {
  final String? articleId;
  final String? title;
  final String? link;
  final List<String>? keywords;
  final List<String>? creator;
  final String? description;
  final String? content;
  final String? pubDate;
  final String? imageUrl;
  final String? videoUrl;
  final String? sourceId;
  final String? sourceName;
  final String? sourceUrl;
  final String? sourceIcon;
  final String? language;
  final List<String>? country;
  final List<String>? category;

  NewsArticle({
    this.articleId,
    this.title,
    this.link,
    this.keywords,
    this.creator,
    this.description,
    this.content,
    this.pubDate,
    this.imageUrl,
    this.videoUrl,
    this.sourceId,
    this.sourceName,
    this.sourceUrl,
    this.sourceIcon,
    this.language,
    this.country,
    this.category,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      articleId: json['article_id'],
      title: json['title'],
      link: json['link'],
      keywords: (json['keywords'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      creator: (json['creator'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      description: json['description'],
      content: json['content'],
      pubDate: json['pubDate'],
      imageUrl: json['image_url'],
      videoUrl: json['video_url'],
      sourceId: json['source_id'],
      sourceName: json['source_name'],
      sourceUrl: json['source_url'],
      sourceIcon: json['source_icon'],
      language: json['language'],
      country: (json['country'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      category: (json['category'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
    );
  }
}
