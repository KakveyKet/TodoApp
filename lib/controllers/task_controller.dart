import 'package:get/get.dart';
import '../models/task.dart';
import '../db/db_helper.dart';

class TaskController extends GetxController {
  var taskList = <Task>[].obs;
  var filteredTaskList = <Task>[].obs;

  @override
  void onInit() {
    super.onInit();
    getTasks();
  }

  void getTasks() async {
    List<Task> tasks = await DBHelper.getTasks();
    taskList.assignAll(tasks);
    filteredTaskList.assignAll(tasks);
  }

  void addTask(Task task) async {
    await DBHelper.insert(task);
    getTasks();
  }

  void deleteTask(int id) async {
    await DBHelper.delete(id);
    getTasks();
  }

  void searchTasks(String query) {
    if (query.isEmpty) {
      filteredTaskList.assignAll(taskList);
    } else {
      filteredTaskList.assignAll(
        taskList
            .where((task) =>
                task.title.toLowerCase().contains(query.toLowerCase()))
            .toList(),
      );
    }
  }

  void updateTask(Task task) async {
    await DBHelper.update(task);
    getTasks();
  }

  // Method to clear the task list
  void clearTasks() {
    taskList.clear();
    print('clear task func called');
  }
}
