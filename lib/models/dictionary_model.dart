class DictionaryModel {
  int? id;
  String? alphabet,
      title,
      fullTitle,
      description,
      category,
      createdAt,
      updatedAt;

  DictionaryModel(
      {this.id,
      this.alphabet,
      this.title,
      this.fullTitle,
      this.description,
      this.category,
      this.createdAt,
      this.updatedAt});

  factory DictionaryModel.fromJson(Map<String, dynamic> json) {
    return DictionaryModel(
      id: json['id'],
      alphabet: json['alphabet'],
      title: json['title'],
      fullTitle: json['full_title'],
      description: json['description'],
      category: json['category'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class DictionaryByAlphabets {
  String? alphabet;
  List<DictionaryModel>? listDictionaries;

  DictionaryByAlphabets({this.alphabet, this.listDictionaries});
}

class DictionaryByDate {
  String? date;
  List<DictionaryModel>? listDictionaries;

  DictionaryByDate({this.date, this.listDictionaries});
}
