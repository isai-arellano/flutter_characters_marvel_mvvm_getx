import 'package:stratplus_marvel/models/character_model.dart';
import 'package:stratplus_marvel/services/api_service.dart';
import 'package:stratplus_marvel/services/storage_service.dart';

class MarvelRepository {
  final ApiService _apiService = ApiService();
  final StorageService _storageService = StorageService();


  Future<List<Character>> getCharacters(int offset, int limit) async {
    final charactersData = await _apiService.getCharacters(offset, limit);
    final characters = charactersData.map((e) => Character.fromJson(e)).toList();
    _storageService.saveCharacters(charactersData);
    return characters;
  }

  //Obtener personajes almacenados localmente
  List<Character> getStoredCharacters() {
    final storedData = _storageService.getCharacters();
    return storedData.map((e) => Character.fromJson(e)).toList();
  }

}