import 'package:flutter/material.dart';
import 'package:tip_off/models/report.dart';

class ReportTile extends StatelessWidget {

  final Report report;
  ReportTile({this.report});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          contentPadding: EdgeInsets.all( 8.0),
          leading: Icon(Icons.report, color: Colors.red, size: 50.0),
          title: Text(report.type),
          subtitle: Text(report.description),
        ),
      ),
    );
  }
}