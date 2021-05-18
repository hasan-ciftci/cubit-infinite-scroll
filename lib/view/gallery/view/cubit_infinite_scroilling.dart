
import 'package:cubit_infinite_scrolling/view/gallery/viewmodel/infinite_scroll_cubit.dart';
import 'package:cubit_infinite_scrolling/view/gallery/viewmodel/infinite_scroll_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CubitInfiniteScrolling extends StatefulWidget {
  const CubitInfiniteScrolling({Key key}) : super(key: key);

  @override
  _CubitInfiniteScrollingState createState() => _CubitInfiniteScrollingState();
}

class _CubitInfiniteScrollingState extends State<CubitInfiniteScrolling> {
  @override
  void initState() {
    super.initState();
    context.read<InfiniteScrollCubit>().init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<InfiniteScrollCubit, InfiniteScrollState>(
      listener: (BuildContext context, state) async {
        if (state is FetchingCompletedState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Güncellendi, Kayıt S: ${state.recordCount}")));
        }
        if (state is FetchingErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Tekrar deneniyor")));
          await Future.delayed(Duration(seconds: 2));
          context.read<InfiniteScrollCubit>().startFetching();
        }
      },
      builder: (BuildContext context, state) {
        if (state is FetchingErrorState) {
          return Center(
            child: Text(state.errorMessage),
          );
        }
        return ListView.builder(
          controller: context.read<InfiniteScrollCubit>().scrollController,
          itemCount:
              context.watch<InfiniteScrollCubit>().fetchedRecords.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index ==
                context.watch<InfiniteScrollCubit>().fetchedRecords.length) {
              return Opacity(
                opacity: context.watch<InfiniteScrollCubit>().isLoading ? 1 : 0,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return Container(
              margin: EdgeInsets.all(16.0),
              child: ListTile(
                leading: Text(
                  context
                      .read<InfiniteScrollCubit>()
                      .fetchedRecords[index]
                      .id
                      .toString(),
                ),
                title: Card(
                  child: Image.network(context
                      .read<InfiniteScrollCubit>()
                      .fetchedRecords[index]
                      .thumbnailUrl),
                ),
                subtitle: Text(context
                    .read<InfiniteScrollCubit>()
                    .fetchedRecords[index]
                    .title),
              ),
            );
          },
        );
      },
    ));
  }
}
