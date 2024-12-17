import 'dart:convert';
import 'package:FlutterTask/models/product.dart';
import 'package:http/http.dart' as http;
import '../utils/strings.dart';

class ApiService {
  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(AppStrings.baseApiUrl));
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((data) => Product.fromJson(data))
          .toList();
    } else {
      throw Exception(AppStrings.productFetchError);
    }
  }
}