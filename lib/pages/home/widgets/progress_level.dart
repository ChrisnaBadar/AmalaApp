import 'package:flutter/material.dart';

Widget progressLevel(
    {@required BuildContext? context,
    @required double? widgetSpacing,
    @required double? imageSize,
    @required double? leftWidth,
    @required double? rightWidth,
    @required double? expWidth,
    @required double? expPoint,
    @required double? totalExp,
    @required double? currentExp}) {
  return SizedBox(
    width: MediaQuery.of(context!).size.width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        height(widgetSpacing),

        //Main body
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //imageBody
            bodyImage(imageSize, leftWidth),
            //body details
            bodyDetails(widgetSpacing, rightWidth, expWidth, expPoint,
                currentExp, totalExp)
          ],
        ),
        height(widgetSpacing),
      ],
    ),
  );
}

height(widgetSpacing) {
  return SizedBox(
    height: widgetSpacing,
  );
}

bodyImage(imageSize, leftWidth) {
  return SizedBox(
    width: leftWidth,
    child: FlutterLogo(
      size: imageSize,
    ),
  );
}

bodyDetails(
    widgetSpacing, rightWidth, epxWidth, expPoint, currentExp, totalExp) {
  return SizedBox(
    width: rightWidth,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Level 1',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
        height(widgetSpacing),
        const Text('Beginner', style: TextStyle(fontStyle: FontStyle.italic)),
        height(widgetSpacing),
        const Text(
          'Exp.',
          style: TextStyle(color: Colors.blue),
        ),
        expBar(epxWidth, expPoint),
        height(widgetSpacing),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${currentExp.roundToDouble()}',
              style: const TextStyle(color: Colors.blue),
            ),
            Text(
              '${totalExp.roundToDouble()}',
              style: const TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ],
    ),
  );
}

expBar(expWidth, expPoint) {
  return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: LinearProgressIndicator(
        value: expPoint,
      ));
}
