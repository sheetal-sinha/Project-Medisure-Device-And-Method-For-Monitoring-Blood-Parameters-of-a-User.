import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medisure/firestore_record.dart';
import 'package:medisure/globals.dart';
import 'package:medisure/recordmodel.dart';

class PastRecords extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PastRecordsPage(),
    );
  }
}

FirestoreServiceRecords firestoreServiceRecords = FirestoreServiceRecords();

class PastRecordsPage extends StatefulWidget {
  @override
  _PastRecordsPageState createState() => _PastRecordsPageState();
}

class _PastRecordsPageState extends State<PastRecordsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Past Records'),
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: firestoreServiceRecords
                    .getRecordStreamByPatientId(global.user_id),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Something went wrong'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final List<Record> records = snapshot.data!.docs.map((doc) {
                    debugPrint("In record function");
                    return Record(
                      patient_id: doc['patient_id'],
                      date: (doc['date']).toDate(),
                      result: doc['result'],
                      units: doc['units'],
                      test_name: doc['test_name'],
                    );
                  }).toList();

                  return ListView.builder(
                    itemCount: records.length,
                    itemBuilder: (context, index) {
                      final record = records[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text(record.test_name),
                          subtitle: Text(
                            'Patient ID: ${record.patient_id}\n'
                            'Date: ${record.date}\n'
                            'Result: ${record.result} ${record.units}',
                          ),
                          isThreeLine: true,
                          //onTap: () {
                          // Handle on tap
                          // },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
