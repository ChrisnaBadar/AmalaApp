// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'selected_date_event.dart';
part 'selected_date_state.dart';

class SelectedDateBloc extends Bloc<SelectedDateEvent, SelectedDateState> {
  SelectedDateBloc() : super(SelectedDateInitial()) {
    on<SelectedDateChangedEvents>(_onSelectedDate);
  }

  void _onSelectedDate(
      SelectedDateChangedEvents events, Emitter<SelectedDateState> emit) {
    emit(SelectedDateState(selectedDate: events.dateTime));
  }
}
