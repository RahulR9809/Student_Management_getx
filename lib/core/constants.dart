import 'package:flutter/material.dart';

final kheight10=SizedBox(height: 10,);
final kheight20=SizedBox(height: 20,);

final kwidth10=SizedBox(width: 10,);

final border= OutlineInputBorder( 
                      borderRadius: BorderRadius.circular(20)
                    );
final style=ElevatedButton.styleFrom(
    foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text color
    shadowColor: Colors.blueAccent, // Shadow color
    elevation: 5, // Elevation
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0), // Rounded corners
    ),
  );