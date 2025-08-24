class Record {
  final String patient_id;
  final DateTime date;
  final int result;
  final String units;
  final String test_name;

  Record(
      {required this.patient_id,
      required this.date,
      required this.result,
      required this.units,
      required this.test_name});
  factory Record.fromFirestore(Map<String, dynamic> data) {
    return Record(
        patient_id: data['patient_id'],
        date: data['date'],
        result: int.parse(data['result']),
        units: data['units'],
        test_name: data['test_name']);
  }
  Map<String, dynamic> toFirestore() {
    return {
      'patient_id': patient_id,
      'date': date,
      'result': result,
      'units': units,
      'test_name': test_name
    };
  }
}
