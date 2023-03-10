import 'package:amala/constants/my_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/habit_checklist_controller.dart';

Widget habitChecklistDetailsHeader(
    {@required BuildContext? context,
    @required HabitChecklistController? habitChecklistController}) {
  return Container(
    width: MediaQuery.of(context!).size.width,
    height: MediaQuery.of(context).size.width * 0.55,
    decoration: const BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0))),
    child: Row(
      children: [
        //resume penyelesaian habit
        Expanded(
            flex: 2,
            child: Obx(
              () => _detailsDescription(
                  prosentasePenyelesaian:
                      '${habitChecklistController!.shownPoint.value}%'),
            )),

        //representation image
        Expanded(flex: 1, child: _imageRepresentation())
      ],
    ),
  );
}

Widget _detailsDescription({@required String? prosentasePenyelesaian}) {
  return Padding(
    padding: const EdgeInsets.only(left: 16.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        prosentasePenyelesaian == '0.0%'
            ? Shimmer.fromColors(
                baseColor: Colors.grey,
                highlightColor: Colors.white,
                child: Container(
                  width: 50,
                  height: 10.0,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.white.withOpacity(.5),
                  ),
                ),
              )
            : Text('$prosentasePenyelesaian',
                style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
        const SizedBox(
          height: 8.0,
        ),
        const Text('Penyelesaian ibadah hari ini.',
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.normal,
                color: Colors.white)),
        const SizedBox(
          height: 8.0,
        ),
        const Text('Lakukan dari yang terkecil, lakukan mulai sekarang',
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.normal,
                color: Colors.white))
      ],
    ),
  );
}

Widget _imageRepresentation() {
  return Image.asset(
    MyStrings.readingQuran,
    scale: 2,
    opacity: const AlwaysStoppedAnimation(.75),
  );
}
