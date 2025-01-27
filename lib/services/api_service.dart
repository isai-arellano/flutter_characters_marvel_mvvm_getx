import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;


class ApiService {
  static const String baseUrl = 'http://gateway.marvel.com/v1/public/characters';
  static const String apiKey = '618f790acb883bd86d79440415f41a85'; // Clave publica
  static const String privateKey = 'bd4eb728829091508266c96cdcdc095e38f94116'; // Clave privada
  static const String ts = '1';

  String generateHash(String ts, String privateKey, String apiKey) {
    final bytes = utf8.encode('$ts$privateKey$apiKey');
    return md5.convert(bytes).toString();
  }

  Future<List<dynamic>> getCharacters(int offset, int limit) async {
    final hash = generateHash(ts, privateKey, apiKey);
    final url = Uri.parse('$baseUrl?ts=$ts&apikey=$apiKey&hash=$hash&offset=$offset&limit=$limit');
    final response = await http.get(url, headers: {'Accept': '*/*'});

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data']['results'];
    } else {
      throw Exception('Error al obtener los cómics.');
    }
  }

}