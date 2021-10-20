import 'package:bloc/bloc.dart';
import 'package:bloc_pattern_demo/res/Home/bloc/home_result_event.dart';
import 'package:bloc_pattern_demo/res/Home/bloc/home_result_state.dart';
import 'package:bloc_pattern_demo/res/Home/model/home_model.dart';
import 'package:bloc_pattern_demo/src/home_service.dart';

class HomeResultBloc extends Bloc<HomeResultEvent, HomeResultState> {
  final homeDataService = HomeDataService();
  HomeResultBloc() : super(HomeResultLoading());

  @override
  Stream<HomeResultState> mapEventToState(HomeResultEvent event) async* {
    if (event is HomeLandingStarted) {
      yield* _mapHomeLandingStartedToState(event);
    } else if (event is LoadMoreHomeLanding) {
      yield* _mapHomeLoadMore(event);
    }
  }

  Stream<HomeResultState> _mapHomeLandingStartedToState(
      HomeLandingStarted event) async* {
    yield HomeResultLoading();
    try {
      HomeResultModel homeResultModel =
          await homeDataService.getHomePageResult(page: event.page);

      yield HomeResultLoaded(
        results: homeResultModel,
      );
    } catch (_) {
      print(_);
      yield HomeError();
    }
  }

  // ============================= Use For Pagination ============================= //

  Stream<HomeResultState> _mapHomeLoadMore(LoadMoreHomeLanding event) async* {
    try {
      HomeResultModel homeResultModel =
          await homeDataService.getHomePageResult(page: event.page);
      if (homeResultModel.results!.length == 0) {
        yield MaxResultLoaded(
          members: HomeResultModel(
            results: List.from(event.results.results!)
              ..addAll(homeResultModel.results!),
          ),
        );
      } else {
        yield HomeResultLoaded(
          results: HomeResultModel(
            results: List.from(event.results.results!)
              ..addAll(homeResultModel.results!),
          ),
        );
      }
    } catch (tes) {
      print(tes);
      yield HomeError();
    }
  }
}
