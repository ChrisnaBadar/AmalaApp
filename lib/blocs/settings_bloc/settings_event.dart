// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'settings_bloc.dart';

class SettingsEvent {}

class TooggleAbsenEvent extends SettingsEvent {}

class TooggleShalatReminderEvent extends SettingsEvent {}

class TooggleFardhuEvent extends SettingsEvent {}

class TooggleTahajudEvent extends SettingsEvent {}

class TooggleDhuhaEvent extends SettingsEvent {}

class TooggleRawatibEvent extends SettingsEvent {}

class TooggleTilawahEvent extends SettingsEvent {}

class TooggleShaumEvent extends SettingsEvent {}

class TooggleSedekahEvent extends SettingsEvent {}

class TooggleDzikirEvent extends SettingsEvent {}

class TooggleTaklimEvent extends SettingsEvent {}

class TooggleIstighfarEvent extends SettingsEvent {}

class TooggleShalawatEvent extends SettingsEvent {}

class SetSelectedGroupIconsEvent extends SettingsEvent {
  String selectedGroupIcons;
  SetSelectedGroupIconsEvent(
    this.selectedGroupIcons,
  );
}

class SetReportSelectedDateEvent extends SettingsEvent {
  int date;
  SetReportSelectedDateEvent({
    required this.date,
  });
}

class SetNamaLembagaEvent extends SettingsEvent {
  String namaLembaga;
  SetNamaLembagaEvent({
    required this.namaLembaga,
  });
}
