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

  Map<String, String> resultMap = {
    "State": "",
    "Room": "",
    "Device": ""
  }; //room and device

  List<String> state = ['ON', 'OFF'];
  List<String> room = [
    'Living Room',
    'Hall',
    'Bedroom',
    'Kitchen',
    'Bathroom',
    'Playroom'
  ];

  Map<String, List<String>> device = {
    'Lamp': ['Lamp', 'Light', 'Lights', 'Bulb'],
    'AC': ['AC', 'Air Conditioning', 'Air Conditioner', 'Cooler', 'Aircon'],
    'Exhaust Fan': ['Exhaust Fan', 'Fan'],
    'Speaker': ['Speaker', 'Speakers', 'Sound', 'Audio'],
    'TV': ['TV', 'Television', 'Cable', 'Monitor'],
    'Faucet': ['Faucet', 'Tap', 'Pipe', 'Water'],
    'Water Heater': ['Water Heater', 'Geyser', 'Heater']
  };
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
          .then((result) => print('$result'));
  }

  @override
  Widget build(BuildContext context) {
    listen();

    bool invalidMap = false;
    bool excluded = false;
    bool invalidText = false;

    for (int i = 0; i < state.length; i++) {
      if (resultText.toLowerCase().contains(state[i].toLowerCase()))
        resultMap["State"] = state[i];
    }

    for (int j = 0; j < room.length; j++) {
      if (resultText.toLowerCase().contains(room[j].toLowerCase()))
        resultMap["Room"] = room[j];
    }

    for (int k = 0; k < device.length; k++) {
      for (int key = 0; key < device.values.toList()[k].length; key++) {
        if (resultText
            .toLowerCase()
            .contains(device.values.toList()[k][key].toLowerCase()))
          resultMap["Device"] = device.keys.toList()[k];
      }
    }

    setState(() {
      // if ((resultMap["Room"]==null) || (resultMap["State"]==null) || (resultMap["Device"]==null)){
      //   validMap = true;
      // }
      // else{
      //   validMap = false;
      // }

      if (resultMap.containsValue("")) invalidMap = true;

      String checkExclusion = "";
      checkExclusion = resultMap["Room"].replaceAll(" ", "_") +
          " " +
          resultMap["Device"].replaceAll(" ", "_");

      if (exclude_list.contains(checkExclusion)) {
        excluded = true;
      }

      // if (resultMap.keys.length != 3) invalidMap == true;

      if (invalidMap == true) {
        // resultMap = {};
        invalidText = true;
      }

      print(invalidText);

      print("RESULT MAP: $resultMap");
    });

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
          child: (invalidText == false)
              ? Text(
                  resultText,
                  style: TextStyle(fontSize: 24.0, color: Colors.green),
                )
              : Text(
                  resultText,
                  style: TextStyle(fontSize: 24.0, color: Colors.red),
                ),
        ),
        backgroundColor: Colors.transparent,
      );
    });
  }
}
