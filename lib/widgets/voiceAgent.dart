import 'package:flutter/material.dart';
import 'package:speech_recognition/speech_recognition.dart';

class DoneListening {
  bool done = false;

  void setVal(bool b) {
    done = b;
    print(done);
  }

  bool getVal() {
    return done;
  }
}

class MicClass extends StatefulWidget {
  @override
  _MicClassState createState() => _MicClassState();
}

class _MicClassState extends State<MicClass> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.mic,
          color: Colors.white,
          semanticLabel: 'Notifcations',
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return VoiceAgent();
              });
        });
  }
}

class VoiceAgent extends StatefulWidget {
  @override
  _VoiceAgentState createState() => _VoiceAgentState();
}

class _VoiceAgentState extends State<VoiceAgent> {
  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;

  String resultText = "";
  List<String> exclude_list = [
    "Living_Room Exhaust_Fan",
    "Living_Room Water_Heater",
    "Living_Room Faucet",
    "Living_Room Refrigerator",
    "Living_Room Baby_Monitor",
    "Bedroom Exhaust_Fan",
    "Bedroom Water_Heater",
    "Bedroom Faucet",
    "Bedroom Refrigerator",
    "Bathroom Refrigerator",
    "Bathroom Baby_Monitor",
    "Bathroom AC",
    "Bathroom TV",
    "Bathroom Speaker",
    "Playroom Exhaust_Fan",
    "Playroom Faucet",
    "Playroom Refrigerator",
    "Playroom Water_Heater",
    "Kitchen Baby_Monitor",
    "Kitchen TV",
    "Kitchen Speaker"
  ];

  Map<String, String> resultMap = {};

  @override
  void initState() {
    super.initState();
    initSpeechRecognizer();
  }

  void initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();

    _speechRecognition.setAvailabilityHandler(
      (bool result) => setState(() => _isAvailable = result),
    );

    _speechRecognition.setRecognitionStartedHandler(
      () => setState(() => _isListening = true),
    );

    _speechRecognition.setRecognitionResultHandler(
      (String speech) => setState(() => resultText = speech),
    );

    _speechRecognition.setRecognitionCompleteHandler(
      () => setState(() => _isListening = false),
    );

    _speechRecognition.activate().then(
          (result) => setState(() => _isAvailable = result),
        );
  }

  void listen() {
    if (_isAvailable && !_isListening)
      _speechRecognition
          .listen(locale: "en_US")
          .then((result) => print('test test test $result'));
  }

  @override
  Widget build(BuildContext context) {
    listen();

    if (resultText.toLowerCase().contains("on") &&
        resultText.toLowerCase().contains("living room") &&
        (resultText.toLowerCase().contains("lamp") ||
        resultText.toLowerCase().contains("light"))) {
      resultMap["State"] = "ON";
      resultMap["Room"] = "Living Room";
      resultMap["Device"] = "Lamp";
    }
    print(resultMap);
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(6.0),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 12.0,
          ),
          child: Text(
            resultText,
            style: TextStyle(fontSize: 24.0),
          ),
        ),
        backgroundColor: Colors.transparent,
      );
    });
  }
}
