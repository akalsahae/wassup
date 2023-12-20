
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:watsapp/screens/login_screen.dart';
import 'package:watsapp/screens/registeration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WelcomeScreen extends StatefulWidget {
  static String id ='welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {

   Color x=Colors.white;
    @override
  void initState() {
    // TODO: implement initState
    super.initState();


    AnimationController controller=AnimationController(vsync: this,
      duration: Duration(seconds: 2),
      upperBound: 1
    );


    Animation animation=ColorTween(begin: Colors.blueGrey,end:Colors.white).animate(controller);


    controller.forward();

    controller.addListener(() {
      setState(() {
        x=animation.value;
      });
      print(controller.value);
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: x,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 70,
                  ),
                ),
               AnimatedTextKit(
               animatedTexts:[ TypewriterAnimatedText(
                 'Flash Chat',
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                 speed: const Duration(milliseconds: 50),
                ),],
                 totalRepeatCount: 1,),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Material(
            elevation: 5.0,
            color: Colors.blue,

            borderRadius: BorderRadius.circular(30.0),
            child: MaterialButton(

              onPressed:() async{

                 Navigator.pushNamed(context, LoginScreen.id);
              },
              minWidth: 200.0,
              height: 42.0,
              child: Text(
                'Log In',
              ),
            ),
          ),
        ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RegistrationScreen.id);

                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Register',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

