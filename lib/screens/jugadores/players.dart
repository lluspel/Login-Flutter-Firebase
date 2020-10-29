import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_firebase/models/players.dart';
import 'package:hello_firebase/screens/jugadores/players_list.dart';
import 'package:hello_firebase/services/database.dart';
import 'package:provider/provider.dart';

class Players extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Player>>.value(
      value: DatabaseService().players,
      child: Scaffold(
        appBar: AppBar(
          title: Text('JUGADORES'),
          backgroundColor: Color(0xff028090),
          elevation: 0.0,
        ),
        body: PlayerList(),
      ),      
    );
  }
}