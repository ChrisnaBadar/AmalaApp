import 'package:amala/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../models/hive/hive_yaumi_active_model.dart';
import '../controllers/habitChecklistController.dart';
import '../data/habitChecklistDetailsData.dart';

Map categoryParamData = HabitChecklistDetailsData().checklistParamData;

Widget _dateDetails({@required HomeController? homeController}) {
  return Obx(() => Text(
      DateFormat('EEEE, dd MMMM yyyy', "id_ID")
          .format(homeController!.selectedDate.value),
      style: const TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)));
}

List<Widget> _fardhuWidget(
    {@required HabitChecklistController? habitController,
    @required HomeController? homeController,
    @required HiveYaumiActiveModel? hiveYaumiActiveModel}) {
  var fardhu = hiveYaumiActiveModel!.fardhu;
  var tahajud = hiveYaumiActiveModel.tahajud;
  var dhuha = hiveYaumiActiveModel.dhuha;
  var rawatib = hiveYaumiActiveModel.rawatib;
  var tilawah = hiveYaumiActiveModel.tilawah;
  var shaum = hiveYaumiActiveModel.shaum;
  var sedekah = hiveYaumiActiveModel.sedekah;
  var dzikir = hiveYaumiActiveModel.dzikir;
  var taklim = hiveYaumiActiveModel.taklim;
  var istighfar = hiveYaumiActiveModel.istighfar;
  var shalawat = hiveYaumiActiveModel.shalawat;
  var seninKamis =
      DateFormat('EEEE', "id_ID").format(homeController!.selectedDate.value) ==
                  'Senin' ||
              DateFormat('EEEE', "id_ID")
                      .format(homeController.selectedDate.value) ==
                  'Kamis'
          ? true
          : false;
  return [
    Obx(() => Switch(
        value: habitController!.shubuh.value,
        onChanged: (val) {
          habitController.shubuh.value = val;
          habitController.calculateTodayPoint(
              fardhu!,
              tahajud,
              dhuha,
              rawatib,
              tilawah,
              shaum,
              sedekah,
              dzikir,
              taklim,
              istighfar,
              shalawat,
              seninKamis);
          habitController.setData(tanggal: homeController.selectedDate.value);
        })),
    Obx(() => Switch(
        value: habitController!.dhuhur.value,
        onChanged: (val) {
          habitController.dhuhur.value = val;
          habitController.calculateTodayPoint(
              fardhu!,
              tahajud,
              dhuha,
              rawatib,
              tilawah,
              shaum,
              sedekah,
              dzikir,
              taklim,
              istighfar,
              shalawat,
              seninKamis);
          habitController.setData(tanggal: homeController.selectedDate.value);
        })),
    Obx(() => Switch(
        value: habitController!.ashar.value,
        onChanged: (val) {
          habitController.ashar.value = val;
          habitController.calculateTodayPoint(
              fardhu!,
              tahajud,
              dhuha,
              rawatib,
              tilawah,
              shaum,
              sedekah,
              dzikir,
              taklim,
              istighfar,
              shalawat,
              seninKamis);
          habitController.setData(tanggal: homeController.selectedDate.value);
        })),
    Obx(() => Switch(
        value: habitController!.maghrib.value,
        onChanged: (val) {
          habitController.maghrib.value = val;
          habitController.calculateTodayPoint(
              fardhu!,
              tahajud,
              dhuha,
              rawatib,
              tilawah,
              shaum,
              sedekah,
              dzikir,
              taklim,
              istighfar,
              shalawat,
              seninKamis);
          habitController.setData(tanggal: homeController.selectedDate.value);
        })),
    Obx(() => Switch(
        value: habitController!.isya.value,
        onChanged: (val) {
          habitController.isya.value = val;
          habitController.calculateTodayPoint(
              fardhu!,
              tahajud,
              dhuha,
              rawatib,
              tilawah,
              shaum,
              sedekah,
              dzikir,
              taklim,
              istighfar,
              shalawat,
              seninKamis);
          habitController.setData(tanggal: homeController.selectedDate.value);
        }))
  ];
}

List<Widget> _dzikirWidget(
    {@required HabitChecklistController? habitController,
    @required HomeController? homeController,
    @required HiveYaumiActiveModel? hiveYaumiActiveModel}) {
  var fardhu = hiveYaumiActiveModel!.fardhu;
  var tahajud = hiveYaumiActiveModel.tahajud;
  var dhuha = hiveYaumiActiveModel.dhuha;
  var rawatib = hiveYaumiActiveModel.rawatib;
  var tilawah = hiveYaumiActiveModel.tilawah;
  var shaum = hiveYaumiActiveModel.shaum;
  var sedekah = hiveYaumiActiveModel.sedekah;
  var dzikir = hiveYaumiActiveModel.dzikir;
  var taklim = hiveYaumiActiveModel.taklim;
  var istighfar = hiveYaumiActiveModel.istighfar;
  var shalawat = hiveYaumiActiveModel.shalawat;
  var seninKamis =
      DateFormat('EEEE', "id_ID").format(homeController!.selectedDate.value) ==
                  'Senin' ||
              DateFormat('EEEE', "id_ID")
                      .format(homeController.selectedDate.value) ==
                  'Kamis'
          ? true
          : false;
  return [
    Obx(() => Switch(
        value: habitController!.dzikirPagi.value,
        onChanged: (val) {
          habitController.dzikirPagi.value = val;
          habitController.calculateTodayPoint(
              fardhu!,
              tahajud,
              dhuha,
              rawatib,
              tilawah,
              shaum,
              sedekah,
              dzikir,
              taklim,
              istighfar,
              shalawat,
              seninKamis);
          habitController.setData(tanggal: homeController.selectedDate.value);
        })),
    Obx(() => Switch(
        value: habitController!.dzikirPetang.value,
        onChanged: (val) {
          habitController.dzikirPetang.value = val;
          habitController.calculateTodayPoint(
              fardhu!,
              tahajud,
              dhuha,
              rawatib,
              tilawah,
              shaum,
              sedekah,
              dzikir,
              taklim,
              istighfar,
              shalawat,
              seninKamis);
          habitController.setData(tanggal: homeController.selectedDate.value);
        }))
  ];
}

Widget checklistDetailsWidgets(
    {@required String? category,
    @required DateTime? tanggal,
    @required HabitChecklistController? habitController,
    @required HomeController? homeController,
    @required HiveYaumiActiveModel? hiveYaumiActiveModel}) {
  Map fardhuParamData = categoryParamData['fardhu'];
  Map tahajudParamData = categoryParamData['tahajud'];
  Map dhuhaParamData = categoryParamData['dhuha'];
  Map rawatibParamData = categoryParamData['rawatib'];
  Map tilawahParamData = categoryParamData['tilawah'];
  Map shaumParamData = categoryParamData['shaum'];
  Map sedekahParamData = categoryParamData['sedekah'];
  Map dzikirParamData = categoryParamData['dzikir'];
  Map taklimParamData = categoryParamData['taklim'];
  Map istighfarParamData = categoryParamData['istighfar'];
  Map shalawatParamData = categoryParamData['shalawat'];
  var fardhu = hiveYaumiActiveModel!.fardhu;
  var tahajud = hiveYaumiActiveModel.tahajud;
  var dhuha = hiveYaumiActiveModel.dhuha;
  var rawatib = hiveYaumiActiveModel.rawatib;
  var tilawah = hiveYaumiActiveModel.tilawah;
  var shaum = hiveYaumiActiveModel.shaum;
  var sedekah = hiveYaumiActiveModel.sedekah;
  var dzikir = hiveYaumiActiveModel.dzikir;
  var taklim = hiveYaumiActiveModel.taklim;
  var istighfar = hiveYaumiActiveModel.istighfar;
  var shalawat = hiveYaumiActiveModel.shalawat;
  var seninKamis =
      DateFormat('EEEE', "id_ID").format(homeController!.selectedDate.value) ==
                  'Senin' ||
              DateFormat('EEEE', "id_ID")
                      .format(homeController.selectedDate.value) ==
                  'Kamis'
          ? true
          : false;
  return Column(
    children: [
      SizedBox(
        height: 8.0,
      ),
      _dateDetails(homeController: homeController),
      SizedBox(
        height: 8.0,
      ),
      category == 'isFardhu'
          ? Column(
              children: [
                Text(fardhuParamData['title']),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                          '"Barang siapa pergi ke masjid pada awal dan akhir siang, maka Allah akan menyiapkan baginya tempat dan hidangan di surga setiap kali dia pergi." (HR Bukhari dan Muslim)'),
                    )),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Card(
                    child: Column(
                      children: [
                        ListView.builder(
                          itemCount: 5,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ListTile(
                                title: Text(
                                    fardhuParamData['list'][index]['title']),
                                subtitle: Text(
                                    fardhuParamData['list'][index]['subTitle']),
                                trailing: _fardhuWidget(
                                    habitController: habitController,
                                    homeController: homeController,
                                    hiveYaumiActiveModel:
                                        hiveYaumiActiveModel)[index]);
                          },
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          : Container(),

      //TAHAJUD
      category == 'isTahajud'
          ? Column(
              children: [
                Text(tahajudParamData['title']),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          '"Dan pada sebagian malam hari bersembahyang tahajudlah kamu sebagai suatu ibadah tambahan bagimu; mudah-mudahan Tuhan-mu mengangkat kamu ke tempat yang terpuji." Rasulullah juga bersabda: “Sholat yang paling utama setelah sholat wajib adalah qiyamul lail (sholat lail)," (HR. Muslim)'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Card(
                      child: ListTile(
                          title: Text(tahajudParamData['title']),
                          subtitle: Text(tahajudParamData['subTitle']),
                          trailing: Obx(() => Switch(
                              value: habitController!.tahajud.value,
                              onChanged: (val) {
                                habitController.tahajud.value = val;
                                habitController.calculateTodayPoint(
                                    fardhu!,
                                    tahajud,
                                    dhuha,
                                    rawatib,
                                    tilawah,
                                    shaum,
                                    sedekah,
                                    dzikir,
                                    taklim,
                                    istighfar,
                                    shalawat,
                                    seninKamis);
                                habitController.setData(
                                    tanggal: homeController.selectedDate.value);
                              })))),
                ),
              ],
            )
          : Container(),

      //DHUHA
      category == 'isDhuha'
          ? Column(
              children: [
                Text(dhuhaParamData['title']),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          '"Hendaklah masing-masingmu setiap pagi bersedekah untuk setiap ruas tulang badannya. Maka, tiap kali bacaan tasbih adalah sedekah, setiap tahmid adalah sedekah, setiap tahlil adalah sedekah, setiap takbir adalah sedekah, menyuruh kebaikan adalah sedekah, melarang keburukan adalah sedekah dan sebagai ganti dari semua itu, cukuplah mengerjakan dua rakaat shalat dhuha." (HR Ahmad, Muslim, dan Abu Daud)'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Card(
                      child: ListTile(
                    title: Text(dhuhaParamData['title']),
                    subtitle: Text(dhuhaParamData['subTitle']),
                    trailing: Obx(() => Switch(
                        value: habitController!.dhuha.value,
                        onChanged: (val) {
                          habitController.dhuha.value = val;
                          habitController.calculateTodayPoint(
                              fardhu!,
                              tahajud,
                              dhuha,
                              rawatib,
                              tilawah,
                              shaum,
                              sedekah,
                              dzikir,
                              taklim,
                              istighfar,
                              shalawat,
                              seninKamis);
                          habitController.setData(
                              tanggal: homeController.selectedDate.value);
                        })),
                  )),
                ),
              ],
            )
          : Container(),

      //RAWATIB
      category == 'isRawatib'
          ? Column(
              children: [
                Text(dhuhaParamData['title']),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          '“Barangsiapa sehari semalam mengerjakan shalat 12 raka’at (sunnah rawatib), akan dibangunkan baginya rumah di surga, yaitu: 4 raka’at sebelum Zhuhur, 2 raka’at setelah Zhuhur, 2 raka’at setelah Maghrib, 2 raka’at setelah ‘Isya dan 2 raka’at sebelum Shubuh.” (HR. Tirmidzi)'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Card(
                      child: ListTile(
                    title: Text(rawatibParamData['title']),
                    subtitle: Text(rawatibParamData['subTitle']),
                    trailing: Obx(() => Switch(
                        value: habitController!.rawatib.value,
                        onChanged: (val) {
                          habitController.rawatib.value = val;
                          habitController.calculateTodayPoint(
                              fardhu!,
                              tahajud,
                              dhuha,
                              rawatib,
                              tilawah,
                              shaum,
                              sedekah,
                              dzikir,
                              taklim,
                              istighfar,
                              shalawat,
                              seninKamis);
                          habitController.setData(
                              tanggal: homeController.selectedDate.value);
                        })),
                  )),
                ),
              ],
            )
          : Container(),

      //TILAWAH
      category == 'isTilawah'
          ? Column(
              children: [
                Text(tilawahParamData['title']),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          '“Bacalah Al-Qur’an sesungguhnya ia akan menjadi penolong pembacanya di hari kiamat.” (Muslim dari Abu Umamah)'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Card(
                      child: ListTile(
                    title: Text(tilawahParamData['title']),
                    subtitle: Text(tilawahParamData['subTitle']),
                    trailing: Obx(() => Switch(
                        value: habitController!.tilawah.value,
                        onChanged: (val) {
                          habitController.tilawah.value = val;
                          habitController.calculateTodayPoint(
                              fardhu!,
                              tahajud,
                              dhuha,
                              rawatib,
                              tilawah,
                              shaum,
                              sedekah,
                              dzikir,
                              taklim,
                              istighfar,
                              shalawat,
                              seninKamis);
                          habitController.setData(
                              tanggal: homeController.selectedDate.value);
                        })),
                  )),
                ),
              ],
            )
          : Container(),

      //SHAUM
      category == 'isShaum'
          ? Column(
              children: [
                Text(shaumParamData['title']),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          '“Aku berkata pada Rasul –shallallahu ‘alaihi wa sallam, “Wahai Rasulullah, engkau terlihat berpuasa sampai-sampai dikira tidak ada waktu bagimu untuk tidak puasa. Engkau juga terlihat tidak puasa, sampai-sampai dikira engkau tidak pernah puasa. Kecuali dua hari yang engkau bertemu dengannya dan berpuasa ketika itu.” Nabi shallallahu ‘alaihi wa sallam bertanya, “Apa dua hari tersebut?” Usamah menjawab, “Senin dan Kamis.” Lalu beliau bersabda, “Dua hari tersebut adalah waktu dihadapkannya amalan pada Rabb semesta alam (pada Allah). Aku sangat suka ketika amalanku dihadapkan sedang aku dalam keadaan berpuasa.” (HR. An Nasai)'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Card(
                      child: ListTile(
                    title: Text(shaumParamData['title']),
                    subtitle: Text(shaumParamData['subTitle']),
                    trailing: Obx(() => Switch(
                        value: habitController!.shaum.value,
                        onChanged: (val) {
                          habitController.shaum.value = val;
                          habitController.calculateTodayPoint(
                              fardhu!,
                              tahajud,
                              dhuha,
                              rawatib,
                              tilawah,
                              shaum,
                              sedekah,
                              dzikir,
                              taklim,
                              istighfar,
                              shalawat,
                              seninKamis);
                          habitController.setData(
                              tanggal: homeController.selectedDate.value);
                        })),
                  )),
                ),
              ],
            )
          : Container(),

      //SEDEKAH
      category == 'isSedekah'
          ? Column(
              children: [
                Text(sedekahParamData['title']),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          '"Dari Abu Hurairah radhiyallahu\'anhu sesungguhnya Nabi Muhammad SAW bersabda: "Tidak ada satu subuh-pun yang dialami hamba-hamba Allah kecuali turun kepada mereka dua malaikat. Salah satu di antara keduanya berdoa: "Ya Allah, berilah ganti bagi orang yang berinfak", sedangkan yang satu lagi berdoa "Ya Allah, berilah kerusakan bagi orang yang menahan (hartanya)." (HR. Bukhari)'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Card(
                      child: ListTile(
                    title: Text(sedekahParamData['title']),
                    subtitle: Text(sedekahParamData['subTitle']),
                    trailing: Obx(() => Switch(
                        value: habitController!.sedekah.value,
                        onChanged: (val) {
                          habitController.sedekah.value = val;
                          habitController.calculateTodayPoint(
                              fardhu!,
                              tahajud,
                              dhuha,
                              rawatib,
                              tilawah,
                              shaum,
                              sedekah,
                              dzikir,
                              taklim,
                              istighfar,
                              shalawat,
                              seninKamis);
                          habitController.setData(
                              tanggal: homeController.selectedDate.value);
                        })),
                  )),
                ),
              ],
            )
          : Container(),

      //DZIKIR
      category == 'isDzikir'
          ? Column(
              children: [
                Text(dzikirParamData['title']),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          '"Barangsiapa mengucapkannya (sayyidul istighfar) di siang hari dengan meyakininya lalu dia mati pada hari itu sebelum sore hari, maka dia termasuk penghuni surga. Dan barangsiapa mengucapkannya di malam hari dengan meyakininya lalu dia mati pada malam itu sebelum pagi, maka dia termasuk penghuni surga," (HR Bukhari)'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Card(
                    child: Column(
                      children: [
                        ListView.builder(
                          itemCount: 2,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ListTile(
                                title: Text(
                                    dzikirParamData['list'][index]['title']),
                                subtitle: Text(
                                    dzikirParamData['list'][index]['subTitle']),
                                trailing: _dzikirWidget(
                                    habitController: habitController,
                                    homeController: homeController,
                                    hiveYaumiActiveModel:
                                        hiveYaumiActiveModel)[index]);
                          },
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          : Container(),

      //TAKLIM
      category == 'isTaklim'
          ? Column(
              children: [
                Text(taklimParamData['title']),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          '“Tidak berkumpul dalam satu rumah dari rumah-rumsh Allah,mereka membaca kitab Allah,saling mengajarkanya sesama mereka,kecuali diturunkan kepada mereka sakinah,rahmat menyirami mereka,para malaikat mengerumini mereka dan Allah akan menyebut-nyebut mereka di kalangan malaikat yang ada di sisi-Nya”(Hr.Muslim,Abu Daud)'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Card(
                      child: ListTile(
                    title: Text(taklimParamData['title']),
                    subtitle: Text(taklimParamData['subTitle']),
                    trailing: Obx(() => Switch(
                        value: habitController!.taklim.value,
                        onChanged: (val) {
                          habitController.taklim.value = val;
                          habitController.calculateTodayPoint(
                              fardhu!,
                              tahajud,
                              dhuha,
                              rawatib,
                              tilawah,
                              shaum,
                              sedekah,
                              dzikir,
                              taklim,
                              istighfar,
                              shalawat,
                              seninKamis);
                          habitController.setData(
                              tanggal: homeController.selectedDate.value);
                        })),
                  )),
                ),
              ],
            )
          : Container(),

      //ISTIGHFAR
      category == 'isIstighfar'
          ? Column(
              children: [
                Text(istighfarParamData['title']),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          '“Tidaklah aku berada di pagi hari (antara terbit fajar hingga terbit matahari) kecuali aku beristigfar pada Allah sebanyak 100 kali.” (HR. An Nasa’i)'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Card(
                      child: ListTile(
                    title: Text(istighfarParamData['title']),
                    subtitle: Text(istighfarParamData['subTitle']),
                    trailing: Obx(() => Switch(
                        value: habitController!.istighfar.value,
                        onChanged: (val) {
                          habitController.istighfar.value = val;
                          habitController.calculateTodayPoint(
                              fardhu!,
                              tahajud,
                              dhuha,
                              rawatib,
                              tilawah,
                              shaum,
                              sedekah,
                              dzikir,
                              taklim,
                              istighfar,
                              shalawat,
                              seninKamis);
                          habitController.setData(
                              tanggal: homeController.selectedDate.value);
                        })),
                  )),
                ),
              ],
            )
          : Container(),

      //shalawat
      category == 'isShalawat'
          ? Column(
              children: [
                Text(shalawatParamData['title']),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          '“Barangsiapa bersholawat kepadaku satu kali, niscaya Allah bersholawat kepadanya sepuluh kali” (HR. Muslim)'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Card(
                      child: ListTile(
                    title: Text(shalawatParamData['title']),
                    subtitle: Text(shalawatParamData['subTitle']),
                    trailing: Obx(() => Switch(
                        value: habitController!.shalawat.value,
                        onChanged: (val) {
                          habitController.shalawat.value = val;
                          habitController.calculateTodayPoint(
                              fardhu!,
                              tahajud,
                              dhuha,
                              rawatib,
                              tilawah,
                              shaum,
                              sedekah,
                              dzikir,
                              taklim,
                              istighfar,
                              shalawat,
                              seninKamis);
                          habitController.setData(
                              tanggal: homeController.selectedDate.value);
                        })),
                  )),
                ),
              ],
            )
          : Container()
    ],
  );
}
