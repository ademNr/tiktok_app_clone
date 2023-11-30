import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_app/bottom_navigation/bottom_navigation.dart';
import 'package:tiktok_app/providers/video/video_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => VideoProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false ,
        title: 'TikTok',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,
        ),
        home: BottomNavigation(), 
      ),
    );
  }
}
