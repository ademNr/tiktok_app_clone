import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:tiktok_app/models/video_model.dart';
import 'package:tiktok_app/providers/video/video_provider.dart';
import 'package:tiktok_app/widgets/comment_tile_widget.dart';
import 'package:tiktok_app/widgets/like_button.dart';


import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late VideoPlayerController _controller; 
    bool liked = false ;
  @override
  void initState() {
    super.initState();
    
    Provider.of<VideoProvider>(context, listen: false).fetchVideos();
    _controller = VideoPlayerController.network('');

  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
   int _currentIndex = 0;
 

  @override
  Widget build(BuildContext context) {
     
        return Scaffold(
          backgroundColor: Colors.black ,
          body: Consumer<VideoProvider>(
      builder: (context, videoProvider, _) {
        return PageView.builder(
          itemCount: videoProvider.videos?.length,
          controller: PageController(initialPage: 0, viewportFraction: 1),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            final video = videoProvider.videos?[index];
            final videoPath =
                'http://10.0.2.2:3000/api/video/${video?.filePath?.replaceAll('\\', '/').trim()}';
            print(videoPath);
            return VideoPlayerPage(
              videoUrl: videoPath,
            );
          },
        );
      },
    )
        );
            
          }
        }
      
    
 class VideoPlayerPage extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerPage({
    Key? key,
    required this.videoUrl,
  }) : super(key: key);

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _controller;
  bool _isPaused = false;
  bool liked = false ; 
  bool followed = false ; 
List<String> usernames = ["ademNr", "anonymous", "testing"]; 
List<String> comments = ["testing comment xD", "lorem ipsummmm mmm m mm m m", "another one :) "];
List<String> images = ["assets/images/adem.png", "assets/images/tiktokLogo.png", "assets/images/tiktokLogo.png"];

void _openComments() {
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
    ),
    backgroundColor: Colors.white,
    context: context,
    builder: (BuildContext context) {
      return Column(
        children: [
          SizedBox(height: 30),
          Text("3 comments", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
          SizedBox(height: 30),
          Container(
            height: 300,
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return CommentWidget(userName: usernames[index], image: images[index], comment: comments[index]);
              },
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0,),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      
                      hintText: 'Add a comment...',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.zero),
                  child: ElevatedButton(
                    
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFF004F), 
                      
                      shape : RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                    ),
                    onPressed: () {
                      // Add logic to handle adding the comment
                      // For example, you can access the entered text using the controller
                      // or pass it to a function that adds the comment
                    },
                    child: Text('Add', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}

  


  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..addListener(() {
        if (_controller.value.isInitialized) {
          // Video has been initialized, update the state to rebuild the UI
          setState(() {});
        }
      });

    await _controller.initialize();
    _controller.play();
    _controller.setLooping(true);
    _controller.setVolume(1);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;
      if (_isPaused) {
        _controller.pause();
      } else {
        _controller.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Use a Stack to overlay CircularProgressIndicator and Pause Icon while the video is loading or paused
    return SafeArea(
      child: Stack(
      children: [
      
        Container(
          width: size.width,
          height: size.height,
          color: Colors.black,
          child: _controller.value.isInitialized
              ? VideoPlayer(_controller)
              : Center(
                child: LoadingAnimationWidget.twistingDots(
                        leftDotColor: Color.fromARGB(229, 86, 214, 150),
                        rightDotColor:  Color.fromARGB(232, 255, 0, 81), 

                        size: 40,
                      ),
              ),
        ),
        if (_isPaused && _controller.value.isPlaying) // Show Pause Icon in the middle of the video
          Center(
            child: Icon(
              Icons.pause,
              size: 48.0,
              color: Colors.white,
            ),
          ),
        GestureDetector(
          onTap: _togglePause,
          child: Container(
            width: size.width,
            height: size.height,
            color: Colors.transparent, // Make the GestureDetector transparent
          ),
        ),
        Positioned(
        top: 0,
         child: Container(
             width: MediaQuery.of(context).size.width, // Set the width as needed
             height: 150.0, // Set the height as needed
             decoration: BoxDecoration(
          gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                  Colors.black.withOpacity(0.7), 
                  Colors.black.withOpacity(0.6), 
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.3), // Middle with 20% opacity
                    Colors.black.withOpacity(0.2), 
                    
                      Colors.black.withOpacity(0.0),
                  ],
                ),
         // Optional: Add rounded corners
          
             ),
             
           ),
       ),
       Padding(
        padding: EdgeInsets.only(top: 20),
         child: Align(
          alignment: AlignmentDirectional.topCenter, 
           child: Column(
            
                children: [
                  Text(
                    'For you ',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 20.0, // Adjust the font size as needed
                    ),
                  ),
                  Container(
                    height: 4.0,
                    width: 80.0, // Adjust the width of the underline as needed
                  
                    margin: EdgeInsets.symmetric(vertical: 8.0), // Adjust the vertical margin as needed
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),   color: Colors.white,),
                  ),
                ],
              ),
         ),
       ),
        
      
      
         Positioned(
        bottom: 0,
         child: Container(
             width: MediaQuery.of(context).size.width, // Set the width as needed
             height: 150.0, // Set the height as needed
             decoration: BoxDecoration(
          gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                  
                  Colors.black.withOpacity(0.7), 
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.5), // Middle with 20% opacity
                    Colors.black.withOpacity(0.4), 
                    Colors.black.withOpacity(0.3), 
                    
                      Colors.black.withOpacity(0.0),
                  ],
                ),
         // Optional: Add rounded corners
          
             ),
             
           ),
       ),
       Positioned(
       bottom: 0,
       left: 10,
       child:   Container(
        height: 80,
        width: 300,
         child: ListTile(
        
             title: Text("Adem Nouira", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
             subtitle: Text("@ademNr", style: TextStyle(color: Colors.white),),
         
         
         ),
       ),
       ),
       

    Positioned(
      right: 20,
      bottom: 40,
      child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
    
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
         height: 45,
         width: 45,
                 decoration: ShapeDecoration(
                     image: DecorationImage(
                       
                         image:  AssetImage(
             'assets/images/adem.png',
                           ),
                         fit: BoxFit.fill,
                     ),
                     shape: OvalBorder(),
                 ),
             ),
             Positioned(
              bottom: 0,
              right: 0,
              
               child: GestureDetector(
                onTap: (){
                            setState(() {
                              if(followed == true ){
                            followed = false ; 
                              }else{
                                followed = true ;
                              }
                            });
                        },
                 child: Container(
                     width: 20.0,
                     height: 20.0,
                     decoration: BoxDecoration(
                       color: followed ? Colors.green   : Color(0xFFFF004F),  
               
                       borderRadius: BorderRadius.circular(10.0), // Adjust the border radius as needed
                     ),
                     child: Center(
                       child: GestureDetector(
                        onTap: (){
                            setState(() {
                               if(followed == true ){
                            followed = false ; 
                              }else{
                                followed = true ;
                              }
                            });
                        },
                         child: Icon(
                           Icons.add,
                           color:  Colors.white,
                           size: 15.0, // Adjust the icon size as needed
                         ),
                       ),
                     ),
                   ),
               ),
             ), 
            ],
          ), 
              SizedBox(height: 25),
          GestureDetector(
              onTap: (){
        setState(() {
          if(liked == false ){
            liked = true ; 
          }else{
            liked = false ;
          }
        });
      },
            child: Icon(Icons.favorite, size: 30, color:liked ?  Color(0xFFFF004F) :  Colors.white)),
          SizedBox(height: 3),
          liked ? Text(
          "3", 
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ) : Text(
          "2", 
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    ) ,
                SizedBox(height: 20),
                Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
       _openComments();
            },
            child: Image.asset("assets/images/icons8-comment-30.png"),
          ), 
          SizedBox(height: 3),
          Text(
          "3", 
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ],
      ),
                SizedBox(height: 20),
                Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [ 
          
          GestureDetector(
            onTap: (){
              Share.share("tiktok");
            },
            child: Image.asset("assets/images/icons8-share-32.png")),
          SizedBox(height: 3),
          Text(
          "0", 
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ],
      ),
              ],
            ),
    ),

      ],
        ),
    );
  }
}