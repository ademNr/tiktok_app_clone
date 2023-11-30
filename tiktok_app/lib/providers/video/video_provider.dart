

import 'package:flutter/material.dart';
import 'package:tiktok_app/models/video_model.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tiktok_app/helpers/constants.dart';
import 'package:tiktok_app/models/video_model.dart';
class VideoProvider extends ChangeNotifier{

  List<Video>? videos   ; 


  // upload the video 
  Future<void> uploadVideo(String userId, File videoFile) async {
  try {
    // Create a multipart request
    var request = http.MultipartRequest(  
      'POST',
      Uri.parse('${Api.url}video/upload-video/${userId}'),
    );

    // Add the user ID as a field
    request.fields['userId'] = userId;

    // Add the video file as a part
    request.files.add(http.MultipartFile(
      'video',
      videoFile.readAsBytes().asStream(),
      videoFile.lengthSync(),
      filename: videoFile.path.split('/').last,
    ));

    // Send the request
    var response = await request.send();

    // Check the response status code
    if (response.statusCode == 200) {
      // Parse the response body
      print("video uploaded successfully");
      final String responseBody = await response.stream.bytesToString();
      return json.decode(responseBody);
      
    } else {
      print("video not uploaded");
      throw Exception('Failed to upload video. Server responded with status ${response.statusCode}.');
    }
  } catch (e) {
    print("video not uplaoded");
    throw Exception('Failed to upload video: $e');
  }
}


// fetch the video function  
Future<void> fetchVideos() async {
 
    final response = await http.get(Uri.parse('${Api.url}video/videos'));
    if (response.statusCode == 200) {
      print("videos fetched success");
        final List<dynamic> jsonData = json.decode(response.body)['data'];
        videos = jsonData.map((json) => Video.fromJson(json)).toList();
      
    } else {
      // Handle error; 
      print("error fetching videos from the api "); 
   
    
    }
  }


   
}