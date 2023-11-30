import 'dart:io';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_app/bottom_navigation/bottom_navigation.dart';
import 'package:tiktok_app/pages/home_page.dart';
import 'package:tiktok_app/providers/video/video_provider.dart';
import 'package:video_player/video_player.dart';

class ConfirmUpload extends StatefulWidget {
  final File file;

  ConfirmUpload({Key? key, required this.file}) : super(key: key);

  @override
  State<ConfirmUpload> createState() => _ConfirmUploadState();
}

class _ConfirmUploadState extends State<ConfirmUpload> {
  late VideoPlayerController _controller;
  late VoidCallback _listener;
  bool _isPlaying = false;
 bool uploadLoading = false  ;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.file)
      ..initialize().then((_) {
        setState(() {});
        _listener = () {
          if (!mounted) {
            return;
          }
          setState(() {});
        };
        _controller.addListener(_listener);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: uploadLoading ? Center(
                child: LoadingAnimationWidget.twistingDots(
                        leftDotColor: Color.fromARGB(229, 86, 214, 150),
                        rightDotColor:  Color.fromARGB(232, 255, 0, 81), 

                        size: 40,
                      ),
              )  : SafeArea(
        child: Column(
          children:[ Stack(
            children: [
              _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          VideoPlayer(_controller),
                          VideoProgressIndicator(
                            _controller,
                            allowScrubbing: true,
                            colors: VideoProgressColors(
                              playedColor: Colors.red,
                              bufferedColor: Colors.grey,
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(Icons.replay),
                                onPressed: () {
                                  _controller.seekTo(Duration.zero);
                                  _controller.play();
                                },
                                color: Colors.white,
                              ),
                              IconButton(
                                icon: Icon(
                                  _isPlaying ? Icons.pause : Icons.play_arrow,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPlaying ? _controller.pause() : _controller.play();
                                    _isPlaying = !_isPlaying;
                                  });
                                },
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Center(
                child: LoadingAnimationWidget.twistingDots(
                        leftDotColor: Color.fromARGB(229, 86, 214, 150),
                        rightDotColor:  Color.fromARGB(232, 255, 0, 81), 

                        size: 40,
                      ),
              )  ,
              Positioned(
                top: 16.0,
                right: 16.0,
                child: Text(
                  _controller.value.isInitialized
                      ? '${_formatDuration(_controller.value.duration)}'
                      : '00:00',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
             
            ],
          ),
           Positioned(
              bottom: 0,
              child: Padding(
                padding: EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BottomNavigation()),
            );
                    },
                    child: Container(
                    height: 50,
                    width:150,
                    decoration: BoxDecoration(
                        color:  Color.fromARGB(95, 64, 63, 63),
                        borderRadius: BorderRadius.circular(10), 
                    ),
                    child: Center(child: Text("Cancel", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),)),
                    ),
                  ),
                  SizedBox(width: 20,),
                   GestureDetector(
                    onTap: ()async{
                        setState(() {
    uploadLoading = true ; 
  });
   await Provider.of<VideoProvider>(context, listen: false).uploadVideo("6561d8e8f1d4a6a5ce26cb52", widget.file);
     await   Provider.of<VideoProvider>(context, listen: false).fetchVideos();
    setState(() {
      uploadLoading =false ; 
    });
 Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BottomNavigation()),
            );
            final snackBar = SnackBar(
              content: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.white), // Success icon
                  SizedBox(width: 8.0), // Spacer between icon and text
                  Text('Video uploaded successfully', style: TextStyle(color: Colors.white)),
                ],
              ),
              backgroundColor: Color.fromARGB(220, 82, 215, 153),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    },
                     child: Container(
                                     height: 50, 
                                     width:150,
                                     decoration: BoxDecoration(
                        color: Color(0xFFFF004F),
                   
                        borderRadius: BorderRadius.circular(10), 
                                     ),
                                     child: Center(child: Text("Publish", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),)),
                                     ),
                   ),
                ],),
              )
            )
          ]
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }
}
