import 'package:flutter/material.dart';
import 'package:flutter_mock_api/api/task_apis.dart';
import 'package:flutter_mock_api/models/task_model.dart';

class AddOrUpdateTask extends StatefulWidget {
  final TaskModel? task;

  const AddOrUpdateTask({Key? key, this.task}) : super(key: key);

  @override
  _AddOrUpdateTaskState createState() => _AddOrUpdateTaskState();
}

class _AddOrUpdateTaskState extends State<AddOrUpdateTask> {
  String name = '';
  String imageUrl = '';
  bool isLoading = false;

  @override
  void initState() {
    if (widget.task != null) {
      name = widget.task!.name!;
      imageUrl = widget.task!.avatar!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.task != null ? 'Update' : 'Add'} Data"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                      color: Colors.deepPurple.withOpacity(0.7), width: 1.5)),
              height: 50,
              width: double.infinity,
              child: TextFormField(
                initialValue: name,
                decoration: const InputDecoration(
                    icon: Icon(Icons.person_pin_circle_rounded),
                    fillColor: Colors.deepPurple,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: 'Enter name',
                    hintStyle: TextStyle(color: Colors.deepPurple)),
                onChanged: (val) {
                  name = val;
                },
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 50,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                      color: Colors.deepPurple.withOpacity(0.7), width: 1.5)),
              child: TextFormField(
                initialValue: imageUrl,
                decoration: const InputDecoration(
                    icon: Icon(Icons.link),
                    fillColor: Colors.deepPurple,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: 'Enter image url',
                    hintStyle: TextStyle(color: Colors.deepPurple)),
                onChanged: (val) {
                  imageUrl = val;
                },
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: isLoading
                  ? null
                  : () async {
                      if (name.isNotEmpty && imageUrl.isNotEmpty) {
                        setState(() => isLoading = true);
                        var res;
                        if (widget.task == null) {
                          res =
                              await TaskApi.addTask(name: name, url: imageUrl);
                          print(res.body);
                        } else {
                          res = await TaskApi.updateTask(
                              name: name, url: imageUrl, id: widget.task!.id);
                        }
                        print(res.statusCode);
                        setState(() => isLoading = false);
                        if (res.statusCode == 200 || res.statusCode == 201) {
                          Navigator.pop(context, true);
                        }
                      }
                    },
              child: Container(
                margin: const EdgeInsets.all(0),
                alignment: Alignment.center,
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.deepPurple,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 15,
                        offset: Offset(4, 4),
                        spreadRadius: 1),
                    BoxShadow(
                        color: Colors.white12,
                        blurRadius: 15,
                        offset: Offset(-4, -4),
                        spreadRadius: 1)
                  ],
                ),
                child: isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text(
                        "${widget.task != null ? 'Update' : 'Add'} ",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
