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
String spo2level = "??";
String pulse = "??";
String lastUpdated = "??";

class Spo2App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Spo2Page(),
    );
  }
}

final FirestoreService firestoreService = FirestoreService();
final FirestoreServiceRecords firestoreRecords = FirestoreServiceRecords();

class Spo2Page extends StatefulWidget {
  @override
  _Spo2PageState createState() => _Spo2PageState();
}

class _Spo2PageState extends State<Spo2Page> {
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
      if (user != null) {
        setState(() {
          name = user.name;
        });
      }
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
                backgroundImage: AssetImage(
                    'assets/logo.jpg'), // Add your profile image here
              ),
              title: Text(name),
            ),
            SizedBox(height: 10),
            Text(
              "Oxygen Level",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              spo2level,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              "Pulse",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              pulse,
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
                        snapshot.data!.contains("Heart rate:")) {
                      if (count > 4) {
                        data = "";
                        count = 0;
                      }
                      currentData = snapshot.data!;
                      currentData = currentData.substring(
                          0, currentData.indexOf(" / Resistence"));
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

                      if (currentData.contains("Heart rate:")) {
                        setState(() {
                          pulse = currentData.substring(
                              currentData.indexOf("Heart rate:") + 11,
                              currentData.indexOf("bpm") - 3); //Removing .00
                        });
                      }
                      if (currentData.contains("SpO2:")) {
                        setState(() {
                          spo2level = currentData.substring(
                              currentData.indexOf("SpO2:") + 5,
                              currentData.indexOf("%") + 1); //adding % sign
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
                          int.parse(pulse),
                          "bpm",
                          "Pulse");
                      firestoreRecords.addRecord(
                          global.user_id,
                          DateTime.parse(lastUpdated),
                          int.parse(
                              spo2level.substring(0, spo2level.length - 1)),
                          "%",
                          "SpO2");
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
