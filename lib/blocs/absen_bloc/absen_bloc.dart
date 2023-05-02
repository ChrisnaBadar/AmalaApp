import 'package:amala/blocs/bloc_exports.dart';
import 'package:amala/models/absen_model.dart';
import 'package:equatable/equatable.dart';

part 'absen_event.dart';
part 'absen_state.dart';

class AbsenBloc extends HydratedBloc<AbsenEvent, AbsenState> {
  AbsenBloc() : super(const AbsenState()) {
    on<AddAbsenEvent>(_onAddAbsenEvent);
    on<DeleteAbsenEvent>(_onDeleteAbsenEvent);
  }

  void _onAddAbsenEvent(AddAbsenEvent event, Emitter<AbsenState> emit) {
    final state = this.state;
    emit(AbsenState(allAbsen: List.from(state.allAbsen)..add(event.absen)));
  }

  void _onDeleteAbsenEvent(DeleteAbsenEvent event, Emitter<AbsenState> emit) {
    final state = this.state;
    emit(AbsenState(allAbsen: List.from(state.allAbsen)..remove(event.absen)));
  }

  @override
  AbsenState? fromJson(Map<String, dynamic> json) {
    return AbsenState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(AbsenState state) {
    return state.toMap();
  }
}
