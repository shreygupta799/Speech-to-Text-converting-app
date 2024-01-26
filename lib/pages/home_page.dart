import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SpeechToText _speechToText = SpeechToText();

  bool _speechEnabled = false;
  String _wordsSpoken = "";
  double _confidenceLevel = 0;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {
      _confidenceLevel = 0;
    });
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _wordsSpoken = "${result.recognizedWords}";
      _confidenceLevel = result.confidence;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Speech to text demo"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              child: Text(
                _speechToText.isListening
                    ? 'Listening...'
                    : _speechEnabled
                        ? 'Tap the microphone to start listening'
                        : 'Speech not available',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.all(8),
              child: Text(_wordsSpoken),
            )),
            if (_speechToText.isNotListening && _confidenceLevel > 0)
              Text(
                "Confidence: ${(_confidenceLevel * 100).toStringAsFixed(1)}%",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w200),
              )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed:
              _speechToText.isListening ? _stopListening : _startListening,
          tooltip: 'Listen',
          child: Icon(_speechToText.isListening ? Icons.mic_off : Icons.mic),
          backgroundColor: Colors.red),
    );
  }
}
