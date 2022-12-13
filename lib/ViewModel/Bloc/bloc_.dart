import 'package:blocmvvm/Model/coin_model.dart';
import 'package:blocmvvm/ViewModel/Bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Repositery/coinlist_repositery.dart';
import 'event_.dart';

class CoinListBloc extends Bloc<CoinListEvent, CoinListState> {
  final _myRepo = HomeRepository();

  CoinListBloc() : super(Loading()) {
    on<ViewCoinList>(
      (event, emit) async {
        try {
          // here emit the loading stae
          emit(Loading());

          // here we hit the api
          CoinModel data = await _myRepo.fetchMovies();
          //here we emit the response of api with loaded state
          emit(Loaded(data: data));
        } catch (e) {
          // if any type of error is ocuured emit error with error state
          emit(ErrorOccurd(error: e.toString()));

        }
      },
    );
  }
}
