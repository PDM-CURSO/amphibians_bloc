part of 'amphibians_bloc.dart';

sealed class AmphibiansEvent extends Equatable {
  const AmphibiansEvent();

  @override
  List<Object> get props => [];
}

class GetAllAmpibiansEvent extends AmphibiansEvent {}
