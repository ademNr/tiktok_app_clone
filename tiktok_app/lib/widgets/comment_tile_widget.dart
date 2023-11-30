
import 'package:flutter/material.dart';

class CommentWidget extends StatelessWidget {
  final String userName ; 
  final String image ; 
  final String comment ; 
  const CommentWidget({Key? key, required this.userName, required this.image, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
              leading: CircleAvatar(               
                radius: 20,
                backgroundImage:  AssetImage('assets/images/adem.png')
              ),
              title: Text("${userName} ", style: TextStyle(color: Colors.black , fontWeight: FontWeight.w900),),
              subtitle: Text("${comment} ", style: TextStyle(color: Colors.black , fontWeight: FontWeight.w400),),
              trailing: Text("1h ago", style: TextStyle(color: Colors.black),),
            );
  }
}