import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sampstudentapp/controller/controller.dart';
import 'package:sampstudentapp/core/constants.dart';
import 'package:sampstudentapp/db/db_functions.dart';
import 'package:sampstudentapp/model/model.dart';
import 'package:sampstudentapp/widgets/custom_textformfield.dart';

class AddStudents extends StatefulWidget {
  const AddStudents({super.key,});

  @override
  State<AddStudents> createState() => _AddStudentsState();
}

class _AddStudentsState extends State<AddStudents> {
 


  RxBool photoRequiredError = false.obs;

  final formKey = GlobalKey<FormState>();
  RxString pickImage = RxString('');
  final StudentController studentController = Get.find<StudentController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'add here',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Obx(
                      () => InkWell(
                          onTap: () async {
                            final imagepath =
                        await studentController.pickImage(ImageSource.gallery);
                    pickImage.value = imagepath ?? '';
                            photoRequiredError.value = pickImage.value.isEmpty;
                          },
                          child: CircleAvatar(
                            backgroundColor: const Color.fromARGB(255, 69, 82, 134),
                            radius: 70,
                            backgroundImage: pickImage.value.isNotEmpty
                                ? FileImage(File(pickImage.value))
                                : null,
                            child: pickImage.value.isEmpty
                                ? const Icon(
                                    Icons.person,
                                    size: 50,
                                    color: Colors.white,
                                  )
                                : null,
                          )),
                    ),
                  ),
                  Obx(() {
                    if (photoRequiredError.value) {
                      return const Text(
                        'Photo required',
                        style: TextStyle(color: Colors.red),
                      );
                    } else {
                      return const SizedBox(); // Return an empty SizedBox if no error
                    }
                  }),
                  kheight20,
                  CustomTextFormField(
                    controller: studentController.nameEditingController,
                    labelText: 'Name',
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name required';
                      }
                      if (RegExp(r'\d').hasMatch(value)) {
                        return 'Numbers are not allowed';
                      }
                      if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                        return 'Special characters are not allowed';
                      }
                      return null;
                    },
                  ),
                  kheight10,
                  CustomTextFormField(
                    controller: studentController.ageEditingController,
                    labelText: 'Age',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Age required';
                      }
                      if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'Only numbers are allowed';
                      }
                      if (value.length >= 3 || value.length <= 1) {
                        return 'Enter valid age';
                      }

                      return null;
                    },
                  ),
                  kheight10,
                  CustomTextFormField(
                    controller: studentController.placeEditingController,
                    labelText: 'Place',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Place required';
                      }
                      if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                        return 'Special characters are not allowed';
                      }
                      return null;
                    },
                  ),
                  kheight10,
                  CustomTextFormField(
                    controller: studentController.pinEditingController,
                    labelText: 'pincode',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'pincode required';
                      }
                      if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'Only numbers are allowed';
                      }
                      if (value.length < 6 || value.length > 6) {
                        return 'Enter valid pincode ';
                      }

                      return null;
                    },
                  ),
                  kheight10,
                  CustomTextFormField(
                    controller: studentController.courseEditingController,
                    labelText: 'Course',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Course required';
                      }
                      if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                        return 'Special characters are not allowed';
                      }
                      return null;
                    },
                  ),
                  kheight10,
                  CustomTextFormField(
                    controller: studentController.phoneEditingController,
                    labelText: 'Phone',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'phone required';
                      }
                      if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'Only numbers are allowed';
                      }
                      if (value.length < 10 || value.length > 10) {
                        return 'Enter valid phone number';
                      }

                      return null;
                    },
                  ),
                  kheight10,
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (pickImage.value.isEmpty) {
                           ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select an image'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        } else {
                          addstudentbuttonclicked();
                          Get.back();
                        }
                      }
                    },
                    style: style,
                    child: const Text(
                      'Submit',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> addstudentbuttonclicked() async {
    try {
      final name =studentController. nameEditingController.text.trim();
      final age = studentController.ageEditingController.text.trim();
      final place = studentController.placeEditingController.text.trim();
      final course = studentController.courseEditingController.text.trim();
      final phone = studentController.phoneEditingController.text.trim();
      final pincode = studentController.pinEditingController.text.trim();

      if (name.isEmpty ||
          age.isEmpty ||
          place.isEmpty ||
          course.isEmpty ||
          phone.isEmpty ||
          pincode.isEmpty) {
        return;
      }

      final student = StudentModel(
        name: name,
        age: age,
        place: place,
        course: course,
        image: pickImage.value,
        phone: int.parse(phone),
        pincode: int.tryParse(pincode),
      );

      await addStudent(student);


 studentController.nameEditingController.clear();
    studentController.ageEditingController.clear();
    studentController.placeEditingController.clear();
    studentController.courseEditingController.clear();
    studentController.phoneEditingController.clear();
    studentController.pinEditingController.clear();
    } catch (e) {
      if (kDebugMode) {
        print('Error adding student: $e');
      }
    }
  }
}
