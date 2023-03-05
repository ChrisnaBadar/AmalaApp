import 'package:amala/constants/my_strings.dart';
import 'package:amala/controllers/yaumi_setting_controller.dart';
import 'package:amala/models/hive/hive_yaumi_active_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:amala/models/hive/boxes.dart';

class YaumiSetting extends StatefulWidget {
  const YaumiSetting({Key? key}) : super(key: key);

  @override
  State<YaumiSetting> createState() => _MYaumiSettingsState();
}

class _MYaumiSettingsState extends State<YaumiSetting> {
  final controller = Get.put(YaumiSettingController());

  @override
  Widget build(BuildContext context) {
    List myImageIcon = [
      MyStrings.fardhuIconColor,
      MyStrings.tahajudIconColor,
      MyStrings.dhuhaIconColor,
      MyStrings.rawatibIconColor,
      MyStrings.tilawahIconColor,
      MyStrings.shaumIconColor,
      MyStrings.sedekahIconColor,
      MyStrings.dzikirIconColor,
      MyStrings.taklimIconColor,
      MyStrings.istighfarIconColor,
      MyStrings.shalawatIconColor
    ];
    List<Map> yaumiSettingParam = [
      {
        'title': 'Shalat Fardhu',
        'subTitle': 'Aktifkan tracker shalat fardhu berjama\'ah di masjid',
        'trailling': Obx(() => Switch(
            value: controller.fardhu.value,
            onChanged: (val) {
              controller.fardhu.value = val;
              controller.updateData();
            }))
      },
      {
        'title': 'Shalat Tahajud',
        'subTitle': 'Aktifkan tracker shalat tahajud',
        'trailling': Obx(() => Switch(
            value: controller.tahajud.value,
            onChanged: (val) {
              controller.tahajud.value = val;
              controller.updateData();
            }))
      },
      {
        'title': 'Shalat Dhuha',
        'subTitle': 'Aktifkan tracker shalat dhuha',
        'trailling': Obx(() => Switch(
            value: controller.dhuha.value,
            onChanged: (val) {
              controller.dhuha.value = val;
              controller.updateData();
            }))
      },
      {
        'title': 'Shalat Rawatib',
        'subTitle': 'Aktifkan tracker shalat rawatib',
        'trailling': Obx(() => Switch(
            value: controller.rawatib.value,
            onChanged: (val) {
              controller.rawatib.value = val;
              controller.updateData();
            }))
      },
      {
        'title': 'Tilawah Al-Qur\'an',
        'subTitle': 'Aktifkan tracker membaca al-Qur\'an harian',
        'trailling': Obx(() => Switch(
            value: controller.tilawah.value,
            onChanged: (val) {
              controller.tilawah.value = val;
              controller.updateData();
            }))
      },
      {
        'title': 'Shaum Sunnah',
        'subTitle': 'Aktifkan tracker Shaum Sunnah',
        'trailling': Obx(() => Switch(
            value: controller.shaum.value,
            onChanged: (val) {
              controller.shaum.value = val;
              controller.updateData();
            }))
      },
      {
        'title': 'Sedekah Harian',
        'subTitle': 'Aktifkan tracker Sedekah Harian',
        'trailling': Obx(() => Switch(
            value: controller.sedekah.value,
            onChanged: (val) {
              controller.sedekah.value = val;
              controller.updateData();
            }))
      },
      {
        'title': 'Dzikir Pagi & Petang',
        'subTitle': 'Aktifkan tracker dzikir pagi & petang',
        'trailling': Obx(() => Switch(
            value: controller.dzikir.value,
            onChanged: (val) {
              controller.dzikir.value = val;
              controller.updateData();
            }))
      },
      {
        'title': 'Taklim Mandiri',
        'subTitle': 'Aktifkan tracker taklim mandiri harian',
        'trailling': Obx(() => Switch(
            value: controller.taklim.value,
            onChanged: (val) {
              controller.taklim.value = val;
              controller.updateData();
            }))
      },
      {
        'title': 'Istghfar Harian',
        'subTitle': 'Aktifkan tracker istighfar harian',
        'trailling': Obx(() => Switch(
            value: controller.istighfar.value,
            onChanged: (val) {
              controller.istighfar.value = val;
              controller.updateData();
            }))
      },
      {
        'title': 'Shalawat Harian',
        'subTitle': 'Aktifkan tracker shalawat harian',
        'trailling': Obx(() => Switch(
            value: controller.shalawat.value,
            onChanged: (val) {
              controller.shalawat.value = val;
              controller.updateData();
            }))
      },
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 8.0,
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      'Untuk memulai tracking habit ibadah harian silahkan mengaktifkan ibadah apa yang ingin diperbaiki dan dijadikan kebiasaan baik.')),
              ValueListenableBuilder<Box<HiveYaumiActiveModel>>(
                  valueListenable: Boxes.getYaumiActiveModel().listenable(),
                  builder: (context, box, _) {
                    final yaumiActiveModel =
                        box.values.toList().cast<HiveYaumiActiveModel>();
                    if (yaumiActiveModel.isEmpty) {
                      controller.setFirstActivator();
                      return Container();
                    } else {
                      controller.setHiveData(yaumiActiveModel);
                      return Column(
                        children: [
                          ListView.builder(
                            itemCount: yaumiSettingParam.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  leading:
                                      Image.asset(myImageIcon[index], scale: 2),
                                  title:
                                      Text(yaumiSettingParam[index]['title']),
                                  subtitle: Text(
                                      yaumiSettingParam[index]['subTitle']),
                                  trailing: yaumiSettingParam[index]
                                      ['trailling'],
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
