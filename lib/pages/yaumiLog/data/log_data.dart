import 'package:intl/intl.dart';
import 'package:amala/pages/yaumiLog/chartModel/chart_model.dart';
import '../../../models/hive/hive_yaumi_model.dart';

class LogData {
  List myLogData = [
    {
      'title': 'Shalat Berjama\'ah di Masjid',
      'list': [
        {
          'title': 'Shalat Shubuh',
          true: 'Alhamdulillah berjama\'ah',
          false: 'InsyaAllah lain kali bisa berjama\'ah di Masjid'
        },
        {
          'title': 'Shalat Dhuhur',
          true: 'Alhamdulillah berjama\'ah',
          false: 'InsyaAllah lain kali bisa berjama\'ah di Masjid'
        },
        {
          'title': 'Shalat Ashar',
          true: 'Alhamdulillah berjama\'ah',
          false: 'InsyaAllah lain kali bisa berjama\'ah di Masjid'
        },
        {
          'title': 'Shalat Maghrib',
          true: 'Alhamdulillah berjama\'ah',
          false: 'InsyaAllah lain kali bisa berjama\'ah di Masjid'
        },
        {
          'title': 'Shalat Isya',
          true: 'Alhamdulillah berjama\'ah',
          false: 'InsyaAllah lain kali bisa berjama\'ah di Masjid'
        }
      ],
    },
    {
      'title': 'Shalat Tahajud',
      true: 'Alhamdulillah melaksanakan shalat Tahajud',
      false: 'InsyaAllah lain kali bisa bangun malam'
    },
    {
      'title': 'Shalat Dhuha',
      true: 'Alhamdulillah shalat Dhuha tidak terlewat',
      false: 'InsyaAllah lain kali bisa melaksanakan Dhuha'
    },
    {
      'title': 'Shalat Rawatib',
      true: 'Alhamdulillah tidak tertinggal shalat Rawatib',
      false: 'InsyaAllah lain kali bisa melaksanakan Rawatib'
    },
    {
      'title': 'Tilawah Al-Qur\'an',
      true: 'Alhamdulillah tilawah tidak terlewat',
      false: 'InsyaAllah lain kali bisa tilawah Qur\'an'
    },
    {
      'title': 'Shaum Sunnah',
      true: 'Alhamdulillah shaum sunnah',
      false: 'InsyaAllah lain kali bisa melaksanakan shaum'
    },
    {
      'title': 'Sedekah / Infaq',
      true: 'Alhamdulillah semoga bermanfa\'at',
      false: 'InsyaAllah lain kali bisa bersedekah'
    },
    {
      'title': 'Dzikir Pagi & Petang',
      'list': [
        {
          'title': 'Dzikir Pagi',
          true: 'Alhamdulillah Dzikir pagi tidak terlewat',
          false: 'InsyaAllah lain kali tidak terlewat'
        },
        {
          'title': 'Dzikir Petang',
          true: 'Alhamdulillah Dzikir petang tidak terlewat',
          false: 'InsyaAllah lain kali tidak terlewat'
        },
      ]
    },
    {
      'title': 'Taklim Mandiri / Halaqah',
      true: 'Alhamdulillah semoga ilmu bermanfa\'at',
      false: 'InsyaAllah lain kali melakukan taklim mandiri'
    },
    {
      'title': 'Istighfar',
      true: 'Alhamdulillah semoga mendapatkan ridho Allah',
      false: 'InsyaAllah lain kali tidak terlewat'
    },
    {
      'title': 'Shalawat',
      true: 'Alhamdulillah semoga shalawat tersampaikan',
      false: 'InsyaAllah lain kali tidak terlewat'
    }
  ];

  List chartModel(List<HiveYaumiModel> hiveYaumiModel) {
    List<DateTime> days = List.generate(
        7,
        (index) => DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day - 6 + index));
    double? values0 = hiveYaumiModel
            .where((element) => element.tanggal == days[0])
            .map((e) => e.point)
            .isEmpty
        ? 0.0
        : hiveYaumiModel
            .where((element) => element.tanggal == days[0])
            .map((e) => e.point)
            .first;
    double? values1 = hiveYaumiModel
            .where((element) => element.tanggal == days[1])
            .map((e) => e.point)
            .isEmpty
        ? 0.0
        : hiveYaumiModel
            .where((element) => element.tanggal == days[1])
            .map((e) => e.point)
            .first;
    double? values2 = hiveYaumiModel
            .where((element) => element.tanggal == days[2])
            .map((e) => e.point)
            .isEmpty
        ? 0.0
        : hiveYaumiModel
            .where((element) => element.tanggal == days[2])
            .map((e) => e.point)
            .first;
    double? values3 = hiveYaumiModel
            .where((element) => element.tanggal == days[3])
            .map((e) => e.point)
            .isEmpty
        ? 0.0
        : hiveYaumiModel
            .where((element) => element.tanggal == days[3])
            .map((e) => e.point)
            .first;
    double? values4 = hiveYaumiModel
            .where((element) => element.tanggal == days[4])
            .map((e) => e.point)
            .isEmpty
        ? 0.0
        : hiveYaumiModel
            .where((element) => element.tanggal == days[4])
            .map((e) => e.point)
            .first;
    double? values5 = hiveYaumiModel
            .where((element) => element.tanggal == days[5])
            .map((e) => e.point)
            .isEmpty
        ? 0.0
        : hiveYaumiModel
            .where((element) => element.tanggal == days[5])
            .map((e) => e.point)
            .first;
    double? values6 = hiveYaumiModel
            .where((element) => element.tanggal == days[6])
            .map((e) => e.point)
            .isEmpty
        ? 0.0
        : hiveYaumiModel
            .where((element) => element.tanggal == days[6])
            .map((e) => e.point)
            .first;
    List values = [
      values0,
      values1,
      values2,
      values3,
      values4,
      values5,
      values6
    ];

    print('days: $days\nValues: $values');

    var myModel = [
      ChartModel(
          id: 0,
          name: DateFormat('EEE', "id_ID").format(days[0]),
          y: values[0] == null ? 0.0 : values[0]),
      ChartModel(
          id: 1,
          name: DateFormat('EEE', "id_ID").format(days[1]),
          y: values[1] == null ? 0.0 : values[1]),
      ChartModel(
          id: 2,
          name: DateFormat('EEE', "id_ID").format(days[2]),
          y: values[2] == null ? 0.0 : values[2]),
      ChartModel(
          id: 3,
          name: DateFormat('EEE', "id_ID").format(days[3]),
          y: values[3] == null ? 0.0 : values[3]),
      ChartModel(
          id: 4,
          name: DateFormat('EEE', "id_ID").format(days[4]),
          y: values[4] == null ? 0.0 : values[4]),
      ChartModel(
          id: 5,
          name: DateFormat('EEE', "id_ID").format(days[5]),
          y: values[5] == null ? 0.0 : values[5]),
      ChartModel(
          id: 6,
          name: DateFormat('EEE', "id_ID").format(days[6]),
          y: values[6] == null ? 0.0 : values[6])
    ];

    return myModel;
  }
}
