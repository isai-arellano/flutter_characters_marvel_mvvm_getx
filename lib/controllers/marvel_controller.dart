

import 'package:get/get.dart';
import 'package:stratplus_marvel/models/character_model.dart';
import 'package:stratplus_marvel/repositories/marvel_repository.dart';

class MarvelController extends GetxController {
  final MarvelRepository _marvelRepository = MarvelRepository();
  var characters = <Character>[].obs;
  var isLoading = false.obs;
  var totalCharacters = 0.obs;

  var offset = 10;
  var limit = 20;

  @override
  void onInit() {
    super.onInit();
    loadStoredCharacters();
    fetchCharacters();
  }

  void loadStoredCharacters() {
    characters.value = _marvelRepository.getStoredCharacters();
  }

  Future<void> fetchCharacters() async {
    try {
      isLoading.value = true;
      final newCharacters = await _marvelRepository.getCharacters(offset, limit);
      characters.addAll(newCharacters);
      totalCharacters.value = characters.length;
      offset += limit;
      limit = 10;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void addMoreCharacters(){
    fetchCharacters();
  }

  void searchCharacters(String query){
    if (query.isEmpty){
      loadStoredCharacters();
    } else {
      characters.value = characters.where((characters) => characters.name.toLowerCase().contains(query.toLowerCase())).toList();
    }
  }

}