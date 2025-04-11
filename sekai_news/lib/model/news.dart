class NewsArticle {
  final String? author;
  final String? content;
  final String? description;
  final String? publishedAt;
  final String? title;
  final String? urlToImage;
  final Map<String, dynamic>? source;

  NewsArticle({
    this.author,
    this.content,
    this.description,
    this.publishedAt,
    this.title,
    this.urlToImage,
    this.source,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      author: json['author'] ?? 'Unknown',
      content: json['content'],
      description: json['description'],
      publishedAt: json['publishedAt'],
      title: json['title'],
      urlToImage: json['urlToImage'],
      source: json['source'],
    );
  }
}