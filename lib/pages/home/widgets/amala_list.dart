import 'package:amala/constants/core_data.dart';
import 'package:amala/constants/my_strings.dart';
import 'package:amala/constants/my_theme_data.dart';
import 'package:amala/pages/yaumi_setting/yaumi_setting.dart';
import 'package:flutter/material.dart';
import 'package:amala/pages/home/widgets/amala_widgets/amala_category_tile.dart';
import 'package:get/get.dart';

class AmalaList extends StatefulWidget {
  const AmalaList({super.key});

  @override
  State<AmalaList> createState() => _AmalaListState();
}

class _AmalaListState extends State<AmalaList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(CoreData.cornerRadius),
              topRight: Radius.circular(CoreData.cornerRadius)),
          color: Colors.white),
      child: Column(
        children: [
          const SizedBox(
            height: 16.0,
          ),
          Container(
            width: 55.0,
            height: 5,
            decoration: const BoxDecoration(
                color: MyThemeData.primaryColor,
                borderRadius:
                    BorderRadius.all(Radius.circular(CoreData.cornerRadius))),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.list,
                    color: MyThemeData.primaryColor,
                  )),
              Container(
                width: 120.0,
                height: 2.0,
                color: MyThemeData.primaryColor,
              ),
              IconButton(
                  onPressed: () => Get.to(() => const YaumiSetting()),
                  icon: const Icon(
                    Icons.settings,
                    color: MyThemeData.primaryColor,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
