import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoints {
  // Get base URL from environment variables
  static String get baseUrl => dotenv.env['BASE_URL'] ?? 'https://saurav.tech/NewsAPI';
  
  // Get timeout configuration
  static int get timeout => int.parse(dotenv.env['API_TIMEOUT'] ?? '10000');
  static int get retryAttempts => int.parse(dotenv.env['RETRY_ATTEMPTS'] ?? '3');
  
  // Build full URLs from environment variables
  static String get businessUrl => 
      '$baseUrl${dotenv.env['BUSINESS_ENDPOINT'] ?? '/top-headlines/category/business/us.json'}';
  
  static String get generalUrl => 
      '$baseUrl${dotenv.env['GENERAL_ENDPOINT'] ?? '/top-headlines/category/general/us.json'}';
  
  static String get sportsUrl => 
      '$baseUrl${dotenv.env['SPORTS_ENDPOINT'] ?? '/top-headlines/category/sports/us.json'}';
  
  static String get techUrl => 
      '$baseUrl${dotenv.env['TECH_ENDPOINT'] ?? '/top-headlines/category/technology/us.json'}';
  
  static String get cnnUrl => 
      '$baseUrl${dotenv.env['CNN_ENDPOINT'] ?? '/everything/cnn.json'}';
}

// Backward compatibility - keep old constants but use new class
final String baseUrl = ApiEndpoints.baseUrl;
final String businessUrl = ApiEndpoints.businessUrl;
final String generalUrl = ApiEndpoints.generalUrl;
final String sportsUrl = ApiEndpoints.sportsUrl;
final String techUrl = ApiEndpoints.techUrl;
final String cnnUrl = ApiEndpoints.cnnUrl;
