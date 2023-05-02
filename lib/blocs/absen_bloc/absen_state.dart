part of 'absen_bloc.dart';

class AbsenState extends Equatable {
  final List<AbsenModel> allAbsen;
  const AbsenState({
    this.allAbsen = const <AbsenModel>[],
  });

  @override
  List<Object> get props => [allAbsen];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'allAbsen': allAbsen.map((x) => x.toMap()).toList(),
    };
  }

  factory AbsenState.fromMap(Map<String, dynamic> map) {
    return AbsenState(
      allAbsen: List<AbsenModel>.from(
        (map['allAbsen']?.map((x) => AbsenModel.fromMap(x))),
      ),
    );
  }
}
