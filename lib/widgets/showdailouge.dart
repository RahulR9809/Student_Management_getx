import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampstudentapp/core/constants.dart';
import 'package:sampstudentapp/model/model.dart';
import 'package:sampstudentapp/presentation/update/update_page.dart';
import 'package:sampstudentapp/widgets/deletedailog.dart';
class StudentDialog {
  static void showStudentDialog(
      BuildContext context, StudentModel student,) {
    showDialog(
      context: context,
      builder: (BuildContext context) { 
        return AlertDialog(
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: student.image.isNotEmpty &&
                            File(student.image).existsSync()
                        ? FileImage(File(student.image))
                        : AssetImage('assets/default_avatar.png') as ImageProvider,
                  ),
                  IconButton(
                    onPressed: () {
                  Get.to(UpdatePage(student: student));
                    },
                    icon: Icon(Icons.edit_note, size: 30),
                  ),
                ],
              ),
              DailogeText('NAME: ${student.name}'),
              kheight10,
              DailogeText('AGE: ${student.age}'),
              kheight10,
              DailogeText('COURSE: ${student.course}'),
              kheight10,
              DailogeText('PLACE: ${student.place}'),
              kheight10,
              DailogeText('PINCODE: ${student.pincode}'),
              kheight10,
              DailogeText('PHONE: ${student.phone}'),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    DeleteDailog.deletedailog(context, student,);
                  },
                  icon: const Icon(Icons.delete),
                  color: Colors.red,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  static Text DailogeText(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}
