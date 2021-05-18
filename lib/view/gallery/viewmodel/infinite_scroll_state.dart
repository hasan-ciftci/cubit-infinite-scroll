abstract class InfiniteScrollState {
  InfiniteScrollState();
}

class InitialState extends InfiniteScrollState {}

class FetchingStartedState extends InfiniteScrollState {}

class FetchingCompletedState extends InfiniteScrollState {
  final int recordCount;

  FetchingCompletedState({this.recordCount});
}

class FetchingErrorState extends InfiniteScrollState {
  final String errorMessage;

  FetchingErrorState({this.errorMessage});
}
