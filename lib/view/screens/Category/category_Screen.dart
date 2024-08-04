// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game_learn/data/datasource/static/category_list.dart';

import '../../widget/category_card.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: categoryList.length,
          itemBuilder: (context, index) {
            return CategoryItem(category: categoryList[index]);
          }),
    );
  }
}
