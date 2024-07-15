class StudentModel {
  final int? id;
  final String name;
  final String age;
  final String place;
  final String course;
  late final String image;
  final int? phone;
  final int? pincode;

  StudentModel({
    this.id,
    required this.name,
    required this.age,
    required this.place,
    required this.course,
    required this.image,
    required this.phone,
    required this.pincode,
  });

  static StudentModel fromMap(Map<String, Object?> map) {
    final id = map['id'] as int;
    final name = map['name'] as String;
    final age = map['age'] as String;
    final place = map['place'] as String;
    final course = map['course'] as String;
    final image = map['image'] as String;
    final phone = map['phone'] as int;
    final pincode = map['pincode'] as int;

    return StudentModel(
        id: id,
        name: name,
        age: age,
        place: place,
        course: course,
        image: image,
        phone: phone,
        pincode: pincode,);
  }

  StudentModel copyWith(
      {required String name,
      required String age,
      required String place,
      required String course,
      required String image,
      required int? phone,
      required int? pincode}) {
    return StudentModel(
      id: id,
      name: name,
      age: age,
      place: place,
      course: course,
      image: image,
      phone: phone,
      pincode: pincode,
    );
  }
}
