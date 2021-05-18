import 'package:bloc/bloc.dart';
import 'package:cubit_infinite_scrolling/view/gallery/model/photo_model.dart';
import 'package:cubit_infinite_scrolling/view/gallery/service/infinite_scroll_service.dart';
import 'package:flutter/material.dart';

import 'infinite_scroll_state.dart';

class InfiniteScrollCubit extends Cubit<InfiniteScrollState> {
  InfiniteScrollCubit() : super(InitialState());
  ScrollController scrollController = ScrollController();
  InfiniteScrollService service = InfiniteScrollService();
  bool isLoading = false;
  List<PhotoModel> fetchedRecords = [];

  init() async {
    await getMoreData();
    scrollController.addListener(detectScrolledToEnd);
  }

  detectScrolledToEnd() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      await getMoreData();
    }
  }

  startFetching() {
    isLoading = true;
    emit(FetchingStartedState());
  }

  endFetching() {
    isLoading = false;
    emit(FetchingCompletedState(recordCount: fetchedRecords.length));
  }

  showError({String message}) {
    isLoading = false;
    emit(FetchingErrorState(errorMessage: message));
  }

  Future<void> getMoreData() async {
    try {
      startFetching();
      final fetchedNewRecords = await service.fetchRecords(
          start: fetchedRecords.length, quantity: 20);
      List recordData = fetchedNewRecords;
      await Future.forEach(recordData,
          (element) => fetchedRecords.add(PhotoModel.fromJson(element)));
      //throw("Bir hata oldu");
      endFetching();
    } catch (e) {
      showError(message: e);
    }
  }
}
