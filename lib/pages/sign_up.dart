import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:campus_locate_me/blocs/internet_bloc.dart';
import 'package:campus_locate_me/blocs/sign_in_bloc.dart';
import 'package:campus_locate_me/pages/done.dart';
import 'package:campus_locate_me/pages/sign_in.dart';
import 'package:campus_locate_me/utils/icons.dart';
import 'package:campus_locate_me/utils/next_screen.dart';
import 'package:campus_locate_me/utils/snacbar.dart';
import 'package:provider/provider.dart';



class SignUpPage extends StatefulWidget {
  final String tag;
  SignUpPage({Key key, this.tag}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  bool offsecureText = true;
  Icon lockIcon = LockIcon().lock;
  var emailCtrl = TextEditingController();
  var passCtrl = TextEditingController();
  var nameCtrl = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  



  
  String email;
  String pass;
  String name;
  bool signUpStarted = false;
  bool signUpCompleted = false;
  


  
  

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



  Future handleSignUpwithEmailPassword () async{
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
            signUpStarted = true;
          });
          sb.signUpwithEmailPassword(name, email, pass).then((_)async{
            if(sb.hasError == false){
              sb.getTimestamp()
              .then((value) => sb.saveToFirebase()
              .then((value) => sb.increaseUserCount())
              .then((value) => sb.guestSignout()
              .then((value) => sb.saveDataToSP()
              .then((value) => sb.setSignIn()
              .then((value){
                setState(() {
                  signUpCompleted = true;
                });
                afterSignUp();
              })))));
            } else{
              setState(() {
                signUpStarted = false;
              });
              openSnacbar(_scaffoldKey, sb.errorCode);
            }
          });
          
        }
    }
  }

  afterSignUp (){
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
                      Navigator.pop(context);
                    }),
                ),
                Text('Sign Up', style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.w900
                )) ,
                Text('Follow the simple steps', style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black,
                )) ,
                SizedBox(
                  height: 60,
                ),
                
                
                TextFormField(
                  controller: nameCtrl,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    hintText: 'Enter Name',
                    //prefixIcon: Icon(Icons.person)
                  ),
                  validator: (String value){
                    if (value.length == 0) return "Name can't be empty";
                    return null;
                  },
                  onChanged: (String value){
                    setState(() {
                      name = value;
                    });
                  },
                ),

                SizedBox(height: 20,),

                
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'username@mail.com',
                    labelText: 'Email Address',
                  
                    
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
                  controller: passCtrl,
                  obscureText: offsecureText,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter Password',
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
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith((states) => Theme.of(context).primaryColor)
                    ),
                    child: signUpStarted == false 
                      ? Text('Sign up', style: TextStyle(fontSize: 16, color: Colors.white),) 
                      : signUpCompleted == false 
                      ? CircularProgressIndicator(backgroundColor: Colors.white)
                      : Text('Sign up successful!', style: TextStyle(fontSize: 16, color: Colors.white)) ,
                    onPressed: (){
                     handleSignUpwithEmailPassword();
                  }),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Already have an account?') ,
                    TextButton(
                      child: Text('Sign In', style: TextStyle(color: Theme.of(context).primaryColor),) ,
                      onPressed: (){
                        if(widget.tag == null){
                          nextScreenReplace(context, SignInPage());
                        }else{
                          nextScreenReplace(context, SignInPage(tag: 'Popup',));
                        }
                        
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
