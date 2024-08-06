// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/MemoryGameController.dart';
import '../../../core/constant/AppColor.dart';
import '../ResultMessage.dart';

class MemGameGrideView extends StatefulWidget {
  final List<dynamic> jsonData;
  final List<dynamic> jsonData1;
  int rendomIndex;
  MemGameGrideView(
      {required this.jsonData,
      required this.jsonData1,
      required this.rendomIndex,
      super.key});

  @override
  State<MemGameGrideView> createState() => _MemGameGrideViewState();
}

class _MemGameGrideViewState extends State<MemGameGrideView> {
    final MemoryGameController controller =
      Get.put(MemoryGameController(), permanent: true);
  // دالة التحقق من القيم المدخله
  void chackAnswer(bool answer) {
    if (answer) {
      showDialog(
          context: context,
          builder: (context) {
            return ResultMessage(
              message: "إجابة صحيحة",
              messageColor: AppColor.green,
              icon: Icons.check,
              iconColor: AppColor.green,
              onTap: () => Navigator.of(context).pop(),
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return ResultMessage(
              message: "إجابة خاطئة",
              messageColor: AppColor.red,
              icon: Icons.close,
              iconColor: AppColor.red,
              onTap: () => Navigator.of(context).pop(),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      height: screenWidth,
      width: screenWidth,
      child: GridView.builder(
          itemCount: widget.jsonData.length,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, crossAxisSpacing: 16.0, mainAxisSpacing: 16.0),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  controller.tries.value ++;

                  if (widget.jsonData[widget.rendomIndex]['image'] ==
                      widget.jsonData1[index]['image']) {
                    controller.score.value += 100;
                    controller.answerUser.value = true;
                    chackAnswer(controller.answerUser.value);
                  } else {
                    chackAnswer(controller.answerUser.value);
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColor.blue,
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                      image: AssetImage(widget.jsonData1[index]['image']),
                      fit: BoxFit.cover),
                ),
              ),
            );
          }),
    );
  }
}
