import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/modules/counter/counter_screen.dart';
import 'package:todoapp/shared/bloc_observer.dart';

import 'layout/home_layout.dart';

void main(){
  Bloc.observer = MyBlocObserver();

  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homepage(),
    );
  }
}





