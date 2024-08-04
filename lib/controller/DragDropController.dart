// ignore_for_file: file_names

import 'package:get/get.dart';

import '../data/datasource/static/items_DragDrop_list.dart';
import '../data/model/DragDrop_model.dart';

class DragDropController extends GetxController {
  var score = 0.obs;
  var gameOver = false.obs;
  late List<DragDropModel> items;
  late List<DragDropModel> items2;

  scorePls() {
    score += 10;
    update();
  }

  scoreMinus() {
    score -= 5;
    update();
  }

  void chingGameOver() {
    gameOver.value = !gameOver.value;
    update();
  }

  void shuffle() {
    items = List<DragDropModel>.from(list_items_DragDrop);
    items2 = List<DragDropModel>.from(list_items_DragDrop);
    items.shuffle();
    items2.shuffle();
    update();
  }
}
