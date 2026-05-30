class Spider {
  int? id;
  int? userId;
  String? name;
  String? species;
  String? notes;

  Spider({this.id, this.userId, this.name, this.species, this.notes});

  Spider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    species = json['species'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    data['user_id'] = userId;
    data['name'] = name;
    data['species'] = species;
    data['notes'] = notes;
    return data;
  }

  static List<Spider> fromJsonList(List? data) {
    if (data == null || data.isEmpty) return [];
    return data.map((e) => Spider.fromJson(e)).toList();
  }
}