part of 'amphibians_bloc.dart';

sealed class AmphibiansState extends Equatable {
  const AmphibiansState();

  @override
  List<Object> get props => [];
}

final class AmphibiansInitial extends AmphibiansState {}

final class AmphibiansLoadingState extends AmphibiansState {}

final class AmphibiansUnAvailableState extends AmphibiansState {}

final class AmphibiansAvailableState extends AmphibiansState {
  final List<Amphibian> amphibians;

  AmphibiansAvailableState({required this.amphibians});
  @override
  List<Object> get props => [amphibians];
}

final class AmphibiansErrorState extends AmphibiansState {
  final String errorMsg;

  AmphibiansErrorState({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}
