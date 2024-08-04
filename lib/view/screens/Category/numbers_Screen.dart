import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/FloatingController.dart';
import '../../../data/datasource/bg_data.dart';
import '../../../data/model/category_model.dart';
import '../../widget/custom_card.dart';

class LearnScreen1 extends StatelessWidget {
  const LearnScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    final FloatingController controller =
        Get.put(FloatingController(), permanent: true);

    CategoryModel categ = Get.arguments as CategoryModel;
    var category = categ.list;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          categ.name,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bgList[controller.selectedIndex]),
            fit: BoxFit.fill,
          ),
        ),
        child: GridView.builder(
          itemCount: category!.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.7,
              crossAxisSpacing: 5,
              mainAxisSpacing: 30,
              mainAxisExtent: 165),
          itemBuilder: (context, i) {
            return CustomCard(category: category[i]);
          },
        ),
      ),
    );
  }
}
