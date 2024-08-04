// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:gif/gif.dart';

import '../../core/constant/AppColor.dart';

class CustomSearchResults extends StatefulWidget {
  const CustomSearchResults(
      {required this.searchResults, required this.flutterTts, super.key});
  final List<dynamic> searchResults;
  final FlutterTts flutterTts;

  @override
  State<CustomSearchResults> createState() => _CustomSearchResultsState();
}

class _CustomSearchResultsState extends State<CustomSearchResults>
    with TickerProviderStateMixin {
  late GifController gifController;

  @override
  void initState() {
    super.initState();
    gifController = GifController(vsync: this);
  }

  @override
  void dispose() {
    gifController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: widget.searchResults.length,
          itemBuilder: (context, index) {
            var result = widget.searchResults[index];
            return InkWell(
              onTap: () {
                widget.flutterTts.setLanguage('AR');
                widget.flutterTts.speak(result['title']);
              },
              child: Card(
                elevation: 0.2,
                color: AppColor.white.withOpacity(0.9),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  height: 170,
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Gif(
                            controller: gifController,
                            autostart: Autostart.loop,
                            image: NetworkImage(result['imageSign']),
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(result['image']),
                                Text(result['title']),
                              ]),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            icon: const Icon(Icons.play_arrow),
                            onPressed: () {
                              widget.flutterTts.setLanguage('AR');
                              widget.flutterTts.speak(result['title']);
                            },
                          ),
                        ),
                      ]),
                ),
              ),
            );
          }),
    );
  }
}
