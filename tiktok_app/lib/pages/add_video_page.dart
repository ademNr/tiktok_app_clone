import 'dart:io';
import 'dart:typed_data';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tiktok_app/pages/yes_to_upload_page.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_app/helpers/constants.dart';
import 'package:tiktok_app/providers/video/video_provider.dart';
import 'package:tiktok_app/widgets/glitch_widget.dart';
class AddVideoPage extends StatefulWidget {
   AddVideoPage({Key? key}) : super(key: key);

  @override
  State<AddVideoPage> createState() => _AddVideoPageState();
}

class _AddVideoPageState extends State<AddVideoPage> {
bool uploadLoading  = false ; 
  File _videoFile = File("") ; 
  
Future<void> _pickVideo() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.video,
    allowMultiple: false,
  );

  if (result != null) {
    print("file is not null");

    setState(() {
      _videoFile = File(result.files.first.path!); // Convert path to File
    });

     Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ConfirmUpload(file: _videoFile,)),
            );

    // Use the thumbnailImage as needed (e.g., display in an Image widget)

    // The rest of your code .for uploading the video goes here

  
  } else {
    print("file is null");
  }
}

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      backgroundColor: Colors.black.withOpacity(0.99),
      body:  uploadLoading ? Center(
                child: LoadingAnimationWidget.twistingDots(
                        leftDotColor: Color.fromARGB(229, 86, 214, 150),
                        rightDotColor:  Color.fromARGB(232, 255, 0, 81), 

                        size: 40,
                      ),
              ):   Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 100,),
          GlithEffect(child: Image.asset("assets/images/tiktokLogo-removebg-preview.png", scale: 1.5,)),
          Container(
            margin: EdgeInsets.all(50),
            child: Text(
              "Add Limitless videos Thanks to TikTok and scroll Endlessly to waste your time ", 
              style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w800),
              ),
          ) , 
          SizedBox(height: 50,),
          Center(
            child: GestureDetector(
                  onTap: () {
                    _pickVideo(); 
                  },
                  child: Container(
            width: 350,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color(0xFFFF004F)

            ),
            child: Center(
              child: Text("Gallery" , style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w700
              ),),
            ),
                  ),
                ),
          ),
          SizedBox(height: 20,),
      Center(
        child: GestureDetector(
          onTap: () => _pickVideo(), 
          child: Container(
            width: 350,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white
            ),
            child: Center(
              child: Text("Camera" , style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w700
              ),),
            ),
          ),
        ),
      ),
      

      ],),
    );
  }
} 