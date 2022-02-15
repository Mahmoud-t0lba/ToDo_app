import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/widgets/tasks_tile.dart';

import '../models/task_data.dart';

class TasksWidget extends StatefulWidget {
  const TasksWidget({Key key}) : super(key: key);

  @override
  _TasksWidgetState createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  SharedPreferences sharedPreferences;
  @override
  void initState() {
    initSharedPreferences();
    super.initState();
  }

  void initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskdata, child) {
        return GridView.builder(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          reverse: false,
          itemCount: Provider.of<TaskData>(context).tasks.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            return Dismissible(
              direction: DismissDirection.horizontal,
              key: UniqueKey(),
              background: Container(
                margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: const Icon(
                        Icons.delete,
                        size: 30,
                      ),
                    ),
                    const Text(
                      "Delete ?",
                      style: TextStyle(),
                    ),
                  ],
                ),
              ),
              secondaryBackground: Container(
                margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "Delete ?",
                      style: TextStyle(),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: const Icon(
                        Icons.delete,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              onDismissed: (direction) {
                taskdata.deleteTask(taskdata.tasks[index]);
                BotToast.showSimpleNotification(
                  title: "To Do List 📝",
                  subTitle: 'Deleted the task Succesfully',
                  borderRadius: 10.0,
                );
              },
              child: TaskTile(
                taskTitle: taskdata.tasks[index].name,
                isTrue: Provider.of<TaskData>(context).tasks[index].isdone,
                longpresscallback: () {
                  taskdata.deleteTask(taskdata.tasks[index]);
                  BotToast.showSimpleNotification(
                    title: "To Do List 📝",
                    subTitle: 'Deleted the task Succesfully',
                    borderRadius: 10.0,
                  );
                },
                checkBoxCallBack: (checkBoxState) {
                  taskdata.updateTask(taskdata.tasks[index]);
                },
              ),
            );
          },
        );
      },
    );
  }
}
