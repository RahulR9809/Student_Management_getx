import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampstudentapp/controller/controller.dart';
import 'package:sampstudentapp/core/colors.dart';
import 'package:sampstudentapp/core/constants.dart';
import 'package:sampstudentapp/widgets/showdailouge.dart';
   final StudentController studentController = Get.put(StudentController());

class SearchPage extends StatefulWidget {
   const SearchPage({super.key});
  @override
  State<SearchPage> createState() => _SearchPageState();
}
class _SearchPageState extends State<SearchPage> {
  final searchcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    studentController.fetchAllStudents();
    return Scaffold(
   appBar: AppBar(
        centerTitle: true,
        title: const Text('Search Students'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                controller: searchcontroller,
                onChanged: (value){
                  studentController.search(value);
                },
                  
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),

          Expanded(
            child: Obx(
              (){
                   if (studentController.students.isEmpty) {
                  return const Center(child: Text('No students found'));
                } else {
               return ListView.separated(
              separatorBuilder: (context, index) => kheight10,
              itemCount: studentController.filteredStudents.length,
              itemBuilder: (context, index) {
                var student=studentController.filteredStudents[index];
                return GestureDetector(
                  onTap: () {
                    StudentDialog.showStudentDialog(context, student,);
                  },
                  child:  Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: backgroundcolor,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                 
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: FileImage(File(student.image)),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 36),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  student.name,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    color: kwhite,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Course: ${student.course}',
                                  style: const TextStyle(
                                    color: kwhite,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Age: ${student.age}',
                                  style: const TextStyle(
                                    color: kwhite,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                  
                    ],
                  ),
                )
                ); 
              }, 
                      );
                      }
              } 
            ),
          ),
        ],
      ),
    );
  }
}