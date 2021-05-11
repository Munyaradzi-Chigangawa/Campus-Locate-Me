import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:campus_locate_me/blocs/internet_bloc.dart';
import 'package:campus_locate_me/blocs/sign_in_bloc.dart';
import 'package:campus_locate_me/pages/done.dart';
import 'package:campus_locate_me/pages/forgot_password.dart';
import 'package:campus_locate_me/pages/sign_up.dart';
import 'package:campus_locate_me/pages/welcome.dart';
import 'package:campus_locate_me/utils/icons.dart';
import 'package:campus_locate_me/utils/next_screen.dart';
import 'package:campus_locate_me/utils/snacbar.dart';
import 'package:provider/provider.dart';



class SignInPage extends StatefulWidget {
  final String tag;
  SignInPage({Key key, this.tag}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  bool offsecureText = true;
  Icon lockIcon = LockIcon().lock;
  var emailCtrl = TextEditingController();
  var passCtrl = TextEditingController();
  
  var formKey = GlobalKey<FormState>();
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  

  
  bool signInStart = false;
  bool signInComplete = false;
  String email;
  String pass;

  void lockPressed (){
    if(offsecureText == true){
      setState(() {
        offsecureText = false;
        lockIcon = LockIcon().lockOff;
        
      });
    } else {
      setState(() {
        offsecureText = true;
        lockIcon = LockIcon().lock;

      });
    }
  }



 

  handleSignInwithemailPassword () async{
    final InternetBloc ib = Provider.of<InternetBloc>(context, listen: false );
    final SignInBloc sb = Provider.of<SignInBloc>(context, listen: false );
    await ib.checkInternet();
    if (formKey.currentState.validate()){
      formKey.currentState.save();
      FocusScope.of(context).requestFocus(new FocusNode());

      await ib.checkInternet();
      if(ib.hasInternet == false){
          openSnacbar(_scaffoldKey, 'No Internet' );
        }else{
          setState(() {
            signInStart = true;
          });
          sb.signInwithEmailPassword(email, pass).then((_)async{
            if(sb.hasError == false){
              
              sb.getUserDatafromFirebase(sb.uid)
              .then((value) => sb.guestSignout())
              .then((value) => sb.saveDataToSP()
              .then((value) => sb.setSignIn()
              .then((value){
                setState(() {
                  signInComplete = true;
                });
                afterSignIn();
              })));
            } else{
              setState(() {
                signInStart = false;
              });
              openSnacbar(_scaffoldKey, sb.errorCode);
            }
          });
          
        }
    }
  }


  afterSignIn (){
    if(widget.tag == null){
      nextScreenReplace(context, DonePage());
    }else{
      Navigator.pop(context);
    }
    
  }


  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: Form(
            key: formKey,
            child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 0),
            child: ListView(
              children: <Widget>[
                
                SizedBox(height: 20,),
                Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  child: IconButton(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(0),
                    icon: Icon(Icons.keyboard_backspace), 
                    onPressed: (){
                      Navigator.pop(context, WelcomePage());
                    }),
                ),
                Text('Sign In', style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.w900
                )) ,
                Text('Follow the simple steps', style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w500,
                )) ,
                SizedBox(
                  height: 80,
                ),
                
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'username@mail.com',
                    labelText: 'Email'
                  
                    
                  ),
                  controller: emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  validator: (String value){
                    if (value.length == 0) return "Email can't be empty";
                    return null;
                  },
                  onChanged: (String value){
                    setState(() {
                      email = value;
                    });
                  },
                ),
                SizedBox(height: 20,),
                
                TextFormField(
                  obscureText: offsecureText,
                  controller: passCtrl,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter Password',
                    //prefixIcon: Icon(Icons.vpn_key),
                    suffixIcon: IconButton(icon: lockIcon, onPressed: (){
                      lockPressed();
                    }),
                    
                    
                  ),
                 

                  validator: (String value){
                    if (value.length == 0) return "Password can't be empty";
                    return null;
                  },
                  onChanged: (String value){
                    setState(() {
                      pass = value;
                    });
                  },
                ),
                
                

                SizedBox(height: 50,),
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: Text('Forgot password?', style: TextStyle(
                      color: Theme.of(context).primaryColor
                    ),) ,
                    onPressed: (){
                      //nextScreen(context, ForgotPasswordPage());
                      Navigator.push(context, CupertinoPageRoute(builder: (context) => ForgotPasswordPage()));
                    }, 

                    
                    ),
                ),

                Container(
                  height: 45,
                  child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith((states) => Theme.of(context).primaryColor)
                        ),
                        child: signInStart == false 
                      ? Text('Sign In', style: TextStyle(fontSize: 16, color: Colors.white)) 
                      : signInComplete == false 
                      ? CircularProgressIndicator(backgroundColor: Colors.white,)
                      : Text('Sign in successful!', style: TextStyle(fontSize: 16, color: Colors.white)) ,
                        onPressed: (){
                         handleSignInwithemailPassword();
                      }),
                ),
                
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Don't have an account?") ,
                    TextButton(
                      child: Text('Sign up', style: TextStyle(color: Theme.of(context).primaryColor)) ,
                      onPressed: (){
                        nextScreenReplace(context, SignUpPage());
                      },
                    )
                  ],
                ),
                SizedBox(height: 50,),
                
              ],
            ),
          ),
        )
      
    );
  }

}