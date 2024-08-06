// ignore_for_file: library_private_types_in_public_api, file_names
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter/services.dart' show rootBundle;

import '../../controller/FloatingController.dart';
import '../../data/datasource/bg_data.dart';
import '../widget/custom_card_search.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FloatingController controller1 =
      Get.put(FloatingController(), permanent: true);
  List<dynamic> _searchResults = [];
  bool _isListening = false;
  bool _isLoading = true; // Added loading indicator
  late stt.SpeechToText _speech;
  late FlutterTts _flutterTts;
  late List<dynamic> _jsonData; // Store loaded JSON data

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _flutterTts = FlutterTts();
    _loadJson(); // Load JSON data on init
  }

  Future<void> _loadJson() async {
    String jsonString = await rootBundle.loadString('assets/data.json');
    _jsonData = json.decode(jsonString);
    setState(() {
      _isLoading = false; // Set loading to false after data is loaded
    });
  }

  void _search(String query) {
    List<dynamic> results = _jsonData
        .where((item) => item['title']
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();
    setState(() {
      _searchResults = results;
    });
  }

  void _startListening() async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() => _isListening = true);
      _speech.listen(onResult: (val) {
        setState(() {
          _searchController.text = val.recognizedWords;
          _search(val.recognizedWords);
        });
      });
    }
  }

  void _stopListening() {
    setState(() => _isListening = false);
    _speech.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'صفحة البحث',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(bgList[controller1.selectedIndex]),
              fit: BoxFit.fill,
            ),
          ),
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator()) // Show loading indicator
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _searchController,
                        onChanged: _search,
                        decoration: InputDecoration(
                          labelText: 'بحث',
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: IconButton(
                            icon:
                                Icon(_isListening ? Icons.mic : Icons.mic_none),
                            onPressed:
                                _isListening ? _stopListening : _startListening,
                          ),
                        ),
                      ),
                    ),
                    CustomSearchResults(
                        searchResults: _searchResults, flutterTts: _flutterTts),
                  ],
                ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _speech.stop();
    _flutterTts.stop();
    super.dispose();
  }
}
