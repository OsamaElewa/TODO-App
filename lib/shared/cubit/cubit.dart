
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/shared/cubit/states.dart';

import '../../modules/archived_tasks/archived_tasks_screen.dart';
import '../../modules/done_tasks/done_tasks_screen.dart';
import '../../modules/new_tasks/new_tasks_screen.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppInitialState());

  //to make calling this cubit easier
  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  //List<Map> tasks=[];

  late Database database;
  List <Map> newTasks=[];
  List <Map> doneTasks=[];
  List <Map> archivedTasks=[];

  List<Widget> screens = [
    const NewTasksScreen(),
    const DoneTasksScreen(),
    const ArchivedTasksScreen()
  ];

  List<String> titles = ['New Task', 'Done Task', 'Archived Task'];

  void ChangeIndex(int index){
    currentIndex=index;
    // ال emit بتربط ال state بالداله دي ويالتالي يتخلي التغيير الل انا عملته يسمع ف الشاشه
    emit(AppChangeBottomNavBarState());
  }

  void createDatabase(){
     openDatabase('todo.db', version: 1,
        onCreate: (database, version) {
          //print('database created');
          database
              .execute(
              'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
              .then((value) {
            //print('table created');
          }).catchError((error) {
            //print('error when creating table${error.toString()}');
          });
        },

        onOpen: (database) {
          getDataFromDatabase(database);
          //print('database opened');
        }).then((value){
          database=value;
          emit(AppCreateDatabaseState());
     });

  }

  Future insertToDatabase({
    required String title,
    required String date,
    required String time,
  }) async {
     await database.transaction((txn) async {
      txn
          .rawInsert(
          'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date","$time", "new")')
          .then((value) {
        print('$value insert is successfully');
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database);
      }).catchError((error) {
        //print('error when inserting table ${error.toString()}');
      });
      return null;
    });
  }


  void getDataFromDatabase(database)
  {
    newTasks=[];
    doneTasks=[];
    archivedTasks=[];
   // emit(AppGetDatabaseState());
     database.rawQuery('SELECT * FROM tasks').then((value){

      value.forEach((element) {
        if(element['status']=='new') {
          newTasks.add(element);
        } else if(element['status']=='done') {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }
      });
      emit(AppGetDatabaseState());
    });
  }

  void updateData({
  required int id,
    required String status
})async
  {
    database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
    [status,id]).
    then((value){
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  void deleteData({
    required int id,
  })async
  {
    database.rawDelete('DELETE FROM tasks WHERE id = ?',[id]).
    then((value){
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  bool isBottomSheetShown=false;

  IconData fabIcon=Icons.edit;

  void ChangeBottomSheetState({
  required bool isshow,
    required IconData icon
}){
    isBottomSheetShown=isshow;
    fabIcon=icon;
    emit(AppChangeBottomSheetState());
  }
}