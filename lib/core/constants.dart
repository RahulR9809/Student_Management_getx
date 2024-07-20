import 'package:flutter/material.dart';

const kheight10= SizedBox(height: 10,);
const kheight20=SizedBox(height: 20,);

const kwidth10=SizedBox(width: 10,);

final border= OutlineInputBorder( 
                      borderRadius: BorderRadius.circular(20)
                    );
final style=ElevatedButton.styleFrom(
    foregroundColor: Colors.white, backgroundColor: Colors.blue, 
    shadowColor: Colors.blueAccent,
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
  );