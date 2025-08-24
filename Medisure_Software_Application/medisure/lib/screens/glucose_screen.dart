import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:medisure/uihelper.dart';
import 'package:usb_serial/usb_serial.dart';
import 'package:medisure/firestore.dart';
import 'package:medisure/usermodel.dart';
import 'package:medisure/globals.dart';
import 'package:medisure/firestore_record.dart';

UsbPort? port;

Stream<String> getStream() {
  StreamController<String> sc = StreamController<String>();
  connect(sc);
  return sc.stream;
}

Future<void> connect(StreamSink<String> inputDataSink) async {
  // inputDataSink.add('Finding devices...');
  List<UsbDevice> devices = await UsbSerial.listDevices();

  if (devices.isEmpty) {
    inputDataSink.add('Error: No UART devices');
    return;
  }
//  inputDataSink.add('Found ${devices[0]}, creating a port...');
  // UsbPort? port = devices[0].port ?? await devices[0].create();
  port = await devices[0].create();

  if (port == null) {
    inputDataSink.add('Error: Failed to create a virtual UART port');
    return;
  } else {
    inputDataSink.add('Opening port $port');
    bool openResult = await port!.open();
    if (!openResult) {
      inputDataSink.add('Error: Failed to open a virtuial UART port');
      return;
    }

    await port!.setDTR(true);
    await port!.setRTS(true);

    port!.setPortParameters(
        9600, UsbPort.DATABITS_8, UsbPort.STOPBITS_1, UsbPort.PARITY_NONE);

    inputDataSink.add('Connected, here comes the data:');

    inputDataSink.addStream(port!.inputStream!
        .cast<List<int>>()
        .transform(const AsciiDecoder())
        .transform(const LineSplitter()));
  }
}

String data = '';
String currentData = '';
int count = 0;
String name = "User";
String bloodGlucoselevel = "??";
String lastUpdated = "??";
String photoUrl = '';
class BloodGlucose extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BloodGlucosePage(),
    );
  }
}

final FirestoreService firestoreService = FirestoreService();
final FirestoreServiceRecords firestoreRecords = FirestoreServiceRecords();

class BloodGlucosePage extends StatefulWidget {
  @override
  _BloodGlucosePageState createState() => _BloodGlucosePageState();
}

class _BloodGlucosePageState extends State<BloodGlucosePage> {
  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  @override
  void dispose() {
    super.dispose();
    port!.close();
  }

  Future<void> fetchUserName() async {
    try {
      User user = await firestoreService.getUser(global.user_id);
        setState(() {
          name = user.name;
          photoUrl = user.photoUrl;
        });
    } catch (e) {
      print('Error fetching user name: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: photoUrl.isNotEmpty
                    ? NetworkImage(photoUrl)
                    : const AssetImage('assets/logo.jpg') as ImageProvider, 
              ),
              title: Text(name),
            ),
            SizedBox(height: 10),
            Text(
              "Blood Glucose",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              bloodGlucoselevel,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              "Last Updated on",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              lastUpdated,
              style: TextStyle(fontSize: 16),
            ),
            Spacer(),
            SizedBox(height: 10),
            Text(
              "Device Data",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: StreamBuilder(
                  stream: getStream(),
                  builder: (context, snapshot) {
                    //Heart rate:87.25bpm / Spo2:95% / Resistence:24.75Ohms
                    if (snapshot.data != null &&
                        snapshot.data!.contains("Resistence")) {
                      if (count > 4) {
                        data = "";
                        count = 0;
                      }
                      currentData = snapshot.data!;
                      currentData = "Reading:" +
                          currentData.substring(
                              currentData.indexOf(" / Resistence") + 13,
                              currentData.length - 4);
                      data += '$currentData\n';
                      count++;
                    }
                    return Text(data);
                  }),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Add refresh data functionality here
                      if (currentData.contains("Reading:")) {
                        setState(() {
                          var readingInt = int.parse(currentData.substring(
                              currentData.indexOf("Reading:") + 8,
                              currentData.length - 3));
                          bloodGlucoselevel =
                              (readingInt / 425).round().toString();
                          DateTime now = DateTime.now();
                          lastUpdated = DateTime(now.year, now.month, now.day,
                                  now.hour, now.minute, now.second)
                              .toString();
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text("Refresh Data"),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      firestoreRecords.addRecord(
                          global.user_id,
                          DateTime.parse(lastUpdated),
                          int.parse(bloodGlucoselevel),
                          "mg/dl",
                          "Blood Glucose");
                      UiHelper.CustomAlertBox(context, "Data Saved");
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: BorderSide(color: Colors.red),
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text("Save Data"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
