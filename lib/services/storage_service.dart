
import 'package:get_storage/get_storage.dart';

class StorageService {
  final box = GetStorage(); 

  void saveCharacters(List<dynamic> characters) {
    box.write('characters', characters);
  }

  List<dynamic> getCharacters() {
    return box.read('characters') ?? [];
  }

}