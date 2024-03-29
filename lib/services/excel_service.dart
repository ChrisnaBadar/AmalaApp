import 'dart:io';
import 'package:amala/constants/core_data.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

import '../models/absen_model.dart';
import '../models/yaumi_model.dart';

class ExcelService {
  final Workbook workbook = Workbook();
  var epoch = DateTime(1899, 12, 30);

  Future<void> generateAbsenSheet(
      {required List<AbsenModel> absenModel,
      required DateTime myDate,
      required String lembaga}) async {
    //Variables=================================
    final Worksheet sheet1 = workbook.worksheets[0];
    final Worksheet sheet2 = workbook.worksheets.addWithName('Sheet2');
    final wfo = CoreData.list[0];
    final wfh = CoreData.list[3];
    final ijin = CoreData.list[2];
    final sakit = CoreData.list[2];
    final colls = [
      "#",
      "A",
      "B",
      "C",
      "D",
      "E",
      "F",
      "G",
      "H",
      "I",
      "J",
      "K",
      "L",
      "M",
      "N",
      "O",
      "P",
      "Q",
      "R",
      "S",
      "T",
      "U",
      "V",
      "W",
      "X",
      "Y",
      "Z",
      "AA",
      "AB",
      "AC",
      "AD",
      "AE",
      "AF",
      "AG"
    ];
    final listNama = absenModel.map((e) => e.nama).toSet().toList();
    final bulan1 = DateFormat("MMMM", "id_ID").format(myDate);
    final bulan2 = DateFormat("MMMM", "id_ID")
        .format(myDate.add(const Duration(days: 30)));
    final tahunBerjalan = DateFormat("yyyy", "id_ID").format(myDate);
    final finalAbsen = absenModel
        .where((element) =>
            DateFormat('MMMM', "id_ID").format(element.date) == bulan1 ||
            DateFormat('MMMM', "id_ID").format(element.date) == bulan2)
        .toList();
    final sortedItem = finalAbsen
      ..sort((item1, item2) => item2.nama.compareTo(item1.nama));
    final intColAfterTable = listNama.length + 9;

    //Creating a new style with all properties.
    final Style headerStyle = workbook.styles.add('headerStyle');
    headerStyle.bold = true;
    headerStyle.fontSize = 14;
    headerStyle.fontColor = '#333333';

    final Style namaHeaderStyle = workbook.styles.add('namaHeaderStyle');
    namaHeaderStyle.bold = true;
    namaHeaderStyle.hAlign = HAlignType.center;
    namaHeaderStyle.vAlign = VAlignType.center;
    namaHeaderStyle.backColor = "#333333";
    namaHeaderStyle.fontColor = "#ffffff";
    namaHeaderStyle.borders.all.lineStyle = LineStyle.thick;
    namaHeaderStyle.borders.all.color = "#ffffff";

    final Style tanggalHeaderStyle = workbook.styles.add('tanggalHeaderStyle');
    tanggalHeaderStyle.bold = true;
    tanggalHeaderStyle.hAlign = HAlignType.center;
    tanggalHeaderStyle.backColor = "#333333";
    tanggalHeaderStyle.fontColor = "#ffffff";
    tanggalHeaderStyle.borders.all.lineStyle = LineStyle.thick;
    tanggalHeaderStyle.borders.all.color = "#ffffff";

    final Style tanggalHeaderFormatStyle =
        workbook.styles.add('tanggalHeaderFormatStyle');
    tanggalHeaderFormatStyle.hAlign = HAlignType.center;
    tanggalHeaderFormatStyle.bold = true;
    tanggalHeaderFormatStyle.numberFormat = 'dd';
    tanggalHeaderFormatStyle.backColor = "#333333";
    tanggalHeaderFormatStyle.fontColor = "#ffffff";
    tanggalHeaderFormatStyle.borders.all.lineStyle = LineStyle.thick;
    tanggalHeaderFormatStyle.borders.all.color = "#ffffff";

    final Style tableStyle = workbook.styles.add('tableStyle');
    tableStyle.backColor = "#eeeee4";
    tableStyle.fontColor = "#333333";
    tableStyle.borders.all.lineStyle = LineStyle.thick;
    tableStyle.borders.all.color = "#ffffff";

    final Style afterTable1 = workbook.styles.add('afterTable1');
    afterTable1.bold = true;
    afterTable1.backColor = "#333333";
    afterTable1.fontColor = "#ffffff";

    final Style afterTable2 = workbook.styles.add('afterTable2');
    afterTable2.backColor = "#eeeee4";
    afterTable2.fontColor = "#333333";

    //DATABASE (Sheet2)
    databaseSheetAbsen(sheet2, sortedItem);

    //REPORT TABLE (Sheet1)
    sheet1.showGridlines = false;
    headerDesignAbsen(
        sheet1, lembaga, bulan1, bulan2, tahunBerjalan, headerStyle);
    tableDesignAbsen(
        sheet1,
        wfo,
        wfh,
        ijin,
        sakit,
        listNama,
        colls,
        sortedItem,
        myDate,
        namaHeaderStyle,
        tanggalHeaderStyle,
        tanggalHeaderFormatStyle,
        tableStyle,
        intColAfterTable);
    afterTableAbsen(sheet1, intColAfterTable, wfo, wfh, ijin, sakit,
        afterTable1, afterTable2);

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final String path = (await getApplicationSupportDirectory()).path;
    final String fileName = '$path/AbsenOnline.xlsx';
    final File file = File(fileName);
    final XFile xFile = XFile(fileName);
    await file.writeAsBytes(bytes, flush: true);
    // .then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       content: Text('File Yaumi.xlsx telah disimpan di $value'),
    //       duration: const Duration(seconds: 10),
    //     )));
    //OpenFile.open(fileName);
    Share.shareXFiles([xFile]);
  }

  int julianDayNumber(DateTime date) => date.difference(epoch).inDays;

  //DATABASE===================================================================================================
  Worksheet databaseSheetAbsen(Worksheet sheet2, List<AbsenModel> sortedItem) {
    //Set Database Sheet (Sheet2)================
    List<ExcelDataRow> excelDataRows = [];
    excelDataRows = sortedItem.map<ExcelDataRow>((e) {
      return ExcelDataRow(cells: [
        ExcelDataCell(
            columnHeader: 'helper',
            value: '${e.nama}${julianDayNumber(e.date)}'),
        ExcelDataCell(columnHeader: 'nama', value: e.nama),
        ExcelDataCell(columnHeader: 'tanggal', value: julianDayNumber(e.date)),
        ExcelDataCell(columnHeader: 'status', value: e.kehadiran)
      ]);
    }).toList();
    sheet2.importData(excelDataRows, 1, 1);
    sheet2.getRangeByName('A1:D1').columnWidth = 0.1;
    return sheet2;
  }

  //HEADER===================================================================================================
  Worksheet headerDesignAbsen(
    Worksheet sheet1,
    String lembaga,
    bulan1,
    bulan2,
    tahunBerjalan,
    Style headerStyle,
  ) {
    //set Report Sheet (Sheet1)============================
    sheet1.getRangeByName('A1').setText('LAPORAN ABSEN $lembaga');
    sheet1.getRangeByName('A1:AF1').merge();
    sheet1.getRangeByName('A1').cellStyle = headerStyle;
    sheet1
        .getRangeByName('A2')
        .setText('Tanggal 21 $bulan1 - 20 $bulan2 $tahunBerjalan');
    sheet1.getRangeByName('A2:AF2').merge();
    sheet1.getRangeByName('A2').cellStyle = headerStyle;
    return sheet1;
  }

  //TABLE===================================================================================================
  Worksheet tableDesignAbsen(
      Worksheet sheet1,
      String wfo,
      wfh,
      ijin,
      sakit,
      List<String> listNama,
      colls,
      List<AbsenModel> sortedItem,
      DateTime myDate,
      Style namaHeaderStyle,
      tanggalHeaderStyle,
      tanggalHeaderFormatStyle,
      tableStyle,
      int intColAfterTable) {
    //Table Design
    sheet1.getRangeByName('A5').setText('Nama');
    sheet1.getRangeByName('A4:A5').merge();
    sheet1.getRangeByName('A4:A5').cellStyle = namaHeaderStyle;

    sheet1.getRangeByName('B4').setText('TANGGAL');
    sheet1.getRangeByName('B4:AF4').merge();
    sheet1.getRangeByName('B4:AF4').cellStyle = tanggalHeaderStyle;

    //Import Nama-nama anggota
    sheet1.importList(listNama, 6, 1, true);
    //import tanggal dari 21 bulanSebelum - 20 bulanBerjalan
    sheet1.importList(
        List.generate(31, (index) => myDate.add(Duration(days: index))),
        5,
        2,
        false);
    sheet1.getRangeByName('B5:AF5').cellStyle = tanggalHeaderFormatStyle;

    //Formula Vlookup Google Sheet
    for (var i = 0; i < 31; i++) {
      sheet1.importList(
          List.generate(listNama.length, //reference data anggota
              (index) {
            return sheet1.getRangeByName('${colls[i + 2]}${index + 6}').setFormula(
                'IFERROR(IF(VLOOKUP(A${index + 6}&${colls[i + 2]}5,Sheet2!A2:D${sortedItem.length},4,FALSE)=C$intColAfterTable,B$intColAfterTable,IF(VLOOKUP(A${index + 6}&${colls[i + 2]}5,Sheet2!A2:D${sortedItem.length},4,FALSE)=C${intColAfterTable + 1},B${intColAfterTable + 1},IF(VLOOKUP(A${index + 6}&${colls[i + 2]}5,Sheet2!A2:D${sortedItem.length},4,FALSE)=C${intColAfterTable + 2},B${intColAfterTable + 2},IF(VLOOKUP(A${index + 6}&${colls[i + 2]}5,Sheet2!A2:D${sortedItem.length},4,FALSE)=C${intColAfterTable + 3},B${intColAfterTable + 3},B${intColAfterTable + 4})))),0)');

            // 'IFERROR(IF(VLOOKUP(A${index + 6}&${colls[i + 2]}5,Sheet2!A2:D${sortedItem.length},4,FALSE)=C$intColAfterTable,B$intColAfterTable,VLOOKUP(A${index + 6}&${colls[i + 2]}5,Sheet2!A2:D${sortedItem.length},4,FALSE)=C${intColAfterTable + 1},B${intColAfterTable + 1},VLOOKUP(A${index + 6}&${colls[i + 2]}5,Sheet2!A2:D${sortedItem.length},4,FALSE)=C${intColAfterTable + 2},B${intColAfterTable + 2},VLOOKUP(A${index + 6}&${colls[i + 2]}5,Sheet2!A2:D${sortedItem.length},4,FALSE)=C${intColAfterTable + 3},B${intColAfterTable + 3},B${intColAfterTable + 4}),0)'

            //'VLOOKUP(A${index + 6}&${colls[i + 2]}5,Sheet2!A2:D${sortedItem.length},4,FALSE)'
            //Formula Excel
            // sheet1.getRangeByName('${colls[i+2]}${index+6}').setFormula('IFERROR(IF(LOOKUP(2;1/(Sheet2!A2:A134=Sheet1!A${index+6})/(Sheet2!B2:B134=Sheet1!${colls[i+2]}5);(Sheet2!C2:C134))=$wfo;"O";IF(LOOKUP(2;1/(Sheet2!A2:A134=Sheet1!A${index+6})/(Sheet2!B2:B134=Sheet1!${colls[i+2]}5);(Sheet2!C2:C134))=$ijin;"I";IF(LOOKUP(2;1/(Sheet2!A2:A134=Sheet1!A${index+6})/(Sheet2!B2:B134=Sheet1!${colls[i+2]}5);(Sheet2!C2:C134))=$sakit;"S";"X")));"")');
          }),
          6,
          i + 2,
          true);
    }

    sheet1.getRangeByName('A5:A${listNama.length + 6}').autoFitColumns();
    sheet1.getRangeByName('B5:AF5').columnWidth = 2.5;
    sheet1.getRangeByName('A6:AF${listNama.length + 5}').cellStyle = tableStyle;
    return sheet1;
  }

  //AFTER TABLE===================================================================================================
  Worksheet afterTableAbsen(Worksheet sheet1, int intColAfterTable, String wfo,
      wfh, ijin, sakit, Style afterTable1, afterTable2) {
    //After table param
    sheet1.getRangeByIndex(intColAfterTable - 1, 2).setValue('Keterangan: ');
    sheet1.getRangeByIndex(intColAfterTable, 2).setValue('W');
    sheet1.getRangeByIndex(intColAfterTable + 1, 2).setValue('H');
    sheet1.getRangeByIndex(intColAfterTable + 2, 2).setValue('I');
    sheet1.getRangeByIndex(intColAfterTable + 3, 2).setValue('S');
    sheet1.getRangeByIndex(intColAfterTable + 4, 2).setValue('0');

    //after table info
    sheet1.getRangeByIndex(intColAfterTable, 3).setValue(wfo);
    sheet1.getRangeByIndex(intColAfterTable + 1, 3).setValue(wfh);
    sheet1.getRangeByIndex(intColAfterTable + 2, 3).setValue(ijin);
    sheet1.getRangeByIndex(intColAfterTable + 3, 3).setValue(sakit);
    sheet1
        .getRangeByIndex(intColAfterTable + 4, 3)
        .setValue('Tidak Mengisi Absen');

    sheet1
        .getRangeByIndex(intColAfterTable - 1, 2, intColAfterTable - 1, 16)
        .cellStyle = afterTable1;

    sheet1
        .getRangeByIndex(intColAfterTable, 2, intColAfterTable + 4, 16)
        .cellStyle = afterTable2;

    sheet1.getRangeByIndex(intColAfterTable + 6, 2).setValue(
        '1. Jika angka tidak muncul atau error di Sheet1 maka highlight seluruh kolom C di Sheet 2.');
    sheet1.getRangeByIndex(intColAfterTable + 7, 2).setValue(
        '2. Pilih "Format" - "Number" - "Date" untuk merubah tipe data di kolom C menjadi tanggal.');
    sheet1.getRangeByIndex(intColAfterTable + 8, 2).setValue(
        '3. Jika masih error kemungkinan formula GSheet telah terupdate.');
    sheet1.getRangeByIndex(intColAfterTable + 9, 2).setValue(
        '4. Jika itu terjadi silahkan mengacu pada nilai angka anggota di Sheet2 untuk membuat formula baru.');

    return sheet1;
  }

// █▄█ ▄▀█ █░█ █▀▄▀█ █
// ░█░ █▀█ █▄█ █░▀░█ █

  Future<void> generateYaumiSheet(
      {required List<YaumiModel> yaumiModel,
      required DateTime myDate,
      required String lembaga}) async {
    //Variables=================================
    final Worksheet sheet1 = workbook.worksheets[0];
    final Worksheet sheet2 = workbook.worksheets.addWithName('Sheet2');
    final colls = [
      "#",
      "A",
      "B",
      "C",
      "D",
      "E",
      "F",
      "G",
      "H",
      "I",
      "J",
      "K",
      "L",
      "M",
      "N",
      "O",
      "P",
      "Q",
      "R",
      "S",
      "T",
      "U",
      "V",
      "W",
      "X",
      "Y",
      "Z",
      "AA",
      "AB",
      "AC",
      "AD",
      "AE",
      "AF",
      "AG"
    ];
    final listNama = yaumiModel.map((e) => e.nama).toSet().toList();
    final bulan1 = DateFormat("MMMM", "id_ID").format(myDate);
    final bulan2 = DateFormat("MMMM", "id_ID")
        .format(myDate.add(const Duration(days: 30)));
    final finalAbsen = yaumiModel
        .where((element) =>
            DateFormat("MMMM", "id_ID").format(element.date) == bulan1 ||
            DateFormat("MMMM", "id_ID").format(element.date) == bulan2)
        .toList();
    final sortedItem = finalAbsen
      ..sort((item1, item2) => item2.nama.compareTo(item1.nama));
    final intColAfterTable = listNama.length + 9;

    //Creating a new style with all properties.
    final Style headerStyle = workbook.styles.add('headerStyle');
    headerStyle.bold = true;
    headerStyle.fontSize = 14;
    headerStyle.fontColor = '#333333';

    final Style namaHeaderStyle = workbook.styles.add('namaHeaderStyle');
    namaHeaderStyle.bold = true;
    namaHeaderStyle.hAlign = HAlignType.center;
    namaHeaderStyle.vAlign = VAlignType.center;
    namaHeaderStyle.backColor = "#333333";
    namaHeaderStyle.fontColor = "#ffffff";
    namaHeaderStyle.borders.all.lineStyle = LineStyle.thick;
    namaHeaderStyle.borders.all.color = "#ffffff";

    final Style tanggalHeaderStyle = workbook.styles.add('tanggalHeaderStyle');
    tanggalHeaderStyle.bold = true;
    tanggalHeaderStyle.hAlign = HAlignType.center;
    tanggalHeaderStyle.backColor = "#333333";
    tanggalHeaderStyle.fontColor = "#ffffff";
    tanggalHeaderStyle.borders.all.lineStyle = LineStyle.thick;
    tanggalHeaderStyle.borders.all.color = "#ffffff";

    final Style databaseTanggalStyle =
        workbook.styles.add('databaseTanggalStyle');
    databaseTanggalStyle.numberFormat = 'dd/MM/yyyy';

    final Style tanggalHeaderFormatStyle =
        workbook.styles.add('tanggalHeaderFormatStyle');
    tanggalHeaderFormatStyle.hAlign = HAlignType.center;
    tanggalHeaderFormatStyle.bold = true;
    tanggalHeaderFormatStyle.numberFormat = 'dd';
    tanggalHeaderFormatStyle.backColor = "#333333";
    tanggalHeaderFormatStyle.fontColor = "#ffffff";
    tanggalHeaderFormatStyle.borders.all.lineStyle = LineStyle.thick;
    tanggalHeaderFormatStyle.borders.all.color = "#ffffff";

    final Style tableStyle = workbook.styles.add('tableStyle');
    tableStyle.backColor = "#eeeee4";
    tableStyle.fontColor = "#333333";
    tableStyle.borders.all.lineStyle = LineStyle.thick;
    tableStyle.borders.all.color = "#ffffff";

    final Style afterTable1 = workbook.styles.add('afterTable1');
    afterTable1.bold = true;
    afterTable1.backColor = "#333333";
    afterTable1.fontColor = "#ffffff";

    final Style afterTable2 = workbook.styles.add('afterTable2');
    afterTable2.backColor = "#eeeee4";
    afterTable2.fontColor = "#333333";

    //Worksheets Design and Data
    databaseSheetYaumi(sheet2, sortedItem, databaseTanggalStyle);
    //mainSheet
    headerDesignYaumi(sheet1, lembaga, bulan1, bulan2,
        DateFormat.y().format(DateTime.now()), headerStyle);
    tableDesignYaumi(
        sheet1,
        listNama,
        colls,
        sortedItem,
        myDate,
        namaHeaderStyle,
        tanggalHeaderStyle,
        tanggalHeaderFormatStyle,
        tableStyle);
    afterTableYaumi(sheet1, intColAfterTable);

    // (await getApplicationSupportDirectory()).path;
    // Directory('/storage/emulated/0/Download').path;
    //Final Steps
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    final String path = (await getApplicationSupportDirectory()).path;
    final String fileName = '$path/YaumiReport.xlsx';
    final File file = File(fileName);
    final XFile xFile = XFile(fileName);
    await file.writeAsBytes(bytes, flush: true);
    // .then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       content: Text('File Yaumi.xlsx telah disimpan di $value'),
    //       duration: const Duration(seconds: 10),
    //     )));
    //OpenFile.open(fileName);
    Share.shareXFiles([xFile]);
  }

  //DATABASE=====YAUMI===================================================================================================
  Worksheet databaseSheetYaumi(Worksheet sheet2, List<YaumiModel> sortedItem,
      Style databaseTanggalStyle) {
    //Set Database Sheet (Sheet2)================
    // List<ExcelDataRow> excelDataRows = [];
    // excelDataRows = sortedItem.map<ExcelDataRow>((e) {
    //   return ExcelDataRow(cells: [
    //     ExcelDataCell(columnHeader: 'nama', value: e.nama),
    //     ExcelDataCell(
    //         columnHeader: 'tanggal',
    //         value: DateTime.parse(DateFormat('yyyy-MM-dd').format(e.date))),
    //     ExcelDataCell(columnHeader: 'poin', value: e.poinHariIni)
    //   ]);
    // }).toList();
    //sheet2.importData(excelDataRows, 1, 1);
    //sheet2.getRangeByName('B1:D1').columnWidth = 15.1;
    sheet2.getRangeByName('A1').setText('Helper');
    sheet2.getRangeByName('A1').columnWidth = 1;
    sheet2.getRangeByName('B1').setText('Nama');
    sheet2.getRangeByName('C1').setText('Tanggal');
    sheet2.getRangeByName('D1').setText('Poin');
    sheet2.importList(
        List.generate(
            sortedItem.length,
            (index) => sheet2
                .getRangeByName('A${index + 2}')
                .setFormula('B${index + 2}&C${index + 2}')),
        2,
        1,
        true);
    sheet2.importList(sortedItem.map((e) => e.nama).toList(), 2, 2, true);
    sheet2.importList(
        sortedItem.map((e) => julianDayNumber(e.date)).toList(), 2, 3, true);
    sheet2.getRangeByName('C2:C${sortedItem.length}').cellStyle =
        databaseTanggalStyle;
    sheet2.importList(
        sortedItem.map((e) => e.poinHariIni).toList(), 2, 4, true);
    // for (var i = 0; i < sortedItem.length; i++) {
    //   sheet2.importList(
    //       List.generate(
    //           sortedItem.length,
    //           (index) => sheet2
    //               .getRangeByName('A${i + 2}')
    //               .setFormula('B${i + 2}&C${i + 2}')),
    //       1,
    //       1,
    //       true);
    // }
    return sheet2;
  }

  //HEADER===================================================================================================
  Worksheet headerDesignYaumi(
    Worksheet sheet1,
    String lembaga,
    bulan1,
    bulan2,
    tahunBerjalan,
    Style headerStyle,
  ) {
    //set Report Sheet (Sheet1)============================
    sheet1.getRangeByName('A1').setText('LAPORAN YAUMI $lembaga');
    sheet1.getRangeByName('A1:AF1').merge();
    sheet1.getRangeByName('A1').cellStyle = headerStyle;
    sheet1
        .getRangeByName('A2')
        .setText('Tanggal 11 $bulan1 - 10 $bulan2 $tahunBerjalan');
    sheet1.getRangeByName('A2:AF2').merge();
    sheet1.getRangeByName('A2').cellStyle = headerStyle;
    return sheet1;
  }

  //TABLE===================================================================================================
  Worksheet tableDesignYaumi(
      Worksheet sheet1,
      List listNama,
      colls,
      List<YaumiModel> sortedItem,
      DateTime myDate,
      Style namaHeaderStyle,
      tanggalHeaderStyle,
      tanggalHeaderFormatStyle,
      tableStyle) {
    //Table Design
    sheet1.getRangeByName('A5').setText('Nama');
    sheet1.getRangeByName('A4:A5').merge();
    sheet1.getRangeByName('A4:A5').cellStyle = namaHeaderStyle;

    sheet1.getRangeByName('B4').setText('TANGGAL');
    sheet1.getRangeByName('B4:AF4').merge();
    sheet1.getRangeByName('B4:AF4').cellStyle = tanggalHeaderStyle;

    //Import Nama-nama anggota
    sheet1.importList(listNama, 6, 1, true);
    //import tanggal dari 21 bulanSebelum - 20 bulanBerjalan
    sheet1.importList(
        List.generate(
            31, (index) => julianDayNumber(myDate.add(Duration(days: index)))),
        5,
        2,
        false);
    sheet1.getRangeByName('B5:AF5').cellStyle = tanggalHeaderFormatStyle;

    //Formula Vlookup Google Sheet
    for (var i = 0; i < 31; i++) {
      sheet1.importList(
          List.generate(listNama.length, //reference data anggota
              (index) {
            return sheet1.getRangeByName('${colls[i + 2]}${index + 6}').setFormula(
                'IFERROR(VLOOKUP(A${index + 6}&${colls[i + 2]}5,Sheet2!A2:D${sortedItem.length + 1},4,FALSE),0)');

            //old formula
            // 'IFERROR(ROUNDUP(ARRAYFORMULA(VLOOKUP(A${index + 6}&" "&${colls[i + 2]}5,{Sheet2!A2:A${sortedItem.length}&" "&Sheet2!B2:B${sortedItem.length},Sheet2!C2:C${sortedItem.length}},2,FALSE))),"")'

            //new formula
            //=VLOOKUP(A${index+6}&${colls[i+2]}5,Sheet2!A2:D${sortedItem.length+1},4,FALSE);
          }),
          6,
          i + 2,
          true);
    }

    sheet1.getRangeByName('A5:A${listNama.length + 6}').autoFitColumns();
    sheet1.getRangeByName('B5:AF5').columnWidth = 3.5;
    sheet1.getRangeByName('A6:AF${listNama.length + 5}').cellStyle = tableStyle;
    return sheet1;
  }

  //AFTER TABLE===================================================================================================
  Worksheet afterTableYaumi(Worksheet sheet1, int intColAfterTable) {
    //After table param
    sheet1.getRangeByIndex(intColAfterTable - 1, 2).setValue('Keterangan: ');
    sheet1.getRangeByIndex(intColAfterTable, 2).setValue(
        '1. Jika angka tidak muncul atau error di Sheet1 maka highlight seluruh kolom C di Sheet 2.');
    sheet1.getRangeByIndex(intColAfterTable + 1, 2).setValue(
        '2. Pilih "Format" - "Number" - "Date" untuk merubah tipe data di kolom C menjadi tanggal.');
    sheet1.getRangeByIndex(intColAfterTable + 2, 2).setValue(
        '3. Jika masih error kemungkinan formula GSheet telah terupdate.');
    sheet1.getRangeByIndex(intColAfterTable + 3, 2).setValue(
        '4. Jika itu terjadi silahkan mengacu pada nilai angka anggota di Sheet2 untuk membuat formula baru.');
    return sheet1;
  }
}
