import 'package:equatable/equatable.dart';

abstract class DataState extends Equatable {
  final UIEvent? uiEvent;

  const DataState({this.uiEvent});

  @override
  List<Object> get props => [];
}

class DataLoading extends DataState {
  const DataLoading({super.uiEvent}) : super();
}

class DataInitial extends DataState {
  const DataInitial() : super();
}

class DataSuccess<T> extends DataState {
  final T data;
  const DataSuccess({required this.data, super.uiEvent}) : super();

  @override
  List<Object> get props => data != null ? [data!] : [];
}

class DataFailed extends DataState {
  final String error;
  const DataFailed({required this.error, super.uiEvent}) : super();

  @override
  List<Object> get props => [error];
}

enum UIEvent { loginPage, registerPage }
