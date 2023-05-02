part of 'selected_date_bloc.dart';

abstract class SelectedDateEvent extends Equatable {}

class SelectedDateChangedEvents extends SelectedDateEvent {
  final DateTime dateTime;

  SelectedDateChangedEvents(this.dateTime);

  @override
  List<Object?> get props => [dateTime];
}
