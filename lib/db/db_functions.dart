import 'package:sampstudentapp/model/model.dart';
import 'package:sqflite/sqflite.dart';

late Database db;

Future indataBase() async {
  try {
    db = await openDatabase(
      'data.db',
      version: 1,
      onCreate: (Database db, int version) {
        db.execute(
            'CREATE TABLE student(id INTEGER PRIMARY KEY, name TEXT, age TEXT, place TEXT, course TEXT, image BLOB, phone INTEGER, pincode INTEGER)');
      },
    );
    return db;
  } catch (e) {
    // ignore: avoid_print
    print('Error opening database: $e');
    throw e;
  }
}

Future<void> addStudent(StudentModel value) async {
  await db.rawInsert(
      'INSERT INTO student(name, age, place, course, image, phone, pincode) VALUES (?, ?, ?, ?, ?, ?, ?)',
      [value.name, value.age, value.place, value.course, value.image,value.phone,value.pincode]);

  await getAllStudents(); // Wait for the insert to complete before fetching all students
}

Future<List<StudentModel>> getAllStudents() async {
  final value = await db.rawQuery('SELECT * FROM student');
  // ignore: avoid_print
  print(value);

  List<StudentModel> updatedStudentList =
      value.map((map) => StudentModel.fromMap(map)).toList();
  return updatedStudentList; // Return the list
}


 updateStudent(StudentModel value) async {
 await db.rawUpdate(
  'UPDATE student SET name = ?, age = ?, place = ?, course = ?,image = ?,phone = ?,pincode = ? WHERE id = ?',
  [
    value.name,
    value.age,
    value.place,
    value.course,
    value.image,
    value.phone,
    value.pincode,
    value.id,
  ],
);


  getAllStudents(); // Assuming this method retrieves all students after the update
}

Future<void> deleteStudent(int? studentId) async {
  final db=await indataBase();
 await db.rawDelete('DELETE FROM student WHERE id = ?', [studentId]);


}

Future<List<StudentModel>> searchStudents(String query) async {
  final value = await db.rawQuery(
    'SELECT * FROM student WHERE name LIKE ? OR course LIKE ?',
    ['%$query%', '%$query%'],
  );
  List<StudentModel> searchResults =
      value.map((map) => StudentModel.fromMap(map)).toList();

  return searchResults;
}
