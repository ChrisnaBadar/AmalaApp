import 'package:amala/constants/core_data.dart';
import 'package:amala/constants/my_strings.dart';
import 'package:amala/constants/my_text_styles.dart';
import 'package:amala/constants/my_theme_data.dart';
import 'package:flutter/material.dart';

Widget dateLocationHeader({
  @required BuildContext? context,
}) {
  return SizedBox(
    width: MediaQuery.of(context!).size.width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  MyStrings.calenderIconColor,
                  scale: 2,
                ),
                const SizedBox(
                  width: 4.0,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .35,
                  child: Text.rich(
                    TextSpan(children: [
                      TextSpan(
                          text: '${CoreData.hariIni}, ',
                          style: const TextStyle(
                              color: MyThemeData.secondaryTextColor)),
                      TextSpan(text: '${CoreData.tanggalIni} '),
                      TextSpan(text: '${CoreData.bulanIni} '),
                      TextSpan(text: CoreData.tahunIni),
                    ]),
                    style: MyTextStyles.smallText(),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .35,
                  child: Text.rich(
                    TextSpan(children: [
                      TextSpan(text: '${CoreData.kota}, '),
                      TextSpan(
                          text: '${CoreData.wilayah} ',
                          style: const TextStyle(
                              color: MyThemeData.secondaryTextColor)),
                    ]),
                    style: MyTextStyles.smallText(),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Image.asset(
                  MyStrings.locationPinIconColor,
                  scale: 2,
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}
