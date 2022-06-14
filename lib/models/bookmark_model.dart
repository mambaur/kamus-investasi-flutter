class BookmarkModel {
  int? id, dictionaryId;
  String? description, createdAt, updatedAt;

  BookmarkModel(
      {this.id,
      this.dictionaryId,
      this.description,
      this.createdAt,
      this.updatedAt});

  factory BookmarkModel.fromJson(Map<String, dynamic> json) {
    return BookmarkModel(
      id: json['id'],
      dictionaryId: json['dictionary_id'],
      description: json['description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
