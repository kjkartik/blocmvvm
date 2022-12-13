import 'package:blocmvvm/ViewModel/Bloc/event_.dart';
import 'package:equatable/equatable.dart';

import '../../Model/coin_model.dart';

abstract class CoinListState extends Equatable {}

class Loading extends CoinListState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class Loaded extends CoinListState{
  @override
  CoinModel data;
  Loaded({required this.data});
  // TODO: implement props
  List<Object?> get props => [];
}

class ErrorOccurd extends CoinListState{

  String error;
  ErrorOccurd({required this.error});


  // TODO: implement props
  @override
  List<Object?> get props => [];}