
import 'dart:io';
import 'dart:typed_data';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tiktok_app/pages/home_page.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';




class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Image? image ; 

late VideoPlayerController _controller;
   


  @override
  void initState() {
    super.initState();
    
 
  }

  @override
  Widget build(BuildContext context) {
    var wid = MediaQuery.of(context).size.width;
    return Scaffold(  
      backgroundColor: Colors.black,
      
      body: ListView(
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                     image: DecorationImage(image: AssetImage("assets/images/ademnr.png")),
                      borderRadius: BorderRadius.circular(75)),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '@ademNr2',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 60,
                child: Column(
                  children: [
                    Text(
                      '1',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      'followers',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 60,
                child: Column(
                  children: [
                    Text(
                      '12',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      'follower',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 60,
                child: Column(
                  children: [
                    Text(
                      '23',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      'Like',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: 160,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.pink.shade500,
                ),
                child: Text(
                  'Edit',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    border: Border.all(width: 1, color: Colors.black38)),
                child: Icon(Icons.campaign_rounded),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    border: Border.all(width: 1, color: Colors.black38)),
                child: Icon(
                  Icons.arrow_drop_down,
                  size: 35,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.center,
            width: 275,
            child: Text(
              '---- hey this is just a bio ----',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                      color: Colors.white,
                      width: 0.2,
                    ),
                    top: BorderSide(
                      color: Colors.black12,
                      width: 1,
                    )),
              ),
             ),
            
             SizedBox(height: 5,),
             Expanded(
               child: Container(
                        height: 700,
                 child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.7,
                   crossAxisCount: 3,
                 ),
                         itemCount: 4,
                         itemBuilder: (context , index){
                   
                         return   Container(
                          height : 800, 
                        alignment: Alignment.bottomLeft,
                        margin: EdgeInsets.all(3),
                        width: (wid / 3) - 2,
                        
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                            Colors.white.withOpacity(0.5),
             
                             Colors.white.withOpacity(0.4),
                              Colors.white.withOpacity(0.3),
                               Colors.white.withOpacity(0.2),
                                Colors.white.withOpacity(0.1),
                                 Colors.white.withOpacity(0.0)
                          ])
             
                        ),
                        child: Positioned(
                          bottom: 1 ,
                          child: Row(children: [
                            Icon(Icons.play_arrow, color: Colors.white,),
                            Text("2.4 K", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
                          ]),
                          ),
             
                      ) ; 
                        }),
               ),
             )
          
        ],
      ),
    );
  }
}

  
