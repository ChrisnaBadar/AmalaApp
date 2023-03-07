import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../models/hive/boxes.dart';
import '../../../models/hive/hive_absen_model.dart';

class AbsenController extends GetxController {
  //variables - Semua - WFO - WFH - Ijin - Sakit
  RxString sortTitle = 'Semua'.obs;
  RxString sortValue = 'Semua'.obs;
  RxString choosenMonth =
      DateFormat('MMMM yyyy', "id_ID").format(DateTime.now()).obs;

  void sortationControl() {
    if (sortTitle.value == 'Semua') {
      sortTitle.value = 'WFO';
      sortValue.value = '*Work Form Office / Field* (WFO)';
    } else if (sortTitle.value == 'WFO') {
      sortTitle.value = 'WFH';
      sortValue.value = '*Work From Home* (WFH)';
    } else if (sortTitle.value == 'WFH') {
      sortTitle.value = 'Ijin';
      sortValue.value = 'Ijin';
    } else if (sortTitle.value == 'Ijin') {
      sortTitle.value = 'Sakit';
      sortValue.value = '*Sakit*';
    } else {
      sortTitle.value = 'Semua';
      sortValue.value = 'Semua';
    }
  }

  void setData(DateTime tanggal, String kehadiran, String lokasi,
      String keperluan, String tanggalIjin) {
    final hiveAbsenModel = HiveAbsenModel()
      ..date = tanggal
      ..tanggal = DateFormat('EEEE, dd MMMM yyyy', "id_ID").format(tanggal)
      ..waktu = DateFormat.jm().format(tanggal)
      ..kehadiran = kehadiran
      ..lokasi = lokasi
      ..keperluan = keperluan
      ..tanggalIjin = tanggalIjin;
    final box = Boxes.getAbsenModel();
    box.put(tanggal.toString(), hiveAbsenModel);
  }

  void deleteData(DateTime tanggal) {
    final box = Boxes.getAbsenModel();
    box.delete(tanggal.toString());
  }
}
