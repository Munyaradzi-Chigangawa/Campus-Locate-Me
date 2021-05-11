//import 'dart:io';
import 'package:flutter/material.dart';
import 'package:campus_locate_me/blocs/sign_in_bloc.dart';
import 'package:campus_locate_me/config/config.dart';
import 'package:campus_locate_me/pages/done.dart';
import 'package:campus_locate_me/pages/sign_up.dart';
import 'package:campus_locate_me/utils/app_name.dart';
import 'package:campus_locate_me/utils/next_screen.dart';
import 'package:provider/provider.dart';
import 'done.dart';
//import 'package:easy_localization/easy_localization.dart';



class WelcomePage extends StatefulWidget {
  final String tag;
  const WelcomePage({Key key, this.tag}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {


  var scaffoldKey = GlobalKey<ScaffoldState>();
 

  handleSkip (){
    final sb = context.read<SignInBloc>();
    sb.setGuestUser();
    nextScreen(context, DonePage());
    
  }


  



  


  handleAfterSignIn (){
    setState(() {
      Future.delayed(Duration(milliseconds: 1000)).then((f){
      gotoNextScreen();
      });
    });
  }



  gotoNextScreen (){
    if(widget.tag == null){
      nextScreen(context, DonePage());
    }else{
      Navigator.pop(context);
    }
  }




  
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        actions: [
          widget.tag != null
              ? Container()
              : TextButton(
                  onPressed: () => handleSkip(),
                  child: Text('skip',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ))),
          
        ],
      ),
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                        image: AssetImage(Config().splashIcon),
                        height: 130,
                      ),
                    SizedBox(height: 50,),
                    Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Welcome to', style: TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w300, color: Colors.black
                      ),),
                      SizedBox(width: 10,),
                      AppName(fontSize: 25),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 5),
                    child: Text(
                      'Please sign in to continue',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color:Colors.black),
                    ),
                  )
                ],
              ),
                  ],
                )),
            Spacer(),
            SizedBox(height: 30,),
            //Text("don't have social accounts?") ,
            TextButton(
                child: Text('Authentication >>>', style: TextStyle(color: Theme.of(context).primaryColor),),
                onPressed: (){
                  if(widget.tag == null){
                    nextScreen(context, SignUpPage());

                  }else{
                    nextScreen(context, SignUpPage(tag: 'Popup',));
                  }
                
              },
             
            ),
            SizedBox(height: 15,),
            
          ],
        ),
      ),
    );
  }
  
}