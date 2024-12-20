import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config/config.dart';
import '../utils/logger.dart';
import '../models/category.dart';

class CategoryService {
  static Future<List<Category>> getCategories() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(Config.tokenKey);

      final response = await http.get(
        Uri.parse('${Config.baseUrl}${Config.categories}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      logger.d('Categories response: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        logger.i('Categories fetched successfully');
        return data.map((json) => Category.fromJson(json)).toList();
      } else {
        logger.e('Failed to fetch categories: ${response.statusCode}');
        throw Exception('Failed to fetch categories');
      }
    } catch (e) {
      logger.e('Error fetching categories: $e');
      throw Exception('Error fetching categories');
    }
  }
}
