import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sampstudentapp/core/constants.dart';
import 'package:sampstudentapp/db/db_functions.dart';
import 'package:sampstudentapp/model/model.dart';
import 'package:sampstudentapp/presentation/home/home.dart';
import 'package:sampstudentapp/widgets/custom_textformfield.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key, required this.student, });
  final StudentModel student;
  // final Function(StudentModel) onUpdate;

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController placeController;
  late TextEditingController courseController;
  late TextEditingController imageController;
  late TextEditingController phoneController;
  late TextEditingController pinController;
  bool photoRequiredError = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
     nameController = TextEditingController(text: widget.student.name);
    ageController = TextEditingController(text: widget.student.age.toString());
    placeController = TextEditingController(text: widget.student.place);
    courseController = TextEditingController(text: widget.student.course);
    imageController = TextEditingController(text: widget.student.image);
    phoneController = TextEditingController(text: widget.student.phone.toString());
    pinController = TextEditingController(text: widget.student.pincode.toString());
    RxString pickedimage=RxString(widget.student.image);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Update Student',
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
                   ()=> InkWell(
                      onTap:()async{
                       final imagepath=await studentController.pickImage(ImageSource.gallery);
                       pickedimage.value=imagepath ?? '';
                      },
                      child: CircleAvatar(
                        backgroundColor: const Color.fromARGB(255, 69, 82, 134),
                        radius: 70,
                        backgroundImage: pickedimage.isEmpty
                            ? const NetworkImage(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShyZWYPEncWdEfHARCCc_DcvFFf1f1qcAgxQ&s')
                            : FileImage(File(pickedimage.value)),
                      ),
                    ),
                  ),
                ),
                if (photoRequiredError)
                  const Text(
                    'Photo required',
                    style: TextStyle(color: Colors.red),
                  ),
                kheight20,
                CustomTextFormField(
                  controller: nameController,
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
                  controller: ageController,
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
                  controller: placeController,
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
                  controller: pinController,
                  labelText: 'Pincode',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Pincode required';
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
                  controller: courseController,
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
                  controller: phoneController,
                  labelText: 'Phone',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone required';
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
                      if (pickedimage.isEmpty || pickedimage.value.isEmpty) {
                          photoRequiredError = true;
                      } else {
                        StudentModel updatedStudent = widget.student.copyWith(
                          name: nameController.text,
                          age: ageController.text,
                          place: placeController.text,
                          course: courseController.text,
                          image:pickedimage.string,
                          phone: int.parse(phoneController.text),
                          pincode: int.parse(pinController.text),
                        );
                        updateStudent(updatedStudent);
                       
                        Get.to(const Homepage());
                      }
                    }
                  },
                  style: style,
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


