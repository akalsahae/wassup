import 'package:flutter/material.dart';
import 'package:watsapp/screens/welcome_screen.dart';
import 'package:watsapp/screens/login_screen.dart';
import 'package:watsapp/screens/registeration_screen.dart';
import 'package:watsapp/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await  Firebase.initializeApp();
  runApp(FlashChat());
}
class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //theme: ThemeData.dark(),//.copyWith(
       // textTheme: TextTheme(
        //  bodyText1: TextStyle(color: Colors.black54),
       // ),
      //),
      initialRoute: WelcomeScreen.id,
      routes: {
        ChatScreen.id:(context)=>ChatScreen(),
        LoginScreen.id:(context)=>LoginScreen(),
        RegistrationScreen.id :(context)=>RegistrationScreen(),
        WelcomeScreen.id:(context)=>WelcomeScreen(),
      },
    );
  }
}
