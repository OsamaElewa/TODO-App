import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import 'package:todoapp/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:todoapp/modules/done_tasks/done_tasks_screen.dart';
import 'package:todoapp/shared/cubit/cubit.dart';
import 'package:todoapp/shared/cubit/states.dart';

import '../modules/new_tasks/new_tasks_screen.dart';
import '../shared/components/constants.dart';

class homepage extends StatelessWidget
{


  //to show the bottom sheet.

  var scaffoldKey=GlobalKey<ScaffoldState>();

  //to validate the text form fields.

  var formKey=GlobalKey<FormState>();

  //to use the data that is in the fields
  var titleController=TextEditingController();
  var timeController=TextEditingController();
  var dateController=TextEditingController();


  @override
  // void initState() {
  //   super.initState();
  //   createDatabase();
  // }

  /*
  notice that we make tasks list in a file called constant and fill this list with data after we get.
  the data from database look at line 76.
  after we fill in it with data we display the data on the page.
  */

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context,AppStates state){
          if(state is AppInsertDatabaseState){
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppStates state)
        {
          AppCubit cubit=AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,

            appBar: AppBar(
              title: Text(
                 AppCubit.get(context).titles[cubit.currentIndex]
              ),
            ),
//tasks.isEmpty?const Center(child: CircularProgressIndicator(),) :
            body: cubit.screens[cubit.currentIndex],

            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if(cubit.isBottomSheetShown)
                {
                  if(formKey.currentState!.validate()){
                    cubit.insertToDatabase(title: titleController.text, date: dateController.text, time: timeController.text);
                    // insertToDatabase(
                    //     title: titleController.text,
                    //     time: timeController.text,
                    //     date: dateController.text).then((value){
                    //   getDataFromDatabase(database).then((value){
                    //     Navigator.pop(context);
                    //     // setState(() {
                    //     //   isBottomSheetShown=false;
                    //     //   fabIcon=Icons.edit;
                    //     //   tasks=value;
                    //     //   //print(tasks);
                    //     // });
                    //   });
                    //
                    // });
                  }
                }else{
                  scaffoldKey.currentState?.showBottomSheet(
                        (context) =>
                        Container(
                          padding:const EdgeInsets.all(20),
                          color: Colors.white,
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  controller: titleController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    label: const Text('Title'),
                                    prefixIcon: const Icon(Icons.title),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30)
                                    ),
                                  ),
                                  validator: (value){
                                    if(value!.isEmpty)
                                    {
                                      return 'title must not be empty';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10,),
                                TextFormField(
                                  controller: timeController,
                                  keyboardType: TextInputType.datetime,
                                  decoration: InputDecoration(
                                    label: const Text('Time'),
                                    prefixIcon: const Icon(Icons.access_time_rounded),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30)
                                    ),
                                  ),
                                  validator: (value){
                                    if(value!.isEmpty)
                                    {
                                      return 'time must not be empty';
                                    }
                                    return null;
                                  },
                                  onTap: (){
                                    showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now()).then((value) {
                                      timeController.text=value!.format(context).toString();
                                      //print(value.format(context));
                                    });
                                  },
                                ),
                                const SizedBox(height: 10,),
                                TextFormField(
                                  controller: dateController,
                                  keyboardType: TextInputType.datetime,
                                  decoration: InputDecoration(
                                    label: const Text('Date'),
                                    prefixIcon: const Icon(Icons.calendar_today_outlined),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30)
                                    ),
                                  ),
                                  validator: (value){
                                    if(value!.isEmpty)
                                    {
                                      return 'Date time must not be empty';
                                    }
                                    return null;
                                  },
                                  onTap: (){
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2023-05-02'),
                                    ).then((value) {
                                      dateController.text=DateFormat.yMMMd().format(value!);
                                      //print(DateFormat.yMMMd().format(value));
                                    });
                                  },
                                ),

                              ],
                            ),
                          ),
                        ),
                    elevation: 20,
                  ).closed.then((value) {
                    cubit.ChangeBottomSheetState(isshow: false, icon: Icons.edit);
                    // cubit.isBottomSheetShown=false;
                    // // setState(() {
                    // //   fabIcon=Icons.edit;
                    // // });
                  });
                  cubit.ChangeBottomSheetState(isshow: true, icon: Icons.add);
                  // cubit.isBottomSheetShown=true;
                  // // setState(() {
                  // //   fabIcon=Icons.add;
                  // // });
                }

              },
              child: Icon(cubit.fabIcon),
            ),

            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              //we make current index in the bottom sheet = current index the variable we make=0
              currentIndex: cubit.currentIndex,

              onTap: (index) {
                cubit.ChangeIndex(index);
                //by default each tap has an index
                //we make current index = the index of tap to change some data like the title in the app bar
                // setState(() {
                //   currentIndex = index;
                // });
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
                BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Done'),
                BottomNavigationBarItem(icon: Icon(Icons.archive_outlined), label: 'Archive'),
              ],
            ),

          );
        },
      ),
    );
  }

  // Future<String> getname() async {
  //   return 'Osama elewa';
  // }


  //this function is to create database


  // 1. insert data in the table
  // 2. then we get the data from database and put it in the tasks list




  /*
  this function we call it when we insert the data into the database
  *and then we take the data that we get it from database and put it in the tasks list.

  because the data is consisted of key and value we make this function in List of Map type

  look at line 76 to line 83
  */

}


