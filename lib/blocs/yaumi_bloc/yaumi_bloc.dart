import 'dart:ffi';

import 'package:amala/blocs/bloc_exports.dart';
import 'package:bloc/bloc.dart';
import 'package:amala/models/yaumi_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'yaumi_event.dart';
part 'yaumi_state.dart';

class YaumiBloc extends HydratedBloc<YaumiEvent, YaumiState> {
  YaumiBloc() : super(const YaumiState()) {
    on<AddYaumiEvent>(_onAddYaumiEvent);
    on<UpdateShubuhEvent>(_onUpdateEvent);
    on<UpdateDhuhurEvent>(_onUpdateEvent);
    on<UpdateAsharEvent>(_onUpdateEvent);
    on<UpdateMaghribEvent>(_onUpdateEvent);
    on<UpdateIsyaEvent>(_onUpdateEvent);
    on<UpdateTahajudEvent>(_onUpdateEvent);
    on<UpdateRawatibEvent>(_onUpdateEvent);
    on<UpdateDhuhaEvent>(_onUpdateEvent);
    on<UpdateIncrementTilawahEvent>(_onUpdateEvent);
    on<UpdateDecrementTilawahEvent>(_onUpdateEvent);
    on<UpdateShaumEvent>(_onUpdateEvent);
    on<UpdateSedekahEvent>(_onUpdateEvent);
    on<UpdateDzikirPagiEvent>(_onUpdateEvent);
    on<UpdateDzikirPetangEvent>(_onUpdateEvent);
    on<UpdateTaklimEvent>(_onUpdateEvent);
    on<UpdateIstighfarEvent>(_onUpdateEvent);
    on<UpdateShalawatEvent>(_onUpdateEvent);
    on<DeleteYaumiEvent>(_onDeleteYaumi);
    on<UploadedStateDataEvent>(_onUploadedStateDataEvent);
  }

  void _onUploadedStateDataEvent(
      UploadedStateDataEvent event, Emitter<YaumiState> emit) {
    final state = this.state;
    final yaumi = event.yaumi;
    List<YaumiModel> allYaumis = List.from(state.allYaumis)..remove(yaumi);
    allYaumis.add(yaumi.copyWith(isSubmitted: true));
    emit(YaumiState(allYaumis: allYaumis));
  }

  void _onAddYaumiEvent(AddYaumiEvent event, Emitter<YaumiState> emit) {
    final state = this.state;
    emit(YaumiState(allYaumis: List.from(state.allYaumis)..add(event.yaumi)));
  }

  void _onUpdateEvent(dynamic event, Emitter<YaumiState> emit) {
    final state = this.state;
    final yaumi = event.yaumi;
    final poin = event.poinHariIni;
    List<YaumiModel> allYaumis = List.from(state.allYaumis)..remove(yaumi);
    switch (event.runtimeType) {
      case UpdateShubuhEvent:
        allYaumis.add(yaumi.copyWith(
            shubuh: !(yaumi.shubuh),
            poinHariIni: !(yaumi.shubuh)
                ? yaumi.poinHariIni + poin
                : yaumi.poinHariIni - poin));
        break;
      case UpdateDhuhurEvent:
        allYaumis.add(yaumi.copyWith(
            dhuhur: !(yaumi.dhuhur),
            poinHariIni: !(yaumi.dhuhur)
                ? yaumi.poinHariIni + poin
                : yaumi.poinHariIni - poin));
        break;
      case UpdateAsharEvent:
        allYaumis.add(yaumi.copyWith(
            ashar: !(yaumi.ashar),
            poinHariIni: !(yaumi.ashar)
                ? yaumi.poinHariIni + poin
                : yaumi.poinHariIni - poin));
        break;
      case UpdateMaghribEvent:
        allYaumis.add(yaumi.copyWith(
            maghrib: !(yaumi.maghrib),
            poinHariIni: !(yaumi.maghrib)
                ? yaumi.poinHariIni + poin
                : yaumi.poinHariIni - poin));
        break;
      case UpdateIsyaEvent:
        allYaumis.add(yaumi.copyWith(
            isya: !(yaumi.isya),
            poinHariIni: !(yaumi.isya)
                ? yaumi.poinHariIni + poin
                : yaumi.poinHariIni - poin));
        break;
      case UpdateTahajudEvent:
        allYaumis.add(yaumi.copyWith(
            tahajud: !(yaumi.tahajud),
            poinHariIni: !(yaumi.tahajud)
                ? yaumi.poinHariIni + poin
                : yaumi.poinHariIni - poin));
        break;
      case UpdateRawatibEvent:
        allYaumis.add(yaumi.copyWith(
            rawatib: !(yaumi.rawatib),
            poinHariIni: !(yaumi.rawatib)
                ? yaumi.poinHariIni + poin
                : yaumi.poinHariIni - poin));
        break;
      case UpdateDhuhaEvent:
        allYaumis.add(yaumi.copyWith(
            dhuha: !(yaumi.dhuha),
            poinHariIni: !(yaumi.dhuha)
                ? yaumi.poinHariIni + poin
                : yaumi.poinHariIni - poin));
        break;
      case UpdateIncrementTilawahEvent:
        allYaumis.add(yaumi.copyWith(
            tilawah: (yaumi.tilawah) < 10
                ? yaumi.tilawah + poin.toInt()
                : yaumi.tilawah,
            poinHariIni: (yaumi.tilawah) < 10
                ? yaumi.poinHariIni + poin
                : yaumi.poinHariIni));
        break;
      case UpdateDecrementTilawahEvent:
        allYaumis.add(yaumi.copyWith(
            tilawah: (yaumi.tilawah) > 0
                ? yaumi.tilawah - poin.toInt()
                : yaumi.tilawah,
            poinHariIni: (yaumi.tilawah) > 0
                ? yaumi.poinHariIni - poin
                : yaumi.poinHariIni));
        break;
      case UpdateShaumEvent:
        allYaumis.add(yaumi.copyWith(
            shaum: !(yaumi.shaum),
            poinHariIni: !(yaumi.shaum)
                ? yaumi.poinHariIni + poin
                : yaumi.poinHariIni - poin));
        break;
      case UpdateSedekahEvent:
        allYaumis.add(yaumi.copyWith(
            sedekah: !(yaumi.sedekah),
            poinHariIni: !(yaumi.sedekah)
                ? yaumi.poinHariIni + poin
                : yaumi.poinHariIni - poin));
        break;
      case UpdateDzikirPagiEvent:
        allYaumis.add(yaumi.copyWith(
            dzikirPagi: !(yaumi.dzikirPagi),
            poinHariIni: !(yaumi.dzikirPagi)
                ? yaumi.poinHariIni + poin
                : yaumi.poinHariIni - poin));
        break;
      case UpdateDzikirPetangEvent:
        allYaumis.add(yaumi.copyWith(
            dzikirPetang: !(yaumi.dzikirPetang),
            poinHariIni: !(yaumi.dzikirPetang)
                ? yaumi.poinHariIni + poin
                : yaumi.poinHariIni - poin));
        break;
      case UpdateTaklimEvent:
        allYaumis.add(yaumi.copyWith(
            taklim: !(yaumi.taklim),
            poinHariIni: !(yaumi.taklim)
                ? yaumi.poinHariIni + poin
                : yaumi.poinHariIni - poin));
        break;
      case UpdateIstighfarEvent:
        allYaumis.add(yaumi.copyWith(
            istighfar: !(yaumi.istighfar),
            poinHariIni: !(yaumi.istighfar)
                ? yaumi.poinHariIni + poin
                : yaumi.poinHariIni - poin));
        break;
      case UpdateShalawatEvent:
        allYaumis.add(yaumi.copyWith(
            shalawat: !(yaumi.shalawat),
            poinHariIni: !(yaumi.shalawat)
                ? yaumi.poinHariIni + poin
                : yaumi.poinHariIni - poin));
        break;
    }
    emit(YaumiState(allYaumis: allYaumis));
  }

  void _onDeleteYaumi(DeleteYaumiEvent event, Emitter<YaumiState> emit) {
    final state = this.state;
    final yaumi = event.yaumi;
    emit(YaumiState(allYaumis: List.from(state.allYaumis)..remove(yaumi)));
  }

  @override
  YaumiState? fromJson(Map<String, dynamic> json) {
    return YaumiState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(YaumiState state) {
    return state.toMap();
  }
}
