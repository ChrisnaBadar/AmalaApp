import 'package:amala/models/hive/boxes.dart';
import 'package:amala/models/hive/hive_yaumi_model.dart';
import 'package:get/get.dart';

class HabitChecklistController extends GetxController {
  RxBool shubuh = false.obs,
      dhuhur = false.obs,
      ashar = false.obs,
      maghrib = false.obs,
      isya = false.obs,
      tahajud = false.obs,
      dhuha = false.obs,
      rawatib = false.obs,
      tilawah = false.obs,
      shaum = false.obs,
      sedekah = false.obs,
      dzikirPagi = false.obs,
      dzikirPetang = false.obs,
      taklim = false.obs,
      istighfar = false.obs,
      shalawat = false.obs,
      isSaved = false.obs;
  RxDouble point = 0.0.obs;
  RxDouble shownPoint = 0.0.obs;

  void calculateTodayPoint(
      bool fardhuBool,
      tahajudBool,
      dhuhaBool,
      rawatibBool,
      tilawahBool,
      shaumBool,
      sedekahBool,
      dzikirBoold,
      taklimBoold,
      istighfarBool,
      shalawatBool,
      seninKamis) {
    var activatedCategory = [
      fardhuBool,
      fardhuBool,
      fardhuBool,
      fardhuBool,
      fardhuBool,
      tahajudBool,
      dhuhaBool,
      rawatibBool,
      tilawahBool,
      shaumBool,
      sedekahBool,
      dzikirBoold,
      dzikirBoold,
      taklimBoold,
      istighfarBool,
      shalawatBool
    ].where((e) => e == true).length;
    point.value = ((((fardhuBool ? (shubuh.value ? 1.0 : 0.0) : 0) +
                    (fardhuBool ? (dhuhur.value ? 1.0 : 0.0) : 0) +
                    (fardhuBool ? (ashar.value ? 1.0 : 0.0) : 0) +
                    (fardhuBool ? (maghrib.value ? 1.0 : 0.0) : 0) +
                    (fardhuBool ? (isya.value ? 1.0 : 0.0) : 0) +
                    (tahajudBool ? (tahajud.value ? 1.0 : 0.0) : 0) +
                    (dhuhaBool ? (dhuha.value ? 1.0 : 0.0) : 0) +
                    (rawatibBool ? (rawatib.value ? 1.0 : 0.0) : 0) +
                    (tilawahBool ? (tilawah.value ? 1.0 : 0.0) : 0) +
                    (shaumBool
                        ? (seninKamis ? (shaum.value ? 1.0 : 0.0) : 1.0)
                        : 0) +
                    (sedekahBool ? (sedekah.value ? 1.0 : 0.0) : 0) +
                    (dzikirBoold ? (dzikirPagi.value ? 1.0 : 0.0) : 0) +
                    (dzikirBoold ? (dzikirPetang.value ? 1.0 : 0.0) : 0) +
                    (taklimBoold ? (taklim.value ? 1.0 : 0.0) : 0) +
                    (istighfarBool ? (istighfar.value ? 1.0 : 0.0) : 0) +
                    (shalawatBool ? (shalawat.value ? 1.0 : 0.0) : 0)) /
                activatedCategory) *
            100)
        .roundToDouble();
    shownPoint.value = point.value;
  }

  void setHiveData(List<HiveYaumiModel> hiveYaumiModel, DateTime tanggal) {
    final tanggalResult =
        hiveYaumiModel.where((element) => element.tanggal == tanggal);
    shubuh.value = tanggalResult.first.shubuh!;
    dhuhur.value = tanggalResult.first.dhuhur!;
    ashar.value = tanggalResult.first.ashar!;
    maghrib.value = tanggalResult.first.maghrib!;
    isya.value = tanggalResult.first.isya!;
    tahajud.value = tanggalResult.first.tahajud!;
    dhuha.value = tanggalResult.first.dhuha!;
    rawatib.value = tanggalResult.first.rawatib!;
    tilawah.value = tanggalResult.first.tilawah!;
    shaum.value = tanggalResult.first.shaum!;
    sedekah.value = tanggalResult.first.sedekah!;
    dzikirPagi.value = tanggalResult.first.dzikirPagi!;
    dzikirPetang.value = tanggalResult.first.dzikirPetang!;
    taklim.value = tanggalResult.first.taklim!;
    istighfar.value = tanggalResult.first.istighfar!;
    shalawat.value = tanggalResult.first.shalawat!;
    isSaved.value = tanggalResult.first.isSaved!;
    point.value = tanggalResult.first.point!;
  }

  void setFirstData(DateTime tanggal) {
    final hiveYaumiModel = HiveYaumiModel()
      ..tanggal = tanggal
      ..shubuh = false
      ..dhuhur = false
      ..ashar = false
      ..maghrib = false
      ..isya = false
      ..tahajud = false
      ..dhuha = false
      ..rawatib = false
      ..tilawah = false
      ..shaum = false
      ..sedekah = false
      ..dzikirPagi = false
      ..dzikirPetang = false
      ..taklim = false
      ..istighfar = false
      ..shalawat = false
      ..isSaved = false
      ..point = 0.0;
    final box = Boxes.getYaumiModel();
    box.put(tanggal.toString(), hiveYaumiModel);
  }

  void setSavedValue({DateTime? tanggal, List? yaumi}) {
    final hiveYaumiModel = HiveYaumiModel()
      ..tanggal = tanggal
      ..shubuh = yaumi![0]
      ..dhuhur = yaumi[1]
      ..ashar = yaumi[2]
      ..maghrib = yaumi[3]
      ..isya = yaumi[4]
      ..tahajud = yaumi[5]
      ..dhuha = yaumi[6]
      ..rawatib = yaumi[7]
      ..tilawah = yaumi[8]
      ..shaum = yaumi[9]
      ..sedekah = yaumi[10]
      ..dzikirPagi = yaumi[11]
      ..dzikirPetang = yaumi[12]
      ..taklim = yaumi[13]
      ..istighfar = yaumi[14]
      ..shalawat = yaumi[15]
      ..isSaved = true
      ..point = yaumi[16];
    final box = Boxes.getYaumiModel();
    box.put(tanggal.toString(), hiveYaumiModel);
  }

  void setData({DateTime? tanggal}) {
    final hiveYaumiModel = HiveYaumiModel()
      ..tanggal = tanggal
      ..shubuh = shubuh.value
      ..dhuhur = dhuhur.value
      ..ashar = ashar.value
      ..maghrib = maghrib.value
      ..isya = isya.value
      ..tahajud = tahajud.value
      ..dhuha = dhuha.value
      ..rawatib = rawatib.value
      ..tilawah = tilawah.value
      ..shaum = shaum.value
      ..sedekah = sedekah.value
      ..dzikirPagi = dzikirPagi.value
      ..dzikirPetang = dzikirPetang.value
      ..taklim = taklim.value
      ..istighfar = istighfar.value
      ..shalawat = shalawat.value
      ..isSaved = isSaved.value
      ..point = point.value;
    final box = Boxes.getYaumiModel();
    box.put(tanggal.toString(), hiveYaumiModel);
  }
}
