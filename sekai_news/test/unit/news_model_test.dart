import 'package:flutter_test/flutter_test.dart';
import 'package:sekai_news/model/news.dart';

void main() {
  group('NewsArticle Model Tests', () {
    test('should create NewsArticle from valid JSON', () {
      // Arrange
      final json = {
        'author': 'John Doe',
        'content': 'This is the full article content',
        'description': 'Article description',
        'publishedAt': '2024-01-01T10:00:00Z',
        'title': 'Test Article Title',
        'urlToImage': 'https://example.com/image.jpg',
        'source': {'id': 'test-source', 'name': 'Test Source'}
      };

      // Act
      final article = NewsArticle.fromJson(json);

      // Assert
      expect(article.author, equals('John Doe'));
      expect(article.content, equals('This is the full article content'));
      expect(article.description, equals('Article description'));
      expect(article.publishedAt, equals('2024-01-01T10:00:00Z'));
      expect(article.title, equals('Test Article Title'));
      expect(article.urlToImage, equals('https://example.com/image.jpg'));
      expect(article.source, isA<Map<String, dynamic>>());
    });

    test('should handle null author gracefully', () {
      // Arrange
      final json = {
        'author': null,
        'title': 'Test Article',
        'content': 'Content'
      };

      // Act
      final article = NewsArticle.fromJson(json);

      // Assert
      expect(article.author, equals('Unknown'));
    });

    test('should handle empty JSON', () {
      // Arrange
      final json = <String, dynamic>{};

      // Act
      final article = NewsArticle.fromJson(json);

      // Assert
      expect(article.author, equals('Unknown'));
      expect(article.content, isNull);
      expect(article.description, isNull);
      expect(article.title, isNull);
      expect(article.urlToImage, isNull);
      expect(article.source, isNull);
    });

    test('should handle missing fields', () {
      // Arrange
      final json = {
        'title': 'Only Title Available'
      };

      // Act
      final article = NewsArticle.fromJson(json);

      // Assert
      expect(article.title, equals('Only Title Available'));
      expect(article.author, equals('Unknown'));
      expect(article.content, isNull);
      expect(article.description, isNull);
      expect(article.urlToImage, isNull);
      expect(article.source, isNull);
    });
  });
}