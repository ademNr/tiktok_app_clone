import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tiktok_app/pages/add_video_page.dart';
import 'package:tiktok_app/pages/home_page.dart';
import 'package:tiktok_app/pages/profile_page.dart';



getRandomColor() => [
  Colors.blueAccent,
  Color(0xFFFF004F),
  Colors.greenAccent,
][Random().nextInt(3)];

// COLORS
const backgroundColor = Colors.black;

const borderColor = Colors.grey;

var pageindex = [
  MyHomePage(), 
 AddVideoPage(),
  Profile()
];

class Api{
  static String url = "http://10.0.2.2:3000/api/"; 
}