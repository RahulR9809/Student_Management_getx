import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sampstudentapp/db/db_functions.dart';
import 'package:sampstudentapp/model/model.dart';

class StudentController extends GetxController {
  var students = <StudentModel>[].obs;
  var filteredStudents = <StudentModel>[].obs;

  final nameEditingController = TextEditingController();
  final ageEditingController = TextEditingController();
  final placeEditingController = TextEditingController();
  final courseEditingController = TextEditingController();
  final phoneEditingController = TextEditingController();
  final pinEditingController = TextEditingController();


  @override
  void onInit() {
    super.onInit();
    fetchAllStudents();
  }

  Future<void> fetchAllStudents() async {
    try {
      final fetchedStudents = await getAllStudents();
      students.assignAll(fetchedStudents);
      filteredStudents.assignAll(fetchedStudents); 
    
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching students: $e');
      }
    }
  }

  Future<void> addStudent(StudentModel student) async {
    try {
      await addStudent(student);
      fetchAllStudents();
    } catch (e) {
     if (kDebugMode) {
        print('Error fetching students: $e');
      }
    }
  }

  Future<void> updateStudent(StudentModel student) async {
    try {
      await updateStudent(student);
      fetchAllStudents(); 
    } catch (e) {
     if (kDebugMode) {
        print('Error fetching students: $e');
      }
    }
  }

  Future<void> deleteStudent(int studentId) async {
    try {
      await deleteStudent(studentId);
      fetchAllStudents();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching students: $e');
      }
    }
  }

  void search(String query) {
    final lowerCaseQuery = query.toLowerCase();
    if (lowerCaseQuery.isEmpty) {
      filteredStudents.assignAll(students);
    } else {
      filteredStudents.assignAll(
        students.where((student) {
          return student.name.toLowerCase().contains(lowerCaseQuery);
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
     if (kDebugMode) {
        print('Error fetching students: $e');
      }
      return null;
    }
  }
}
