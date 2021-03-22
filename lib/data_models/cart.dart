class Dog {
  Dog({
    this.id,
    this.name,
    this.age,
  });

  int id;
  String name;
  int age;

  factory Dog.fromJson(Map<String, dynamic> json) => Dog(
        id: json["id"],
        name: json["name"],
        age: json["age"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "age": age,
      };
}
