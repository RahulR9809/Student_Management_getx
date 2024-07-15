import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sampstudentapp/db/db_functions.dart';
import 'package:sampstudentapp/model/model.dart';

class StudentController extends GetxController {
  var students = <StudentModel>[].obs;
  var filteredStudents = <StudentModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllStudents();
  }

  Future<void> fetchAllStudents() async {
    try {
      final fetchedStudents = await getAllStudents();
      students.assignAll(fetchedStudents);
      filteredStudents.assignAll(fetchedStudents); // Initialize filteredStudents with all students
    
    } catch (e) {
      print('Error fetching students: $e');
    }
  }

  Future<void> addStudent(StudentModel student) async {
    try {
      await addStudent(student);
      fetchAllStudents(); // Update the student list after adding
    } catch (e) {
      print('Error adding student: $e');
    }
  }

  Future<void> updateStudent(StudentModel student) async {
    try {
      await updateStudent(student);
      fetchAllStudents(); // Update the student list after updating
    } catch (e) {
      print('Error updating student: $e');
    }
  }

  Future<void> deleteStudent(int studentId) async {
    try {
      await deleteStudent(studentId);
      fetchAllStudents(); // Update the student list after deleting
    } catch (e) {
      print('Error deleting student: $e');
    }
  }

  void search(String query) {
    final lowerCaseQuery = query.toLowerCase();
    if (lowerCaseQuery.isEmpty) {
      filteredStudents.assignAll(students);
    } else {
      filteredStudents.assignAll(
        students.where((student) {
          return student.name.toLowerCase().contains(lowerCaseQuery) ||
                 student.course.toLowerCase().contains(lowerCaseQuery) ||
                 student.place.toLowerCase().contains(lowerCaseQuery);
        }).toList(),
      );
    }
  }

  Future<String?> pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        return pickedFile.path;
      }
      return null;
    } catch (e) {
      print('Error picking image: $e');
      return null;
    }
  }
}
