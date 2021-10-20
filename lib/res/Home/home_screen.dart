import 'package:bloc_pattern_demo/res/Home/bloc/home_result_bloc.dart';
import 'package:bloc_pattern_demo/res/Home/bloc/home_result_event.dart';
import 'package:bloc_pattern_demo/res/Home/bloc/home_result_state.dart';
import 'package:bloc_pattern_demo/res/Home/model/home_model.dart';
import 'package:bloc_pattern_demo/res/widget/profile_avatart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading = false;

  List<Results>? results = [];
  String? error;
  int page = 1;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeResultBloc>(
      create: (_) => HomeResultBloc()..add(HomeLandingStarted(page: page)),
      child: Scaffold(
        body: BlocBuilder<HomeResultBloc, HomeResultState>(
          builder: (ctx, state) {
            if (state is HomeResultLoading) {
              loading = true;
            }

            if (state is HomeResultLoaded) {
              results = state.getResult().results;
              loading = false;
              error = null;
            }

            if (state is HomeError) {
              error = 'Something went wrong! Please try again';
            }

            return loading
                ? Center(
                    child: Container(
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : error != null
                    ? Center(child: Text(error!))
                    : results!.length == 0
                        ? SafeArea(
                            child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Text(
                                  'No Data Found',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                  ),
                                )),
                          )
                        : Container(
                            // ============================= Use For Pagination ============================= //
                            child: NotificationListener<ScrollNotification>(
                              onNotification: (ScrollNotification scrollInfo) {
                                if (scrollInfo.metrics.pixels ==
                                        scrollInfo.metrics.maxScrollExtent &&
                                    scrollInfo is ScrollEndNotification) {
                                  page = page + 1;
                                  if (!(state is MaxResultLoaded)) {
                                    BlocProvider.of<HomeResultBloc>(ctx).add(
                                        LoadMoreHomeLanding(
                                            page: page,
                                            results: state.getResult()!));
                                  }
                                }
                                return false;
                              },
                              // ============================= API Data ============================= //
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: results!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ProfileAvatar(
                                              image: results![index].imageUrl,
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    results![index].title!,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    results![index].synopsis!,
                                                    maxLines: 3,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(thickness: 1)
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
          },
        ),
      ),
    );
  }
}
