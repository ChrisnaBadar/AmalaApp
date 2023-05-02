import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../services/location_service.dart';

part 'selected_date_event.dart';
part 'selected_date_state.dart';

class SelectedDateBloc extends Bloc<SelectedDateEvent, SelectedDateState> {
  SelectedDateBloc() : super(SelectedDateInitial()) {
    on<SelectedDateChangedEvents>(_onSelectedDate);
  }

  void _onSelectedDate(
      SelectedDateChangedEvents events, Emitter<SelectedDateState> emit) {
    var state = this.state;
    emit(SelectedDateState(selectedDate: events.dateTime));
  }
}
