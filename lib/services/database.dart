import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_firebase/models/players.dart';
import 'package:hello_firebase/screens/jugadores/players.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  final CollectionReference playersCollections = Firestore.instance.collection('players');

  Future updateUserData(String name, int pases) async {
    return await playersCollections.document(uid).setData({
      'name': name,
      'pases': pases,
    });
  }
  
  // player list
  List<Player> _playerListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      return Player(
        name: doc.data['name'] ?? '',
        pases: doc.data['pases'] ?? 0
      );
    }).toList();
  }

  Stream<List<Player>> get players{
    return playersCollections.snapshots()
    .map(_playerListFromSnapshot);  
  }


}