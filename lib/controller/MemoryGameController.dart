// ignore_for_file: file_names

import 'package:get/get.dart';

import '../data/datasource/static/items_DragDrop_list.dart';
import '../data/model/DragDrop_model.dart';

class MemoryGameController extends GetxController {
  var score = 0.obs;
  var tries = 0.obs;
  var answerUser = false.obs;

  scorePls() {
    score += 10;
    update();
  }

  scoreMinus() {
    score -= 5;
    update();
  }
}
