import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:campus_locate_me/blocs/notification_bloc.dart';
import 'package:campus_locate_me/pages/edit_profile.dart';
import 'package:campus_locate_me/pages/welcome.dart';
import 'package:campus_locate_me/widgets/developer.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../blocs/sign_in_bloc.dart';
import '../config/config.dart';
import '../utils/next_screen.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with AutomaticKeepAliveClientMixin{



  


  openAboutDialog (){
    final sb = context.read<SignInBloc>();
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AboutDialog(
          applicationName: Config().appName,
          applicationIcon: Image(image: AssetImage(Config().splashIcon), height: 30, width: 30,),
          applicationVersion: sb.appVersion,
        );
      }
    );
  }





  @override
  Widget build(BuildContext context) {
    super.build(context);
    final sb = context.watch<SignInBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: false,
        
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(15, 20, 20, 50),
        children: [
          sb.guestUser == true ? GuestUserUI() : UserUI(),

          Text("Settings", style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600
          ),),

          
          
          SizedBox(height: 15,),
          Divider(height: 3,),
          ListTile(
            title: Text('Get Notifications'),
            leading: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
                borderRadius: BorderRadius.circular(5)
              ),
              child: Icon(LineIcons.bell, size: 22, color: Colors.white),
            ),
            trailing:  Switch(
                activeColor: Theme.of(context).primaryColor,
                value: context.watch<NotificationBloc>().subscribed,
                onChanged: (bool) {
                  context.read<NotificationBloc>().fcmSubscribe(bool);
                }),
          ),
          Divider(height: 3,),
          ListTile(
            title: Text('Contact Us'),
            leading: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(5)
              ),
              child: Icon(Feather.mail, size: 20, color: Colors.white),
            ),
            trailing: Icon(Feather.chevron_right, size: 20,),
            onTap: ()async=> await launch('mailto:${Config().supportEmail}?subject=About ${Config().appName} App&body='),
          ),
          Divider(height: 3,),
          ListTile(
            title: Text('About Us'),
            leading: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(5)
              ),
              child: Icon(Feather.info, size: 20, color: Colors.white),
            ),
            trailing: Icon(Feather.chevron_right, size: 20,),
              onTap: ()=> nextScreenPopup(context, AboutPopup()),
            ),
        ],
      )
      
      
    );
  }

  

  @override
  bool get wantKeepAlive => true;
}





class GuestUserUI extends StatelessWidget {
  const GuestUserUI({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
            title: Text('Login'),
            leading: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(5)
              ),
              child: Icon(Feather.user, size: 20, color: Colors.white),
            ),
            trailing: Icon(Feather.chevron_right, size: 20,),
            onTap: ()=> nextScreenPopup(context, WelcomePage(tag: 'popup',)),
          ),
        SizedBox(height: 20,),
      ],
    );
  }
}


class UserUI extends StatelessWidget {
  const UserUI({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sb = context.watch<SignInBloc>();
    return Column(
      children: [
        Container(
          height: 200,
          child: Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey[300],
                backgroundImage: CachedNetworkImageProvider(sb.imageUrl)
              ),
              SizedBox(height: 15,),
              Text(sb.name, style: TextStyle(
                fontSize: 22, 
                fontWeight: FontWeight.bold
              ),)
            ],
          ),
        ),

        ListTile(
            title: Text(sb.email),
            leading: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(5)
              ),
              child: Icon(Feather.mail, size: 20, color: Colors.white),
            ),
          ),
          Divider(height: 3,),

          

          ListTile(
            title: Text('Edit Profile'),
            leading: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Colors.purpleAccent,
                borderRadius: BorderRadius.circular(5)
              ),
              child: Icon(Feather.edit_3, size: 20, color: Colors.white),
            ),
            trailing: Icon(Feather.chevron_right, size: 20,),
            onTap: ()=> nextScreen(context, EditProfile(name: sb.name, imageUrl: sb.imageUrl))
          ),

          Divider(height: 3,),

          ListTile(
            title: Text('Logout'),
            leading: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(5)
              ),
              child: Icon(Feather.log_out, size: 20, color: Colors.white),
            ),
            trailing: Icon(Feather.chevron_right, size: 20,),
            onTap: ()=> openLogoutDialog(context),
          ),



          SizedBox(height: 15,)
        

      ],
    );
  }


  void openLogoutDialog (context) {
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Please Confirm, Are you sure you want to log out?'),
          actions: [
            TextButton(
              child: Text('No'),
              onPressed: ()=> Navigator.pop(context),
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: ()async{
                Navigator.pop(context);
                await context.read<SignInBloc>().userSignout()
                .then((value) => context.read<SignInBloc>().afterUserSignOut());

                  nextScreenCloseOthers(context, WelcomePage());
                
              },
            )
          ],
        );
      }
    );
  }
}