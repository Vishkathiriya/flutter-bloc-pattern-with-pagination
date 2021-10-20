import 'dart:convert';

import 'package:bloc_pattern_demo/res/Home/model/home_model.dart';
import 'package:bloc_pattern_demo/res/utils/request_type.dart';
import 'package:bloc_pattern_demo/src/network/network.dart';
import 'package:http/http.dart' as http;

// ============================= Use For All Api Services   ============================= //

class HomeDataService {
  final client = NetworkClient(http.Client());

  Future getHomePageResult({required int page}) async {
    final response = await client.request(
      requestType: RequestType.GET,
      path: 'naruto&page=$page',
    );

    List<Results> allResults = [];

    List resultss = json.decode(response.body)['results'] as List;

    for (final result in resultss) {
      Results results = Results(
          malId: result['mal_id'],
          url: result['url'],
          imageUrl: result['image_url'],
          title: result['title'],
          synopsis: result['synopsis'],
          airing: result['airing'],
          type: result['type'],
          episodes: result['episodes'],
          score: result['score'].toString(),
          startDate: result['start_date'],
          endDate: result['end_date'],
          members: result['members'],
          rated: result['rated']);

      allResults.add(results);
    }
    return HomeResultModel(
        results: allResults,
        lastPage: json.decode(response.body)['last_page'],
        requestHash: json.decode(response.body)['request_hash'],
        requestCached: json.decode(response.body)['request_cached'],
        requestCacheExpiry: json.decode(response.body)['request_cache_expiry']);
  }
}
