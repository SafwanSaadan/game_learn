// ignore_for_file: file_names

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../core/constant/AppColor.dart';
import '../../core/constant/path/Audio_Path.dart';

class ResultMessage extends StatefulWidget {
  final String message;
  final VoidCallback onTap;
  final IconData icon;
  final Color messageColor;
  final Color iconColor;
  ResultMessage(
      {required this.message,
      required this.onTap,
      required this.icon,
      required this.iconColor,
      required this.messageColor,
      super.key});

  @override
  State<ResultMessage> createState() => _ResultMessageState();
}

class _ResultMessageState extends State<ResultMessage> {
  late AudioPlayer player;
  late FlutterTts _flutterTts;

  @override
  void initState() {
    _flutterTts = FlutterTts();
    player = AudioPlayer();
    super.initState();
    audioPlay();
  }

  void audioPlay() {
    if (widget.message == 'إجابة صحيحة') {
      player.play(UrlSource(AudioPath.trueAudio));
    } else if (widget.message == "إجابة خاطئة") {
      player.play(UrlSource(AudioPath.falseAudio));
    }
    _flutterTts.setLanguage('AR');
    _flutterTts.speak(widget.message);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 200,
        color: AppColor.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              widget.message,
              style: TextStyle(fontSize: 18.0, color: widget.messageColor),
            ),
            GestureDetector(
              onTap: widget.onTap,
              child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColor.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    widget.icon,
                    color: widget.iconColor,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
