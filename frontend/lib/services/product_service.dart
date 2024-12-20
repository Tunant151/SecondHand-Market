import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config/config.dart';
import '../utils/logger.dart';
import '../models/product.dart';

class ProductService {
  static Future<List<Product>> getFeaturedProducts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(Config.tokenKey);

      final response = await http.get(
        Uri.parse('${Config.baseUrl}${Config.products}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      logger.d('Products response: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        logger.i('Products fetched successfully');
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        logger.e('Failed to fetch products: ${response.statusCode}');
        throw Exception('Failed to fetch products');
      }
    } catch (e) {
      logger.e('Error fetching products: $e');
      throw Exception('Error fetching products');
    }
  }
}
