import 'package:flutter/material.dart';
import 'package:hello_firebase/models/players.dart';
import 'package:provider/provider.dart';

class PlayerList extends StatefulWidget {
  @override
  _PlayerListState createState() => _PlayerListState();
}

class _PlayerListState extends State<PlayerList>{

  @override
  Widget build(BuildContext context) {
    final players = Provider.of<List<Player>>(context);

    players.forEach((player) {
      print(player.name);
      print(player.pases);
    });

    return Container(
    );
  }
}