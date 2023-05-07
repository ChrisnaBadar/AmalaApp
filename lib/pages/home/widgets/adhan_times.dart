// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amala/services/adhan_service.dart';
import 'package:flutter/material.dart';

import 'package:amala/constants/core_data.dart';

import '../../../blocs/bloc_exports.dart';

class AdhanTimes extends StatelessWidget {
  final String? shalatTitle;
  final String? shalatTimes;
  final String? nextShalatTimes;
  final AnimationController? animationController;
  const AdhanTimes({
    Key? key,
    this.shalatTitle,
    this.shalatTimes,
    this.nextShalatTimes,
    this.animationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    CoreData.shalatTitle,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey[900]),
                  ),
                  Text(
                    CoreData.shalatTimes,
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey[900]),
                  ),
                  Countdown(
                    animation: StepTween(begin: CoreData.levelClock, end: 0)
                        .animate(animationController!),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Aktifkan Pengingat',
                    style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey[700]),
                  ),
                  Text(
                    'Waktu Shalat?',
                    style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey[700]),
                  ),
                  Switch(
                      value: state.shalatReminder,
                      onChanged: (val) {
                        context
                            .read<SettingsBloc>()
                            .add(TooggleShalatReminderEvent());
                        AdhanService().setAdhanAlarm(val);
                      })
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

class Countdown extends AnimatedWidget {
  Countdown({Key? key, this.animation})
      : super(key: key, listenable: animation!);
  final Animation<int>? animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation!.value);

    String timerText =
        '${clockTimer.inHours.remainder(12).toString().padLeft(2, '0')}:${clockTimer.inMinutes.remainder(60).toString().padLeft(2, '0')}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';

    return Text(
      "- $timerText hingga waktu ${CoreData.shalatTitle}",
      style: TextStyle(
        fontSize: 11.0,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
