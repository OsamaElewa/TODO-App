import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/modules/counter/cubit.dart';
import 'package:todoapp/modules/counter/states.dart';

class counterScreen extends StatelessWidget {
   const counterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>CounterCubit(),
      child: BlocConsumer<CounterCubit,CounterStates>(
        listener: (context, state){
          if(state is CounterMinusState){
            print('minus state ${state.counter}');
          }
          if(state is CounterPlusState){
            print('plus state ${state.counter}');
          }
        },
        builder: (context, state){
          return Scaffold(
            appBar: AppBar(
              title: const Text('Bloc'),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: (){
                      CounterCubit.get(context).minus();
                    },
                    child: const Text('MINUS'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text('${CounterCubit.get(context).counter}',
                      style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 50),),
                  ),
                  TextButton(
                    onPressed: (){
                      CounterCubit.get(context).plus();
                    },
                    child: const Text('PLUS'),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: (){},
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
