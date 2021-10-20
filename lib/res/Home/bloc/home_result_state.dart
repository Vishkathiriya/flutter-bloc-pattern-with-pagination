import 'package:bloc_pattern_demo/res/Home/model/home_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class HomeResultState extends Equatable {
  const HomeResultState();

  HomeResultModel? getResult();
}

// ============================= Use For Add Data First Time  ============================= //

class HomeResultLoading extends HomeResultState {
  @override
  HomeResultModel? getResult() => null;

  @override
  List<Object> get props => [];
}

// ============================= Use For Pagination  ============================= //

class HomeResultLoaded extends HomeResultState {
  const HomeResultLoaded({required this.results});
  @override
  HomeResultModel getResult() => results;

  final HomeResultModel results;

  @override
  List<Object> get props => [results];
}

// ============================= Use For No More Data In Pagination  ============================= //

class MaxResultLoaded extends HomeResultState {
  MaxResultLoaded({required this.members});

  @override
  HomeResultModel? getResult() => members;

  final HomeResultModel members;
  @override
  List<Object> get props => [members];
}

// ============================= Use For Handel Error  ============================= //

class HomeError extends HomeResultState {
  @override
  HomeResultModel? getResult() => null;

  @override
  List<Object> get props => [];
}
