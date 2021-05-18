import 'package:cubit_infinite_scrolling/core/network/network_service.dart';

import 'package:meta/meta.dart';

class InfiniteScrollService {
  fetchRecords({
    @required int start,
    @required int quantity,
  }) async {
    final response = await NetworkManager.instance.dioGet(
      baseURL: "https://jsonplaceholder.typicode.com/",
      endPoint: "photos?_start=$start&_limit=$quantity",
    );
    return response.data;
  }
}
