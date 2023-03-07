import 'package:amala/constants/my_strings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/hive/hive_yaumi_active_model.dart';
import '../../../models/hive/hive_yaumi_model.dart';
import '../data/log_data.dart';

class YaumiLogDetails extends StatefulWidget {
  final HiveYaumiModel? hiveYaumiModel;
  final HiveYaumiActiveModel? hiveYaumiActiveModel;
  final List? tanggal;
  YaumiLogDetails(
      {this.hiveYaumiModel, this.hiveYaumiActiveModel, this.tanggal});

  @override
  State<YaumiLogDetails> createState() => _YaumiLogDetailsState();
}

class _YaumiLogDetailsState extends State<YaumiLogDetails> {
  final _myData = LogData().myLogData;

  @override
  Widget build(BuildContext context) {
    List _data = [
      widget.hiveYaumiModel!.tanggal.toString(),
      widget.hiveYaumiModel!.shubuh.toString(),
      widget.hiveYaumiModel!.tahajud.toString(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Aktivitas Yaumi'),
        actions: [
          IconButton(
              onPressed: null,
              icon: Icon(
                Icons.delete_outline,
                color: Colors.white,
              ))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //TANGGAL & STATUS cloud saving
              _tanggalNstatus(),

              //title category
              _categoryTitleNdetails(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tanggalNstatus() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
              height: 50.0,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    MyStrings.calenderIconColor,
                    scale: 3,
                  ),
                  SizedBox(
                    width: 6.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Tanggal',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                          DateFormat('EEEE, dd MMM yyy', "id_ID")
                              .format(widget.hiveYaumiModel!.tanggal!),
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.blueGrey,
                              fontSize: 12.0)),
                    ],
                  )
                ],
              )),
        ),
        Expanded(
          flex: 1,
          child: Container(
              height: 50.0,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    MyStrings.docIconColor,
                    scale: 3,
                  ),
                  SizedBox(
                    width: 6.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Cloud Save',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      widget.tanggal!.contains(
                              DateFormat('EEEE, dd MMMM yyyy', "id_ID")
                                  .format(widget.hiveYaumiModel!.tanggal!))
                          ? Text('Tersimpan',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.green))
                          : Text('Tidak Tersimpan',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.red)),
                    ],
                  )
                ],
              )),
        ),
      ],
    );
  }

  Widget _categoryTitleNdetails() {
    //Active List
    List activeCategory = [
      widget.hiveYaumiActiveModel!.fardhu,
      widget.hiveYaumiActiveModel!.tahajud,
      widget.hiveYaumiActiveModel!.dhuha,
      widget.hiveYaumiActiveModel!.rawatib,
      widget.hiveYaumiActiveModel!.tilawah,
      widget.hiveYaumiActiveModel!.shaum,
      widget.hiveYaumiActiveModel!.sedekah,
      widget.hiveYaumiActiveModel!.dzikir,
      widget.hiveYaumiActiveModel!.taklim,
      widget.hiveYaumiActiveModel!.istighfar,
      widget.hiveYaumiActiveModel!.shalawat
    ];
    //PARAMETER LIST
    List fardhuList = [
      widget.hiveYaumiModel!.shubuh,
      widget.hiveYaumiModel!.dhuhur,
      widget.hiveYaumiModel!.ashar,
      widget.hiveYaumiModel!.maghrib,
      widget.hiveYaumiModel!.isya
    ];
    List dzikirList = [
      widget.hiveYaumiModel!.dzikirPagi,
      widget.hiveYaumiModel!.dzikirPetang
    ];
    List categoryList = [
      false,
      widget.hiveYaumiModel!.tahajud,
      widget.hiveYaumiModel!.dhuha,
      widget.hiveYaumiModel!.rawatib,
      widget.hiveYaumiModel!.tilawah,
      widget.hiveYaumiModel!.shaum,
      widget.hiveYaumiModel!.sedekah,
      false,
      widget.hiveYaumiModel!.taklim,
      widget.hiveYaumiModel!.istighfar,
      widget.hiveYaumiModel!.shalawat
    ];
    return ListView.builder(
      itemCount: _myData.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 35.0,
                alignment: Alignment.centerLeft,
                child: activeCategory[index]
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 6.0),
                          Text(_myData[index]['title'],
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold)),
                          SizedBox(height: 6.0),
                          Container(
                            height: .5,
                            color: Colors.green,
                          ),
                        ],
                      )
                    : Container(),
              ),
              index == 0
                  ? activeCategory[0]
                      ? ListView.builder(
                          itemCount: _myData[0]['list'].length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _myData[0]['list'][index]['title'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 6.0),
                              fardhuList[index]
                                  ? Row(
                                      children: [
                                        Image.asset(
                                          MyStrings.checkedIconColor,
                                          scale: 3,
                                        ),
                                        SizedBox(
                                          width: 6.0,
                                        ),
                                        Text(
                                          _myData[0]['list'][index][true],
                                          style: _trueStyle(),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        Image.asset(
                                          MyStrings.cancelIconColor,
                                          scale: 3,
                                        ),
                                        SizedBox(
                                          width: 6.0,
                                        ),
                                        Text(
                                          _myData[0]['list'][index][false],
                                          style: _falseStyle(),
                                        ),
                                      ],
                                    )
                            ],
                          ),
                        )
                      : Container()
                  : index == 7
                      ? activeCategory[7]
                          ? ListView.builder(
                              itemCount: _myData[7]['list'].length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _myData[7]['list'][index]['title'],
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 6.0),
                                  dzikirList[index]
                                      ? Row(
                                          children: [
                                            Image.asset(
                                              MyStrings.checkedIconColor,
                                              scale: 3,
                                            ),
                                            SizedBox(
                                              width: 6.0,
                                            ),
                                            Text(
                                              _myData[7]['list'][index][true],
                                              style: _trueStyle(),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            Image.asset(
                                              MyStrings.cancelIconColor,
                                              scale: 3,
                                            ),
                                            SizedBox(
                                              width: 6.0,
                                            ),
                                            Text(
                                              _myData[7]['list'][index][false],
                                              style: _falseStyle(),
                                            ),
                                          ],
                                        )
                                ],
                              ),
                            )
                          : Container()
                      : activeCategory[index]
                          ? categoryList[index]
                              ? Row(
                                  children: [
                                    Image.asset(
                                      MyStrings.checkedIconColor,
                                      scale: 3,
                                    ),
                                    SizedBox(
                                      width: 6.0,
                                    ),
                                    Text(
                                      _myData[index][true],
                                      style: _trueStyle(),
                                    ),
                                  ],
                                )
                              : Row(
                                  children: [
                                    Image.asset(
                                      MyStrings.cancelIconColor,
                                      scale: 3,
                                    ),
                                    SizedBox(
                                      width: 6.0,
                                    ),
                                    Text(
                                      _myData[index][false],
                                      style: _falseStyle(),
                                    ),
                                  ],
                                )
                          : Container(),
              SizedBox(
                height: 16.0,
              )
            ],
          ),
        );
      },
    );
  }

  TextStyle _trueStyle() {
    return TextStyle(
      color: Colors.green,
    );
  }

  TextStyle _falseStyle() {
    return TextStyle(
      color: Colors.red,
    );
  }
}
