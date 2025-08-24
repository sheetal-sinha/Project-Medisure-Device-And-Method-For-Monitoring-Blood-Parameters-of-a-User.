import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medisure/recordmodel.dart';

class FirestoreServiceRecords {
  final CollectionReference recordsCollection =
      FirebaseFirestore.instance.collection('/records');

  Future<void> addRecord(String patient_id, DateTime date, int result,
      String units, String test_name) {
    return recordsCollection.add({
      'patient_id': patient_id,
      'date': date,
      'result': result,
      'units': units,
      'test_name': test_name,
    });
  }

  Stream<QuerySnapshot> getRecordStreamByPatientId(String email) {
    debugPrint("In getrecord function with email: $email");
    try {
      var query = recordsCollection.where('patient_id', isEqualTo: email);
      var stream = query.snapshots();
      debugPrint("Stream created successfully ");
      return stream;
    } catch (e) {
      debugPrint("Error in query: $e");
      return Stream.empty();
    }
  }

  Future<void> updateRecord(String patient_id, DateTime date, int result,
      String units, String test_name) {
    return recordsCollection.doc(patient_id).update({
      'patient_id': patient_id,
      'date': date,
      'result': result,
      'units': units,
      'test_name': test_name
    });
  }

  Future<void> deleteRecord(String patient_id) {
    return recordsCollection.doc(patient_id).delete();
  }

  Future<Record> getRecords(String patient_id) async {
    try {
      DocumentSnapshot doc = await recordsCollection.doc(patient_id).get();
      print(doc.get("result"));
      if (doc.exists) {
        return Record.fromFirestore(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print(e);
    }
    return Record(
      patient_id: patient_id,
      date: DateTime(2024),
      result: 0,
      units: "",
      test_name: "",
    );
  }
}
