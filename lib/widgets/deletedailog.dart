import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampstudentapp/db/db_functions.dart';
import 'package:sampstudentapp/model/model.dart';
import 'package:sampstudentapp/presentation/home/home.dart';

class DeleteDailog{
    static Future<dynamic> deletedailog(
      BuildContext context, StudentModel student) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Delete'),
            titleTextStyle: const TextStyle(
                color: Color.fromARGB(255, 238, 43, 43),
                fontSize: 20,
                fontFamily: 'poppins',
                fontWeight: FontWeight.bold),
            actions: [
              TextButton(
                  onPressed: () {
                    deleteStudent(student.id);
                    Get.back();
                    Get.to(const Homepage());
                  },
                  child: const Text('YES',
                      style: TextStyle(fontFamily: 'poppins', fontSize: 15))),
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(
                    'NO',
                    style: TextStyle(fontFamily: 'poppins', fontSize: 15),
                  ))
            ],
          );
        });
  }
}