import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/modules/counter/states.dart';

//here i gave the cubit the father abstract class to give me the ability of using others class that extend from it
class CounterCubit extends Cubit<CounterStates>
{
  CounterCubit(): super(CounterInitialState());

  static CounterCubit get(context)=>BlocProvider.of(context);

  int counter=0;

  void minus(){
    counter--;
    emit(CounterMinusState(counter));
  }

  void plus(){
    counter++;
    emit(CounterPlusState(counter));
  }
}