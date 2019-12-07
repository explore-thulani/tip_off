import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tip_off/models/report.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // Collection reference
  final CollectionReference reportCollection = Firestore.instance.collection('reports');


  Future updateUserData(String name, String type, String organisation, String description) async {
    return await reportCollection.document(uid).setData({
      'name': name,
      'type': type,
      'organisation': organisation,
      'description': description,
    });
  }

  //Report list from snapshot
  List<Report> _reportListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((document) {
      return Report(
        name: document.data['name'] ?? '',
        type: document.data['type'] ?? '',
        organisation: document.data['organisation'] ?? '',
        description: document.data['description'] ?? '',
      );
    }).toList();
  }

  //Get reports stream
  Stream<List<Report>> get reports {
    return reportCollection.snapshots()
    .map(_reportListFromSnapshot);
  }
}