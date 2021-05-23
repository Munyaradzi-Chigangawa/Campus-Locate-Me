import 'package:flutter/material.dart';
import 'package:campus_locate_me/pages/sign_in.dart';
import 'package:campus_locate_me/utils/next_screen.dart';

openSignInDialog(context){
   return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx){
        return AlertDialog(
          title: Text('Sign in first to access this feature') ,
          content: Text("You haven't signed in yet. Please sign in to unlock this feature") ,
          actions: [
            FlatButton(
              onPressed: (){
                Navigator.pop(context);
                nextScreenPopup(context, SignInPage(tag: 'popup',));
              }, 
              child: Text('Sign in') ),

              FlatButton(
              onPressed: (){
                
                
                Navigator.pop(context);
              }, 
              child: Text('Cancel') )
          ],
        );
      }
    );
 }