import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class DoneTasksScreen extends StatelessWidget {
  const DoneTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      BlocConsumer<AppCubit, AppStates>(
        listener: (context, state){},
        builder: (context, state)
        {
          var tasks=AppCubit.get(context).doneTasks;
          return TasksBuilder(tasks: tasks);
          //   ListView.separated(
          //
          //   itemBuilder: (context,index)=>buildTaskItem(tasks[index],context), //here we give the list to the function
          //
          //
          //   separatorBuilder: (context,index)=>
          //       Padding(
          //         padding: const EdgeInsetsDirectional.only(start: 20),
          //         child: Container(
          //           height: 1,
          //           width: double.infinity,
          //           color: Colors.grey[300],
          //         ),
          //       ),
          //
          //
          //   itemCount: tasks.length,
          //
          // );
        },
      );
  }
}
