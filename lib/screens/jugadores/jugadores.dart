import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Jugadores extends StatefulWidget {
  @override
  _JugadoresState createState() => _JugadoresState();
}

class _JugadoresState extends State<Jugadores> {
  
  double _height = 60;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jugadores'),
        backgroundColor: Color(0xff028090),
        elevation: 0.0,
      ),
      body:
        _buildBody(context),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0,),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add),
        backgroundColor: Color(0xff028090),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
  
  Widget _buildBody(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('jugadores').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();

          return _buildList(context, snapshot.data.documents);
        },
      ),
    );
    
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.nombre),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5.0),
        ),
        height: _height,
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.person),
              title: Text(record.nombre),
              trailing: Text(record.pBuenos.toString()),
              onTap: (){
                setState(() {
                  if (_height == 60) _height = 300;
                  else _height = 60;
                });
              },
            ),
          ]
        )
      ),
    );
  }
}

class Record {
  final String nombre;
  final int pMalos;
  final int pBuenos;
  //final int dheight;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
    : assert(map['nombre'] != null),
      assert(map['pBuenos'] != null),
      assert(map['pMalos'] != null),
      assert(map['dheight'] != null),
      nombre = map['nombre'],
      pBuenos = map['pBuenos'] + map['pMalos'],
      pMalos = map['pMalos'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
    : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$nombre:$pBuenos>";
}





/*

import 'package:flutter/material.dart';

void main() => runApp(AnimatedContainerApp());

class AnimatedContainerApp extends StatefulWidget {
  @override
  _AnimatedContainerAppState createState() => _AnimatedContainerAppState();
}

class _AnimatedContainerAppState extends State<AnimatedContainerApp> {
  // Define the various properties with default values. Update these properties
  // when the user taps a FloatingActionButton.
  double _height = 60;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('AnimatedContainer Demo'),
        ),
        body: Center(
          child: AnimatedContainer(
            // Use the properties stored in the State class.
            width: 200,
            height: _height,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5.0),
            ),
            // Define how long the animation should take.
            duration: Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            child:ListTile(
              title: Text("hola"),
              onTap: (){
                  setState(() {
                    if (_height == 60) _height = 200;
                    else _height = 60;
                  });
              },
            ),
          ),
        ),
      ),
    );
  }
}
*/