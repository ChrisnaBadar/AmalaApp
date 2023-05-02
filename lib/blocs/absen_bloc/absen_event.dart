part of 'absen_bloc.dart';

class AbsenEvent extends Equatable {
  const AbsenEvent();

  @override
  List<Object> get props => [];
}

class AddAbsenEvent extends AbsenEvent {
  final AbsenModel absen;

  const AddAbsenEvent({required this.absen});

  @override
  List<Object> get props => [absen];
}

class DeleteAbsenEvent extends AbsenEvent {
  final AbsenModel absen;

  const DeleteAbsenEvent({required this.absen});

  @override
  List<Object> get props => [absen];
}

class SetNameAbsenEvent extends AbsenEvent {
  final String nama;
  const SetNameAbsenEvent({required this.nama});

  @override
  List<Object> get props => [nama];
}
