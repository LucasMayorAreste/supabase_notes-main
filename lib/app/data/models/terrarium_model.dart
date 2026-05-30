class Terrarium {
  int? id;
  int? userId;
  String? title;
  String? description;
  String? priority;

  Terrarium({this.id, this.userId, this.title, this.description, this.priority});

  Terrarium.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    description = json['description'];
    priority = json['priority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    data['user_id'] = userId;
    data['title'] = title;
    data['description'] = description;
    data['priority'] = priority;
    return data;
  }

  static List<Terrarium> fromJsonList(List? data) {
    if (data == null || data.isEmpty) return [];
    return data.map((e) => Terrarium.fromJson(e)).toList();
  }
}