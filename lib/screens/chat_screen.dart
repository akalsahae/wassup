

import 'package:flutter/material.dart';
import 'package:watsapp/contants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
bool user=false;

class ChatScreen extends StatefulWidget {
  static String id='static_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}


class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check();
  }
   final messagetextcontroller=TextEditingController();

  var chamt='';
  final _auth=FirebaseAuth.instance;
  final _firestore=FirebaseFirestore.instance;
  void check()async
  {
   final val=await _auth.currentUser;
   if(val!=null)
     {
       print(val.email);
     }
  }

 /* void getmessages()async
  {
    final messages=await _firestore.collection('messages').get();
    for (var dat in messages.docs)
      print(dat.data);
  }
*/

  void messagestream()async
  {
    await for (var messages in _firestore.collection('messages').snapshots())
      {
        for (var dat in messages.docs) {
          print(dat.data);
        }
      }
  }




  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
               // messagestream();


                _auth.signOut();
                Navigator.pop(context);


              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>
              (stream: _firestore.collection('messages').snapshots(),
                builder:(context,snapshot){
                if(!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.lightBlueAccent,
                  ),
                  );
                }
                  final messages = snapshot.data!.docs.reversed;
                  List<messagebutton> messagesreader=[];
                  for(var damta in messages) {
                    final texmt = damta.get('text');
                    final sender = damta.get('sender');


                    final messagewidget = messagebutton(texmt, sender,_auth.currentUser!.email==sender);
                    messagesreader.add(messagewidget);
                  }

                return Expanded(
                  child: ListView(
                    reverse: true,
                    padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 10.0),
                    children: messagesreader,
                  ),
                );

                },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messagetextcontroller,
                      onChanged: (value) {
                        chamt=value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: ()async {
                      messagetextcontroller.clear();
                      final aw;
                      final val=await _auth.currentUser;
                      if(val!=null)
                        {
                          aw=val.email;
                        }
                      else aw=null;
                      _firestore.collection('messages').add({
                        'text':chamt,
                        'sender':aw,


                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class messagebutton extends StatelessWidget {
  messagebutton(this.texmt,this.sender,this.isme);
   String texmt='';
   String sender='';
   bool isme=false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Column(
      //if(user==true{
      crossAxisAlignment: isme==true?CrossAxisAlignment.end:CrossAxisAlignment.start,
  //    }
        children: [
          Text(sender,
            style: TextStyle(
              fontSize: 10,
              color: Colors.black54,
            ),
          ),
          Material(
            elevation: 5,
            borderRadius: isme==true?BorderRadius.only(bottomLeft: Radius.circular(30),topLeft: Radius.circular(30),bottomRight: Radius.circular(30)):BorderRadius.only(bottomLeft: Radius.circular(30),topRight: Radius.circular(30),bottomRight: Radius.circular(30)),

            color: isme==true?Colors.lightBlueAccent:Colors.grey,
            child: Padding(
              padding:  EdgeInsets.all(12.0),
              child: Text(texmt,
                  style:TextStyle(
                    color: isme==true?Colors.white:Colors.black54,
                    fontSize: 20,
                  )
              ),
            ),
          ),
        ],
      ),
    );;
  }
}
