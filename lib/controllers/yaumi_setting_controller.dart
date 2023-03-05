import 'package:amala/models/hive/boxes.dart';
import 'package:amala/models/hive/hive_yaumi_active_model.dart';
import 'package:get/get.dart';

class YaumiSettingController extends GetxController {
  //Bool Parameter
  RxBool fardhu = false.obs,
      tahajud = false.obs,
      dhuha = false.obs,
      rawatib = false.obs,
      tilawah = false.obs,
      shaum = false.obs,
      sedekah = false.obs,
      dzikir = false.obs,
      taklim = false.obs,
      istighfar = false.obs,
      shalawat = false.obs;

  void setFirstActivator() {
    final hiveYaumiActiveModel = HiveYaumiActiveModel()
      ..fardhu = false
      ..tahajud = false
      ..dhuha = false
      ..rawatib = false
      ..tilawah = false
      ..shaum = false
      ..sedekah = false
      ..dzikir = false
      ..taklim = false
      ..istighfar = false
      ..shalawat = false;

    final box = Boxes.getYaumiActiveModel();
    box.put('hiveYaumiActiveModel', hiveYaumiActiveModel);
  }

  // void updateFardhuData(data) {
  //   final yaumiHiveModel = YaumiHiveModel()..shalatFardhuIsActive = data;
  //   final box = Boxes.getModel();
  //   box.put('yaumi', yaumiHiveModel);
  // }

  // void updateTahajudData(data) {
  //   final yaumiHiveModel = YaumiHiveModel()..tahajudIsActive = data;
  //   final box = Boxes.getModel();
  //   box.put('yaumi', yaumiHiveModel);
  // }

  void updateData() {
    final hiveYaumiActiveModel = HiveYaumiActiveModel()
      ..fardhu = fardhu.value
      ..tahajud = tahajud.value
      ..dhuha = dhuha.value
      ..rawatib = rawatib.value
      ..tilawah = tilawah.value
      ..shaum = shaum.value
      ..sedekah = sedekah.value
      ..dzikir = dzikir.value
      ..taklim = taklim.value
      ..istighfar = istighfar.value
      ..shalawat = shalawat.value;

    final box = Boxes.getYaumiActiveModel();
    box.put('hiveYaumiActiveModel', hiveYaumiActiveModel);
  }

  void setHiveData(List<HiveYaumiActiveModel> hiveYaumiActiveModel) {
    //cari data di yaumiHive
    var fardhuActivated = hiveYaumiActiveModel.first.fardhu;
    var tahajudActivated = hiveYaumiActiveModel.first.tahajud;
    var dhuhaActivated = hiveYaumiActiveModel.first.dhuha;
    var rawatibActivated = hiveYaumiActiveModel.first.rawatib;
    var tilawahActivated = hiveYaumiActiveModel.first.tilawah;
    var shaumActivated = hiveYaumiActiveModel.first.shaum;
    var sedekahActivated = hiveYaumiActiveModel.first.sedekah;
    var dzikirActivated = hiveYaumiActiveModel.first.dzikir;
    var taklimActivated = hiveYaumiActiveModel.first.taklim;
    var shalawatActivated = hiveYaumiActiveModel.first.shalawat;
    var istighfarActivated = hiveYaumiActiveModel.first.istighfar;

    //Transfer data dari YaumiHive ke Controller
    fardhu.value = fardhuActivated!;
    tahajud.value = tahajudActivated!;
    dhuha.value = dhuhaActivated!;
    rawatib.value = rawatibActivated!;
    tilawah.value = tilawahActivated!;
    shaum.value = shaumActivated!;
    sedekah.value = sedekahActivated!;
    dzikir.value = dzikirActivated!;
    taklim.value = taklimActivated!;
    shalawat.value = shalawatActivated!;
    istighfar.value = istighfarActivated!;
  }
}
