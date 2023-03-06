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

  void calculateTodayPoint(bool _fardhu, _tahajud, _dhuha, _rawatib, _tilawah,
      _shaum, _sedekah, _dzikir, _taklim, _istighfar, _shalawat, seninKamis) {
    var activatedCategory = [
      _fardhu,
      _fardhu,
      _fardhu,
      _fardhu,
      _fardhu,
      _tahajud,
      _dhuha,
      _rawatib,
      _tilawah,
      _shaum,
      _sedekah,
      _dzikir,
      _dzikir,
      _taklim,
      _istighfar,
      _shalawat
    ].where((e) => e == true).length;
    point.value = ((((_fardhu ? (shubuh.value ? 1.0 : 0.0) : 0) +
                    (_fardhu ? (dhuhur.value ? 1.0 : 0.0) : 0) +
                    (_fardhu ? (ashar.value ? 1.0 : 0.0) : 0) +
                    (_fardhu ? (maghrib.value ? 1.0 : 0.0) : 0) +
                    (_fardhu ? (isya.value ? 1.0 : 0.0) : 0) +
                    (_tahajud ? (tahajud.value ? 1.0 : 0.0) : 0) +
                    (_dhuha ? (dhuha.value ? 1.0 : 0.0) : 0) +
                    (_rawatib ? (rawatib.value ? 1.0 : 0.0) : 0) +
                    (_tilawah ? (tilawah.value ? 1.0 : 0.0) : 0) +
                    (_shaum
                        ? (seninKamis ? (shaum.value ? 1.0 : 0.0) : 1.0)
                        : 0) +
                    (_sedekah ? (sedekah.value ? 1.0 : 0.0) : 0) +
                    (_dzikir ? (dzikirPagi.value ? 1.0 : 0.0) : 0) +
                    (_dzikir ? (dzikirPetang.value ? 1.0 : 0.0) : 0) +
                    (_taklim ? (taklim.value ? 1.0 : 0.0) : 0) +
                    (_istighfar ? (istighfar.value ? 1.0 : 0.0) : 0) +
                    (_shalawat ? (shalawat.value ? 1.0 : 0.0) : 0)) /
                activatedCategory) *
            100)
        .roundToDouble();
    print('point.value: $point.value');
    shownPoint.value = point.value;
  }

  void setHiveData(List<HiveYaumiModel> hiveYaumiModel, DateTime tanggal) {
    final _result =
        hiveYaumiModel.where((element) => element.tanggal == tanggal);
    shubuh.value = _result.first.shubuh!;
    dhuhur.value = _result.first.dhuhur!;
    ashar.value = _result.first.ashar!;
    maghrib.value = _result.first.maghrib!;
    isya.value = _result.first.isya!;
    tahajud.value = _result.first.tahajud!;
    dhuha.value = _result.first.dhuha!;
    rawatib.value = _result.first.rawatib!;
    tilawah.value = _result.first.tilawah!;
    shaum.value = _result.first.shaum!;
    sedekah.value = _result.first.sedekah!;
    dzikirPagi.value = _result.first.dzikirPagi!;
    dzikirPetang.value = _result.first.dzikirPetang!;
    taklim.value = _result.first.taklim!;
    istighfar.value = _result.first.istighfar!;
    shalawat.value = _result.first.shalawat!;
    isSaved.value = _result.first.isSaved!;
    point.value = _result.first.point!;
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
