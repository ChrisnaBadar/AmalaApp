// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'yaumi_bloc.dart';

abstract class YaumiEvent extends Equatable {
  const YaumiEvent();

  @override
  List<Object> get props => [];
}

class AddYaumiEvent extends YaumiEvent {
  final YaumiModel yaumi;

  const AddYaumiEvent({required this.yaumi});

  @override
  List<Object> get props => [yaumi];
}

class UpdateShubuhEvent extends YaumiEvent {
  final YaumiModel yaumi;
  final double poinHariIni;

  const UpdateShubuhEvent({
    required this.yaumi,
    required this.poinHariIni,
  });

  @override
  List<Object> get props => [yaumi, poinHariIni];
}

class UpdateDhuhurEvent extends YaumiEvent {
  final YaumiModel yaumi;
  final double poinHariIni;

  const UpdateDhuhurEvent({
    required this.yaumi,
    required this.poinHariIni,
  });

  @override
  List<Object> get props => [yaumi, poinHariIni];
}

class UpdateAsharEvent extends YaumiEvent {
  final YaumiModel yaumi;
  final double poinHariIni;

  const UpdateAsharEvent({
    required this.yaumi,
    required this.poinHariIni,
  });

  @override
  List<Object> get props => [yaumi, poinHariIni];
}

class UpdateMaghribEvent extends YaumiEvent {
  final YaumiModel yaumi;
  final double poinHariIni;

  const UpdateMaghribEvent({
    required this.yaumi,
    required this.poinHariIni,
  });

  @override
  List<Object> get props => [yaumi, poinHariIni];
}

class UpdateIsyaEvent extends YaumiEvent {
  final YaumiModel yaumi;
  final double poinHariIni;

  const UpdateIsyaEvent({
    required this.yaumi,
    required this.poinHariIni,
  });

  @override
  List<Object> get props => [yaumi, poinHariIni];
}

class UpdateTahajudEvent extends YaumiEvent {
  final YaumiModel yaumi;
  final double poinHariIni;

  const UpdateTahajudEvent({
    required this.yaumi,
    required this.poinHariIni,
  });

  @override
  List<Object> get props => [yaumi, poinHariIni];
}

class UpdateRawatibEvent extends YaumiEvent {
  final YaumiModel yaumi;
  final double poinHariIni;

  const UpdateRawatibEvent({
    required this.yaumi,
    required this.poinHariIni,
  });

  @override
  List<Object> get props => [yaumi, poinHariIni];
}

class UpdateDhuhaEvent extends YaumiEvent {
  final YaumiModel yaumi;
  final double poinHariIni;

  const UpdateDhuhaEvent({
    required this.yaumi,
    required this.poinHariIni,
  });

  @override
  List<Object> get props => [yaumi, poinHariIni];
}

class UpdateIncrementTilawahEvent extends YaumiEvent {
  final YaumiModel yaumi;
  final double poinHariIni;

  const UpdateIncrementTilawahEvent({
    required this.yaumi,
    required this.poinHariIni,
  });

  @override
  List<Object> get props => [yaumi, poinHariIni];
}

class UpdateDecrementTilawahEvent extends YaumiEvent {
  final YaumiModel yaumi;
  final double poinHariIni;

  const UpdateDecrementTilawahEvent({
    required this.yaumi,
    required this.poinHariIni,
  });

  @override
  List<Object> get props => [yaumi, poinHariIni];
}

class UpdateShaumEvent extends YaumiEvent {
  final YaumiModel yaumi;
  final double poinHariIni;

  const UpdateShaumEvent({
    required this.yaumi,
    required this.poinHariIni,
  });

  @override
  List<Object> get props => [yaumi, poinHariIni];
}

class UpdateSedekahEvent extends YaumiEvent {
  final YaumiModel yaumi;
  final double poinHariIni;

  const UpdateSedekahEvent({
    required this.yaumi,
    required this.poinHariIni,
  });

  @override
  List<Object> get props => [yaumi, poinHariIni];
}

class UpdateDzikirPagiEvent extends YaumiEvent {
  final YaumiModel yaumi;
  final double poinHariIni;

  const UpdateDzikirPagiEvent({
    required this.yaumi,
    required this.poinHariIni,
  });

  @override
  List<Object> get props => [yaumi, poinHariIni];
}

class UpdateDzikirPetangEvent extends YaumiEvent {
  final YaumiModel yaumi;
  final double poinHariIni;

  const UpdateDzikirPetangEvent({
    required this.yaumi,
    required this.poinHariIni,
  });

  @override
  List<Object> get props => [yaumi, poinHariIni];
}

class UpdateTaklimEvent extends YaumiEvent {
  final YaumiModel yaumi;
  final double poinHariIni;

  const UpdateTaklimEvent({
    required this.yaumi,
    required this.poinHariIni,
  });

  @override
  List<Object> get props => [yaumi, poinHariIni];
}

class UpdateIstighfarEvent extends YaumiEvent {
  final YaumiModel yaumi;
  final double poinHariIni;

  const UpdateIstighfarEvent({
    required this.yaumi,
    required this.poinHariIni,
  });

  @override
  List<Object> get props => [yaumi, poinHariIni];
}

class UpdateShalawatEvent extends YaumiEvent {
  final YaumiModel yaumi;
  final double poinHariIni;

  const UpdateShalawatEvent({
    required this.yaumi,
    required this.poinHariIni,
  });

  @override
  List<Object> get props => [yaumi, poinHariIni];
}

class DeleteYaumiEvent extends YaumiEvent {
  final YaumiModel yaumi;

  const DeleteYaumiEvent({
    required this.yaumi,
  });

  @override
  List<Object> get props => [yaumi];
}

class UploadedStateDataEvent extends YaumiEvent {
  final YaumiModel yaumi;

  const UploadedStateDataEvent({
    required this.yaumi,
  });

  @override
  List<Object> get props => [yaumi];
}
