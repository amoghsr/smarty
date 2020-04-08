import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:provider/provider.dart';

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
    return Provider<DoneListening>(
      create: (context) => DoneListening(),
      child: IconButton(
          icon: Icon(
            Icons.mic,
            color: Colors.white,
            semanticLabel: 'Notifcations',
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return Consumer<DoneListening>(
                      builder: (context, DoneListening, child) {
                    return StatefulBuilder(builder: (context, setState) {
                      while (!DoneListening.getVal() == true) {
                        Future.delayed(Duration(seconds: 3), () {
                          Navigator.of(context).pop(true);
                        });
                      }
                      DoneListening.setVal(false);
                      // Future.delayed(Duration(seconds: 3), () {
                      //   Navigator.of(context).pop(true);
                      // });

                      return AlertDialog(
                        title: VoiceAgent(),
                        backgroundColor: Colors.transparent,
                      );
                    });
                  });
                });
// ;          VoiceAgent();
          }),
    );
  }
}

class VoiceAgent extends StatefulWidget {
  @override
  // bool done;
  // VoiceAgent(
  //     {@required this.done});
  _VoiceAgentState createState() => _VoiceAgentState();
}

class _VoiceAgentState extends State<VoiceAgent> {
  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;

  String resultText = "";

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
    // done = true;
    // return done;
  }

  @override
  Widget build(BuildContext context) {
    listen();
    DoneListening().setVal(true);

    return Container(
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
    );
  }
}
