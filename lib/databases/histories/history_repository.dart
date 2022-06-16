import 'package:kamus_investasi/databases/database_instance.dart';
import 'package:kamus_investasi/models/dictionary_model.dart';
import 'package:kamus_investasi/models/history_model.dart';
import 'package:kamus_investasi/utils/date_instance.dart';
import 'package:sqflite/sqflite.dart';

class HistoryRepository {
  // reference to our single class that manages the database
  final dbInstance = DatabaseInstance();

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await dbInstance.database;
    return await db.insert(dbInstance.historyTable, row);
  }

  Future<List<DictionaryModel>> getDictionaryDates(
      {String? alphabet, String? q}) async {
    Database db = await dbInstance.database;
    final data = await db.rawQuery(
        'SELECT ${dbInstance.dictionaryTable}.* FROM ${dbInstance.dictionaryTable} WHERE ${dbInstance.dictionaryTable}.${dbInstance.dictionaryAlphabet}="$alphabet" AND ${dbInstance.dictionaryTable}.${dbInstance.dictionaryTitle} LIKE "%$q%"',
        []);

    List<DictionaryModel> listDictionaries = [];
    if (data.isNotEmpty) {
      for (var i = 0; i < data.length; i++) {
        DictionaryModel dictionaryModel = DictionaryModel(
          id: int.parse(data[i]['id'].toString()),
          title: data[i]['title'].toString(),
          fullTitle: data[i]['full_title'].toString(),
          description: data[i]['description'].toString(),
          alphabet: data[i]['alphabet'].toString(),
          category: data[i]['category'].toString(),
          createdAt: data[i]['created_at'].toString(),
          updatedAt: data[i]['updated_at'].toString(),
        );
        listDictionaries.add(dictionaryModel);
      }
    }

    return listDictionaries;
  }

  Future<List<DictionaryByDate>> all({int? limit, int? page}) async {
    // Setup pagination
    limit ??= 10;
    int offset = (limit * ((page ?? 0) + 1)) - limit;

    Database db = await dbInstance.database;
    final data = await db.rawQuery(
        'SELECT ${dbInstance.historyTable}.${dbInstance.historyCreatedAt}  FROM ${dbInstance.historyTable} GROUP BY ${dbInstance.historyTable}.${dbInstance.historyCreatedAt} ORDER BY ${dbInstance.historyTable}.${dbInstance.historyCreatedAt} DESC LIMIT $limit OFFSET $offset');

    List<DictionaryByDate> listHistoryDates = [];
    if (data.isNotEmpty) {
      for (var i = 0; i < data.length; i++) {
        List<DictionaryModel>? listTransactions = await getDictionaryDates(
            alphabet: data[i]['created_at'].toString());

        listHistoryDates.add(DictionaryByDate(
            date: data[i]['created_at'].toString(),
            listDictionaries: listTransactions));
      }
    }

    return listHistoryDates;
  }

  Future<HistoryModel?> findByDate(int id, String date) async {
    Database db = await dbInstance.database;
    String dateNow = DateInstance.commonDate();
    final data = await db.rawQuery(
        'SELECT * FROM ${dbInstance.historyTable} WHERE ${dbInstance.historyTable}.${dbInstance.historyDictionaryId}=$id AND ${dbInstance.historyTable}.${dbInstance.historyCreatedAt}="$dateNow" ORDER BY ${dbInstance.historyTable}.${dbInstance.historyCreatedAt} DESC LIMIT 1',
        []);
    // print(data);
    if (data.isNotEmpty) {
      return HistoryModel.fromJson(data[0]);
    }
    return null;
  }

  Future<int> delete(int id) async {
    Database db = await dbInstance.database;
    return await db.delete(dbInstance.historyTable,
        where: '${dbInstance.bookmarkDictionaryId} = ?', whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    Database db = await dbInstance.database;
    return await db.delete(dbInstance.historyTable);
  }

  Future getAll() async {
    Database db = await dbInstance.database;
    final data = await db.rawQuery(
        'SELECT ${dbInstance.historyTable}.*  FROM ${dbInstance.historyTable}',
        []);
    print(data);
  }
}
