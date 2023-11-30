

import 'package:flutter/material.dart';
import 'package:tiktok_app/helpers/constants.dart';
import 'package:tiktok_app/widgets/add_widget.dart';
import 'package:tiktok_app/widgets/glitch_widget.dart';

class BottomNavigation extends StatefulWidget {
  BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int pageIdx = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: BottomNavigationBar(
type: BottomNavigationBarType.fixed,
        backgroundColor: backgroundColor,
        onTap: (index){
  setState(() {
    pageIdx = index;
  });
        },
        currentIndex: pageIdx,
        items: [
          BottomNavigationBarItem(
              icon: Image.asset("assets/images/icons8-home-64.png", scale: 2,),
            label: ''

          ),

         

          BottomNavigationBarItem(
              icon: CustomAddIcon(),
              label: ''

          ),

        

          BottomNavigationBarItem(
              icon: Image.asset("assets/images/icons8-user-24.png", scale :1.2 ),
              label: ''

          ),
        ],
      ),
      body: Center(
        child: pageindex[pageIdx],
      ),
    );
  }
}