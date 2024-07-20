import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampstudentapp/controller/controller.dart';
import 'package:sampstudentapp/core/colors.dart';
import 'package:sampstudentapp/core/constants.dart';
import 'package:sampstudentapp/presentation/addpage/add_student.dart';
import 'package:sampstudentapp/presentation/search/search_page.dart';
import 'package:sampstudentapp/widgets/showdailouge.dart';

final StudentController studentController = Get.put(StudentController());

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirm Exit'),
            content: const Text('Do you want to exit the app?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => exit(0),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    studentController.fetchAllStudents();
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text('Student app'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: IconButton(
                onPressed: () {
                  Get.to(const SearchPage());
                },
                icon: const Icon(Icons.search),
              ),
            ),
          ],
        ),
        body: Obx(
          () => ListView.separated(
            separatorBuilder: (context, index) => kheight10,
            itemCount: studentController.students.length,
            itemBuilder: (context, index) {
              var student = studentController.students[index];

              return InkWell(
                onTap: () {
                  StudentDialog.showStudentDialog(
                    context,
                    student
                  );
                },
                child: Container(
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
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 152, 169, 238),
          onPressed: () {
            Get.to(() => const AddStudents())?.then((value) {
              studentController.fetchAllStudents();
            });
          },
          child: const Icon(Icons.add, color: kwhite),
        ),
      ),
    );
  }
}
