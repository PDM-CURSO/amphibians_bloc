import 'dart:async';
import 'dart:convert';
import 'package:amphibians_bloc/models/amphibian.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';

part 'amphibians_event.dart';
part 'amphibians_state.dart';

class AmphibiansBloc extends Bloc<AmphibiansEvent, AmphibiansState> {
  List<Amphibian> _amphibiansList = [];
  AmphibiansBloc() : super(AmphibiansInitial()) {
    on<GetAllAmpibiansEvent>(_getAllAmphibians);
  }

  FutureOr<void> _getAllAmphibians(event, emit) async {
    try {
      emit(AmphibiansLoadingState());
      var response = await get(Uri.parse("https://bit.ly/3XPPD2C"));
      if (response.statusCode == 200) {
        _amphibiansList = (jsonDecode(response.body) as List)
            .map((e) => Amphibian.fromMap(e))
            .toList();
        if (_amphibiansList == [])
          emit(AmphibiansUnAvailableState());
        else
          emit(AmphibiansAvailableState(amphibians: _amphibiansList));
      } else {
        print("WARNING: HTTP response != 200");
        emit(AmphibiansUnAvailableState());
      }
    } catch (e) {
      print(e.toString());
      emit(AmphibiansErrorState(errorMsg: "Error: ${e.toString()}"));
    }
  }
}
