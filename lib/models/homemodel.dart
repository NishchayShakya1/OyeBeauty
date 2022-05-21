import 'dart:convert';

class HomeModel {

  static List<Home> items;

 

  // Get Item by ID
   Home getById(int id) =>
      items.firstWhere((element) => element.id == id, orElse: () => null);

  // Get Item by position
   Home getByPosition(int pos) => items[pos];
}

class Home {
  final int id;
  final String path;
  

  Home({
    this.id,
    this.path,
    
  });

  Home copyWith({
    int id,
    String path,
  }) {
    return Home(
      id: id ?? this.id,
      path: path ?? this.path,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'path': path,
    };
  }

  factory Home.fromMap(Map<String, dynamic> map) {
    return Home(
      id: map['id'],
      path: map['path'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Home.fromJson(String source) => Home.fromMap(json.decode(source));

  @override
  String toString() => 'Home(id: $id, path: $path)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Home &&
      other.id == id &&
      other.path == path;
  }

  @override
  int get hashCode => id.hashCode ^ path.hashCode;
}
