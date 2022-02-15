// ignore_for_file: camel_case_types

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:todo_app/screens/custom_dialog.dart';

import '../models/task_data.dart';
import '../widgets/tasks_list.dart';
import 'add_task_screen.dart';

class Tasks_Screen extends StatelessWidget {
  const Tasks_Screen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
              currentAccountPictureSize: Size.fromRadius(35),
              accountName: Text(
                "To Do",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              accountEmail: Text("Your own personal ToDo"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.teal,
                child: Image(
                  image: AssetImage("assets/logo_transparent.png"),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.check_box),
              title: const Text('Check All'),
              enabled: true,
              onTap: () {
                checkAll(context);
              },
            ),
            ListTile(
              onTap: () {
                uncheckAll(context);
              },
              leading: const Icon(Icons.check_box_outline_blank_rounded),
              title: const Text('UnCheck All'),
            ),
            ListTile(
              onTap: () {
                Alert(
                  context: context,
                  type: AlertType.warning,
                  title: "To Do List 📝",
                  desc:
                      'This is irreversible, you might end up losing all your tasks listed here.\n Are you sure ?',
                  buttons: [
                    DialogButton(
                      child: const Text(
                        "NO",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () => Navigator.pop(context),
                      color: const Color.fromRGBO(0, 179, 134, 1.0),
                    ),
                    DialogButton(
                      child: const Text(
                        "YES",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () {
                        dAll(context);
                      },
                      gradient: const LinearGradient(colors: [
                        Color.fromRGBO(116, 116, 191, 1.0),
                        Color.fromRGBO(52, 138, 199, 1.0)
                      ]),
                    )
                  ],
                ).show();
              },
              leading: const Icon(Icons.delete),
              title: const Text('Delete All'),
            ),
            const ListTile(
              onTap: null,
              leading: Icon(Icons.color_lens_sharp),
              title: Text('Change Theme'),
            ),
            ListTile(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const CustomDialogBox(
                        title: "To Do",
                        descriptions:
                            ' 📝 A simple ad free To Do App\n 📝 Press the add icon button to add a task\n 📝swipe left or right on any task to delete\n 📝Check or Uncheck any task\n 📝Delete all task at once\n 📝Check all tasks at once \n 📝Customize your own theme',
                        text: "Check GitHub",
                      );
                    });
              },
              leading: const Icon(Icons.info),
              title: const Text('About'),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.teal,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (kDebugMode) {
            print('button pressed');
          }
          showModalBottomSheet(
              context: context, builder: (context) => const Add_Task_screen());
        },
        elevation: 12.0,
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(
                  top: 0.0, left: 30, right: 30.0, bottom: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: const [
                      Image(
                        height: 100,
                        width: 100,
                        image: AssetImage(
                          "assets/logo_transparent.png",
                        ),
                      ),
                      Text(
                        "To Do",
                        style: TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.lightBlueAccent,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        margin: const EdgeInsets.all(10),
                        child: Text(
                          '${Provider.of<TaskData>(context).tasks.length}',
                          style: const TextStyle(
                              fontSize: 60.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      const Text(
                        ' Tasks left',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontFamily: 'OpenSans-Light',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 2.0,
                  vertical: 2.0,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: const TasksWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void dAll(BuildContext context) {
  Provider.of<TaskData>(context, listen: false).deleteAll();
  BotToast.showSimpleNotification(
    title: "To Do List 📝",
    subTitle: 'All task Deleted Succesfully ',
    borderRadius: 5.0,
  );
  Navigator.pop(context);
}

void checkAll(BuildContext context) {
  Provider.of<TaskData>(context, listen: false).checkAll();
  BotToast.showSimpleNotification(
    title: "To Do List 📝",
    subTitle: 'All task Checked Succesfully ',
    borderRadius: 5.0,
  );
  Navigator.pop(context);
}

void uncheckAll(BuildContext context) {
  Provider.of<TaskData>(context, listen: false).uncheckAll();
  BotToast.showSimpleNotification(
    title: "To Do List 📝",
    subTitle: 'All task UnChecked Succesfully ',
    borderRadius: 5.0,
  );
  Navigator.pop(context);
}
