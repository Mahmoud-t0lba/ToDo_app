import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final bool isTrue;
  final String taskTitle;
  final Function checkBoxCallBack;
  final Function longpresscallback;

  const TaskTile({
    Key key,
    this.isTrue,
    this.taskTitle,
    this.checkBoxCallBack,
    this.longpresscallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
        decoration: BoxDecoration(
          color: isTrue ? Colors.black54 : Colors.teal,
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
        child: GridTile(
          footer: GridTileBar(
            leading: Switch(
              activeColor: Colors.blue,
              inactiveThumbColor: Colors.white.withOpacity(0.8),
              inactiveTrackColor: Colors.grey,
              value: isTrue,
              onChanged: checkBoxCallBack,
            ),
            title: const SizedBox(width: 10),
            trailing: GestureDetector(
              onTap: longpresscallback,
              child: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                height: 160,
                width: 160,
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Center(
                      child: Text(
                        taskTitle,
                        style: TextStyle(
                          color: isTrue ? Colors.white : Colors.black,
                          fontSize: 15,
                          decoration:
                              isTrue ? TextDecoration.lineThrough : null,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
