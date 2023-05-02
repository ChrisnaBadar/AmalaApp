// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amala/blocs/bloc_exports.dart';
import 'package:flutter/material.dart';
import 'package:amala/pages/home/widgets/yaumi_list.dart';

class YaumiPage extends StatelessWidget {
  const YaumiPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            color: Colors.white),
        child: Column(
          children: [
            const SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/logYaumi');
                      },
                      icon: const Icon(Icons.list_alt),
                      label: const Text('Log')),
                  BlocBuilder<SelectedDateBloc, SelectedDateState>(
                    builder: (context, selectedDateState) {
                      final selectedDate = selectedDateState.selectedDate;
                      return BlocBuilder<YaumiBloc, YaumiState>(
                        builder: (context, yaumiState) {
                          final yaumi = yaumiState.allYaumis;
                          var selectedYaumi = yaumi
                              .where((e) => e.date == selectedDate)
                              .toList();
                          if (selectedYaumi.isEmpty) {
                            return Container();
                          } else {
                            var todayYaumi = selectedYaumi.first;
                            return TextButton.icon(
                                onPressed: () {
                                  context
                                      .read<YaumiBloc>()
                                      .add(DeleteYaumiEvent(yaumi: todayYaumi));
                                  Navigator.pushReplacementNamed(
                                      context, '/yaumiSettings');
                                },
                                icon: const Icon(Icons.settings),
                                label: const Text('Settings'));
                          }
                        },
                      );
                    },
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            const Expanded(child: YaumiList())
          ],
        ),
      ),
    );
  }
}
