/// name : "yangrui"
/// age : 30

class ImageEntity {
  String name;
  int age;

  static ImageEntity fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ImageEntity imageBean = ImageEntity();
    imageBean.name = map['name'];
    imageBean.age = map['age'];
    return imageBean;
  }

  Map toJson() => {
    "name": name,
    "age": age,
  };
}