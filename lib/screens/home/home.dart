import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_firebase/screens/jugadores/jugadores.dart';
import 'package:hello_firebase/screens/jugadores/players.dart';
import 'package:hello_firebase/services/auth.dart';


class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TRACK UR ULTIMATE'),
        backgroundColor: Color(0xff028090),
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            textColor: Color(0xffFFFFFF),
            icon: Icon(Icons.person), 
            label: Text('LOG OUT'),
            onPressed: () async {
              await _auth.signOut();
            }, 
          )
        ],
      ),
      
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 250.0,
              height: 250.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/image_buttons/Torneos.png'),
                ),
              ),
              child: FlatButton(
                padding: EdgeInsets.all(0.0),
                onPressed: () {
                  Navigator.push(
                    context, 
                    CupertinoPageRoute(builder: (context) => Players())
                  );
                }, child: null,
              ),
            ),
            const SizedBox(height: 50),
            Container(
              width: 250.0,
              height: 250.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/image_buttons/Jugadores.png'),
                ),
              ),
              child: FlatButton(
                padding: EdgeInsets.all(0.0),
                onPressed: () {
                  Navigator.push(
                    context, 
                    CupertinoPageRoute(builder: (context) => Jugadores())
                  );
                }, child: null,
              ),
            ),
          ],
        ),
      ), 
    );
  }
}