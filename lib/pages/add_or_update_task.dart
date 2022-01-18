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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              initialValue: name,
              decoration: const InputDecoration(
                hintText: 'Enter name',
              ),
              onChanged: (val) {
                name = val;
              },
            ),
            TextFormField(
              initialValue: imageUrl,
              decoration: const InputDecoration(
                hintText: 'Enter image url',
              ),
              onChanged: (val) {
                imageUrl = val;
              },
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.all(20),
              alignment: Alignment.center,
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.deepPurple),
              child: InkWell(
                onTap: isLoading
                    ? null
                    : () async {
                        if (name.isNotEmpty && imageUrl.isNotEmpty) {
                          setState(() => isLoading = true);
                          var res;
                          if (widget.task == null) {
                            res = await TaskApi.addTask(
                                name: name, url: imageUrl);
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
                child: isLoading
                    ? const CircularProgressIndicator()
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
