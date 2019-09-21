
class Category {

  Category(this.id,this.name);

  factory Category.fromJson(Map<String, dynamic> json){
    return Category(json['id'], json['name']);
  }

  int id;
  String name;

}