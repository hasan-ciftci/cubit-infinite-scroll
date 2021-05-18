import 'package:cubit_infinite_scrolling/view/gallery/view/cubit_infinite_scroilling.dart';
import 'package:cubit_infinite_scrolling/view/gallery/viewmodel/infinite_scroll_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Cubit Infinite Scrolling',
        home: BlocProvider(
          create: (BuildContext context) => InfiniteScrollCubit(),
          child: CubitInfiniteScrolling(),
        ));
  }
}
