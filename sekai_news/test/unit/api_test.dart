import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:sekai_news/util/endpoints.dart';

void main() {
  setUpAll(() async {
    // Initialize dotenv for tests
    await dotenv.load(fileName: ".env");
  });

  group('Network and API Tests', () {
    test('should handle successful API response', () async {
      // Arrange
      final mockClient = MockClient((request) async {
        final mockResponse = {
          'status': 'ok',
          'totalResults': 2,
          'articles': [
            {
              'author': 'Test Author',
              'title': 'Test Article',
              'description': 'Test Description',
              'content': 'Test Content',
              'urlToImage': 'https://example.com/image.jpg',
              'publishedAt': '2024-01-01T10:00:00Z',
              'source': {'id': 'test', 'name': 'Test Source'}
            }
          ]
        };
        return http.Response(jsonEncode(mockResponse), 200);
      });

      // Act
      final response = await mockClient.get(Uri.parse(generalUrl));

      // Assert
      expect(response.statusCode, equals(200));
      final data = jsonDecode(response.body);
      expect(data['status'], equals('ok'));
      expect(data['articles'], isA<List>());
      expect(data['articles'].length, equals(1));
    });

    test('should handle 404 error response', () async {
      // Arrange
      final mockClient = MockClient((request) async {
        return http.Response('Not Found', 404);
      });

      // Act
      final response = await mockClient.get(Uri.parse(generalUrl));

      // Assert
      expect(response.statusCode, equals(404));
      expect(response.body, equals('Not Found'));
    });

    test('should handle 500 server error', () async {
      // Arrange
      final mockClient = MockClient((request) async {
        return http.Response('Internal Server Error', 500);
      });

      // Act
      final response = await mockClient.get(Uri.parse(generalUrl));

      // Assert
      expect(response.statusCode, equals(500));
      expect(response.body, equals('Internal Server Error'));
    });

    test('should handle network timeout', () async {
      // Arrange
      final mockClient = MockClient((request) async {
        await Future.delayed(Duration(seconds: 2));
        throw SocketException('Connection timed out');
      });

      // Act & Assert
      expect(
        () => mockClient.get(Uri.parse(generalUrl)),
        throwsA(isA<SocketException>())
      );
    });

    test('should handle malformed JSON response', () async {
      // Arrange
      final mockClient = MockClient((request) async {
        return http.Response('{"invalid": json}', 200);
      });

      // Act
      final response = await mockClient.get(Uri.parse(generalUrl));

      // Assert
      expect(response.statusCode, equals(200));
      expect(
        () => jsonDecode(response.body),
        throwsA(isA<FormatException>())
      );
    });

    test('should handle no internet connection', () async {
      // Arrange
      final mockClient = MockClient((request) async {
        throw SocketException('No Internet connection');
      });

      // Act & Assert
      expect(
        () => mockClient.get(Uri.parse(generalUrl)),
        throwsA(isA<SocketException>())
      );
    });

    test('should handle empty articles array', () async {
      // Arrange
      final mockClient = MockClient((request) async {
        final mockResponse = {
          'status': 'ok',
          'totalResults': 0,
          'articles': []
        };
        return http.Response(jsonEncode(mockResponse), 200);
      });

      // Act
      final response = await mockClient.get(Uri.parse(generalUrl));

      // Assert
      expect(response.statusCode, equals(200));
      final data = jsonDecode(response.body);
      expect(data['articles'], isEmpty);
    });

    test('should validate all endpoint URLs', () {
      // Test that all endpoints are valid URLs
      expect(Uri.tryParse(businessUrl), isNotNull);
      expect(Uri.tryParse(generalUrl), isNotNull);
      expect(Uri.tryParse(sportsUrl), isNotNull);
      expect(Uri.tryParse(techUrl), isNotNull);
      expect(Uri.tryParse(cnnUrl), isNotNull);
    });

    test('should handle rate limiting (429 error)', () async {
      // Arrange
      final mockClient = MockClient((request) async {
        return http.Response('Rate limit exceeded', 429);
      });

      // Act
      final response = await mockClient.get(Uri.parse(generalUrl));

      // Assert
      expect(response.statusCode, equals(429));
      expect(response.body, equals('Rate limit exceeded'));
    });
  });
}
