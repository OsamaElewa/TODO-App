

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/shared/cubit/cubit.dart';
import 'package:todoapp/shared/cubit/states.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';

class NewTasksScreen extends StatelessWidget {
  const NewTasksScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return
      BlocConsumer<AppCubit, AppStates>(
        listener: (context, state){},
        builder: (context, state)
         {
          var tasks=AppCubit.get(context).newTasks;
          return TasksBuilder(tasks: tasks);
         //    tasks.isEmpty? Center(
         //    child: Column(
         //      mainAxisAlignment: MainAxisAlignment.center,
         //      children: const [
         //        Icon(Icons.menu,
         //        size: 100,
         //        color: Colors.grey,),
         //        Text('NO TASKS YET, PLEASE ADD TASKS',
         //        style: TextStyle(
         //          fontSize: 16,
         //          fontWeight: FontWeight.bold,
         //          color: Colors.grey,
         //        ),),
         //      ],
         //    ),
         //  )
         //
         // : ListView.separated(
         //
         //    itemBuilder: (context,index)=>buildTaskItem(tasks[index],context), //here we give the list to the function
         //
         //
         //    separatorBuilder: (context,index)=>
         //        Padding(
         //          padding: const EdgeInsetsDirectional.only(start: 20),
         //          child: Container(
         //            height: 1,
         //            width: double.infinity,
         //            color: Colors.grey[300],
         //          ),
         //        ),
         //
         //
         //    itemCount: tasks.length,
         //
         //  );
        },
      );
  }
}
