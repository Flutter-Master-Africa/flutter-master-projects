import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/task.dart';

class TaskController extends GetxController {
  var tasks = <Task>[].obs; // un Etat Observable
  final storage = GetStorage();
  static const String STORAGE_KEY = 'tasks';

  @override
  void onInit() {
    super.onInit();
    // Charger les taches depuis le stockage si necessaire
    loadTasks();
  }

  // load tasks
  void loadTasks() {
    final List<dynamic>? storeedTasks = storage.read(STORAGE_KEY);

    if (storeedTasks != null) {
      tasks.value = storeedTasks.map((e) => Task.fromJson(e)).toList();
    }
  }

  // Ajouter une tache
  void saveTasks() {
    List<Map<String, dynamic>> taskList = tasks
        .map((task) => task.toJson())
        .toList();
    storage.write(STORAGE_KEY, taskList);
  }

  void addTask(Task task) {
    tasks.add(task);
    saveTasks();
  }

  // Supprimer une tache
  void removeTask(String task) {
    tasks.remove(task);
    saveTasks();
  }

  // Marquer une tache comme completee
  void toggleTaskCompletion(int index) {
    if (index >= 0 && index < tasks.length) {
      tasks[index].isCompleted = !tasks[index].isCompleted;
      saveTasks();
      tasks.refresh(); // Notifier les ecouteurs de la modification
    }
  }

  // supprimer toutes les taches
  void clearTasks() {
    tasks.clear();
    saveTasks();
  }

  void updateTask(int index, Task newTask) {
    if (index >= 0 && index < tasks.length) {
      tasks[index] = newTask;
    }
    saveTasks();
  }

  // Obtenir le nombre de taches
  int get totalTasks => tasks.length;
}
