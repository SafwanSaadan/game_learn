import 'package:flutter/material.dart';

class CategoryModel {
  final String name;
  final String image;
  final List<CategoryModel>? list;
  final String? imageSign;
  final String? description;
  final String? audio;
  final Color? color;
  final String? rout;

  const CategoryModel(
      {required this.name,
      required this.image,
      this.list,
      this.imageSign,
      this.description,
      this.audio,
      this.color,
      this.rout});
}
