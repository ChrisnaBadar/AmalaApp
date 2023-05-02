// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'selected_date_bloc.dart';

class SelectedDateState extends Equatable {
  final DateTime selectedDate;
  const SelectedDateState({
    required this.selectedDate,
  });

  @override
  List<Object> get props => [selectedDate];
}

class SelectedDateInitial extends SelectedDateState {
  SelectedDateInitial()
      : super(
          selectedDate: DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day),
        );
}
