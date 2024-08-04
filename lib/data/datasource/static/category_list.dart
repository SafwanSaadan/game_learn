import 'package:game_learn/data/datasource/static/animals_list.dart';
import 'package:game_learn/data/datasource/static/colors_list.dart';
import 'package:game_learn/data/datasource/static/letters_list.dart';

import '../../../core/constant/AppColor.dart';
import '../../../core/constant/AppRoutes.dart';
import '../../../core/constant/path/images_Path.dart';
import '../../model/category_model.dart';
import 'numbers_List .dart';

const List<CategoryModel> categoryList = [
  CategoryModel(
      name: 'الحروف',
      list: lettersList,
      image: ImagesPath.categoryPathImageNumbers,
      rout: AppRoutes.numbers,
      color: AppColor.orange),
  CategoryModel(
      name: 'الأرقام',
      list: numbersList,
      image: ImagesPath.categoryPathImageNumbers,
      rout: AppRoutes.numbers,
      color: AppColor.blue),
  CategoryModel(
      name: 'الألوان',
      list: colorsList,
      image: ImagesPath.categoryPathImageColors,
      rout: AppRoutes.colors,
      color: AppColor.green),
  CategoryModel(
      name: 'الحيوانات',
      list: animalsList,
      image: ImagesPath.categoryPathImageColors,
      rout: AppRoutes.colors,
      color: AppColor.green),
];
