import 'package:flutter/foundation.dart';
import 'package:kamus_investasi/databases/dictionaries/dictionary_repository.dart';
import 'package:kamus_investasi/utils/json_configuration.dart';

class DataSets {
  final DictionaryRepository _dictionaryRepo = DictionaryRepository();

  Future initDictionaries() async {
    final dictionariesData = await _dictionaryRepo.first();
    if (dictionariesData == 0) {
      Map<String, dynamic> dictionariesJson =
          await JsonConfiguration.parseJsonFromAssets(
              'assets/datasets/dictionaries.json');
      if (dictionariesJson['data'].length != 0) {
        for (var i = 0; i < dictionariesJson['data'].length; i++) {
          await _dictionaryRepo.insert({
            // 'id': dictionariesJson['data'][i]['id'],
            'alphabet': dictionariesJson['data'][i]['alphabet'],
            'title': dictionariesJson['data'][i]['title'],
            'full_title': dictionariesJson['data'][i]['full_title'],
            'description': dictionariesJson['data'][i]['description'],
            'category': dictionariesJson['data'][i]['category'],
            'created_at': dictionariesJson['data'][i]['created_at'],
            'updated_at': dictionariesJson['data'][i]['updated_at'],
          });
        }
      }
    } else {
      if (kDebugMode) {
        print('Data is not empty.');
      }
    }
  }
}
