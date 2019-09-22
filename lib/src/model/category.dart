
class Category extends Comparable{

  Category(this.id,this.name);

  factory Category.fromJson(Map<String, dynamic> json){
    return Category(json['id'], json['name']);
  }

  int id;
  String name;
  bool active;

  @override
  String toString() {
    return '[id: $id | name: $name | active: $active]';
  }

  @override
  int compareTo(other) {
    return this.id.compareTo(other.id);
  }

}