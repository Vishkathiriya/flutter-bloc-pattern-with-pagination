import 'package:bloc_pattern_demo/res/Home/model/home_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class HomeResultEvent extends Equatable {
  const HomeResultEvent();
}

class HomeLandingStarted extends HomeResultEvent {
  HomeLandingStarted({required this.page});

  final int page;

  @override
  List<Object> get props => [page];
}

class LoadMoreHomeLanding extends HomeResultEvent {
  LoadMoreHomeLanding({
    required this.page,
    required this.results,
  });

  final int page;
  final HomeResultModel results;

  @override
  List<Object?> get props => [page, results];
}
