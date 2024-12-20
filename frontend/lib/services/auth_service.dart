import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart' as prefs;
import '../config/config.dart';
import '../models/user.dart';
import '../utils/logger.dart';

class AuthService {
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${Config.baseUrl}${Config.login}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      logger.i('Raw response: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final userData = responseData['user'];

        if (responseData['profile_image_url'] != null) {
          userData['profile_image_url'] = responseData['profile_image_url'];
        }

        logger.d('Processed user data: $userData');

        final prefs.SharedPreferences preferences =
            await prefs.SharedPreferences.getInstance();
        await preferences.setString(Config.tokenKey, responseData['token']);
        await preferences.setString(Config.userKey, json.encode(userData));

        return {
          'success': true,
          'user': User.fromJson(userData),
          'token': responseData['token'],
        };
      } else {
        final errorData = json.decode(response.body);
        return {
          'success': false,
          'message': errorData['message'] ?? 'Login failed',
          'errors': errorData['errors'],
        };
      }
    } catch (e) {
      logger.e('Login error: ${e.toString()}');
      return {
        'success': false,
        'message': 'Connection error: ${e.toString()}',
      };
    }
  }

  static Future<User?> getCurrentUser() async {
    try {
      final prefs.SharedPreferences preferences =
          await prefs.SharedPreferences.getInstance();
      final userData = preferences.getString(Config.userKey);

      if (userData != null) {
        return User.fromJson(json.decode(userData));
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<void> logout() async {
    final prefs.SharedPreferences preferences =
        await prefs.SharedPreferences.getInstance();
    await preferences.remove(Config.tokenKey);
    await preferences.remove(Config.userKey);
  }

  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    String? phone,
    String? district,
    File? profileImage,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${Config.baseUrl}${Config.register}'),
      );

      // Add text fields
      request.fields['name'] = name;
      request.fields['email'] = email;
      request.fields['password'] = password;
      if (phone != null) request.fields['phone'] = phone;
      if (district != null) request.fields['district'] = district;

      // Add image if selected
      if (profileImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'profile_image',
          profileImage.path,
        ));
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);

        // Save token
        final prefs.SharedPreferences preferences =
            await prefs.SharedPreferences.getInstance();
        await preferences.setString(Config.tokenKey, responseData['token']);

        // Save user data
        final userData = responseData['user'];
        await preferences.setString(Config.userKey, json.encode(userData));

        return {
          'success': true,
          'user': User.fromJson(userData),
          'token': responseData['token'],
        };
      } else {
        final errorData = json.decode(response.body);
        return {
          'success': false,
          'message': errorData['message'] ?? 'Registration failed',
          'errors': errorData['errors'],
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Connection error: ${e.toString()}',
      };
    }
  }
}
