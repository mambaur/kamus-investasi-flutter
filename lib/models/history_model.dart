class HistoryModel {
  int? id, dictionaryId;
  String? description, createdAt, updatedAt;

  HistoryModel(
      {this.id,
      this.dictionaryId,
      this.description,
      this.createdAt,
      this.updatedAt});

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      id: json['id'],
      dictionaryId: json['dictionary_id'],
      description: json['description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
