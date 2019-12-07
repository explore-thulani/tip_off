import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final dummySnapshot = [
  {"name": "Filip", "organisation": "SARS", "type": "Theft", "description": "A colleague stole tax payers money"},
  {"name": "Abraham", "organisation": "Government", "type": "Hack", "description": "I've been hacked"},
  {"name": "Richard", "organisation": "Office", "type": "HiJack", "description": "My car just got Hijacked"},
  {"name": "Ike", "organisation": "SARS", "type": "Theft", "description": "A colleague stole tax payers money"},
  {"name": "Justin", "organisation": "SARS", "type": "Theft", "description": "A colleague stole tax payers money"},
];

class FirestoreTest extends StatefulWidget {
  FirestoreTest({Key key}) : super(key: key);

  @override
  _FirestoreTestState createState() => _FirestoreTestState();
}

class _FirestoreTestState extends State<FirestoreTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reports')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('reports').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Report.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.description),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(record.type),
          //title: Text(record.name),
          subtitle: Text(record.description),
          trailing: Text(record.status),
          isThreeLine: true,
          onTap: () {} /*=> Firestore.instance.runTransaction((transaction) async {
            
            final freshSnapshot = await transaction.get(record.documentReference);

            final fresh = Report.fromSnapshot(freshSnapshot);

            await transaction
                .update(record.documentReference, {'name': 'Anonymous'});
                
          }),*/
        ),
      ),
    );
  }
}

class Report {
  final String name;
  final String organisation;
  final String type;
  final String description;
  final String status;
  final DocumentReference documentReference;

  Report.fromMap(Map<String, dynamic> map, {this.documentReference})
      : assert(map['name'] != null),
        assert(map['organisation'] != null),
        assert(map['type'] != null),
        assert(map['description'] != null),
        assert(map['status'] != null),
        name = map['name'],
        organisation = map['organisation'],
        type = map['type'],
        description = map['description'],
        status = map['status'];

  Report.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, documentReference: snapshot.reference);

  @override
  String toString() => "Record<$name:$organisation:$type:$description:$status>";
}
