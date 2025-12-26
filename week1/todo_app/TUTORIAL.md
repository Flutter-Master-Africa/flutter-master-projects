# Flutter Todo App Tutorial: From Hello World to Real App
## Complete Step-by-Step Guide with GetX and GetStorage

Welcome to this comprehensive Flutter tutorial! This guide will take you from creating a simple "Hello World" app to building a fully functional Todo application using GetX for state management and GetStorage for local persistence.

---

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Part 1: Hello World - Your First Flutter App](#part-1-hello-world---your-first-flutter-app)
3. [Part 2: Understanding Flutter Basics](#part-2-understanding-flutter-basics)
4. [Part 3: Introduction to GetX](#part-3-introduction-to-getx)
5. [Part 4: Setting Up the Todo App](#part-4-setting-up-the-todo-app)
6. [Part 5: Creating the Task Model](#part-5-creating-the-task-model)
7. [Part 6: Building the Task Controller with GetX](#part-6-building-the-task-controller-with-getx)
8. [Part 7: Creating the Home Screen UI](#part-7-creating-the-home-screen-ui)
9. [Part 8: Adding Persistent Storage with GetStorage](#part-8-adding-persistent-storage-with-getstorage)
10. [Part 9: Task Detail Screen](#part-9-task-detail-screen)
11. [Part 10: Final Touches and Testing](#part-10-final-touches-and-testing)
12. [Conclusion and Next Steps](#conclusion-and-next-steps)

---

## Prerequisites

Before starting, ensure you have:

- Flutter SDK installed (version 3.10.3 or higher)
- A code editor (VS Code, Android Studio, or IntelliJ IDEA)
- An emulator or physical device for testing
- Basic understanding of Dart programming language

To verify your Flutter installation:

```bash
flutter --version
flutter doctor
```

---

## Part 1: Hello World - Your First Flutter App

### Step 1.1: Create a New Flutter Project

Open your terminal and run:

```bash
flutter create hello_world
cd hello_world
```

### Step 1.2: Understanding the Project Structure

```
hello_world/
├── lib/
│   └── main.dart          # Main application file
├── test/                  # Test files
├── pubspec.yaml           # Dependencies and configuration
└── README.md
```

### Step 1.3: Your First Hello World App

Open `lib/main.dart` and replace everything with:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello World',
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First Flutter App'),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Text(
            'Hello World!',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
```

### Step 1.4: Run Your App

```bash
flutter run
```

**What just happened?**

- `main()`: The entry point of every Flutter app
- `runApp()`: Takes the widget and makes it the root of the widget tree
- `MaterialApp`: Provides Material Design structure
- `Scaffold`: Provides basic app structure (AppBar, Body, etc.)
- `Center`: Centers its child widget
- `Text`: Displays text on screen

---

## Part 2: Understanding Flutter Basics

### 2.1: Widgets - The Building Blocks

Everything in Flutter is a widget. There are two main types:

**StatelessWidget**: Immutable widgets that don't change
```dart
class MyStatelessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('I never change');
  }
}
```

**StatefulWidget**: Widgets that can change state
```dart
class MyStatefulWidget extends StatefulWidget {
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Text('Counter: $counter');
  }
}
```

### 2.2: Common Widgets

- `Container`: A box that can contain other widgets
- `Column`: Arranges children vertically
- `Row`: Arranges children horizontally
- `ListView`: Scrollable list
- `TextField`: Text input field
- `ElevatedButton`: Material Design button
- `Icon`: Display icons

### 2.3: Layout Example

```dart
Column(
  children: [
    Text('Item 1'),
    Text('Item 2'),
    Row(
      children: [
        Icon(Icons.star),
        Text('Starred'),
      ],
    ),
  ],
)
```

---

## Part 3: Introduction to GetX

### 3.1: Why GetX?

GetX is a powerful Flutter package that provides:

1. **State Management**: Reactive state management with minimal code
2. **Route Management**: Simple navigation
3. **Dependency Injection**: Easy instance management

### 3.2: GetX vs Traditional setState

**Traditional setState:**
```dart
class _CounterState extends State<Counter> {
  int count = 0;

  void increment() {
    setState(() {
      count++;
    });
  }
}
```

**With GetX:**
```dart
class CounterController extends GetxController {
  var count = 0.obs;

  void increment() => count++;
}

// In your widget
Obx(() => Text('${controller.count}'))
```

### 3.3: GetX Reactive Variables

```dart
// Observable variable
var name = 'John'.obs;

// Update value
name.value = 'Jane';

// Use in UI
Obx(() => Text(name.value))
```

---

## Part 4: Setting Up the Todo App

### Step 4.1: Create the Project

```bash
flutter create todo_app
cd todo_app
```

### Step 4.2: Add Dependencies

Open `pubspec.yaml` and add GetX and GetStorage:

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  get: ^4.7.3
  get_storage: ^2.1.1
```

Install dependencies:

```bash
flutter pub get
```

### Step 4.3: Create Project Structure

Create the following folder structure:

```
lib/
├── main.dart
├── models/
│   └── task.dart
├── controllers/
│   └── task_controller.dart
└── screens/
    ├── home_screen.dart
    └── task_detail_screen.dart
```

**Why this structure?**

- `models/`: Data structures (Task class)
- `controllers/`: Business logic and state management
- `screens/`: UI pages

---

## Part 5: Creating the Task Model

### Step 5.1: Understanding Models

A model is a class that represents data in your application. For our Todo app, we need a Task model.

### Step 5.2: Create task.dart

Create `lib/models/task.dart`:

```dart
class Task {
  final String id;
  final String title;
  String? description;
  bool isCompleted;
  DateTime dateCreated;
  DateTime? dateEcheance;

  Task({
    required this.id,
    required this.title,
    this.description,
    this.isCompleted = false,
    DateTime? dateCreated,
    DateTime? dateEcheance,
  }) : dateCreated = dateCreated ?? DateTime.now();

  // Convert Task to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'dateCreated': dateCreated.toIso8601String(),
      'dateEcheance': dateEcheance?.toIso8601String(),
    };
  }

  // Create Task from JSON
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isCompleted: json['isCompleted'],
      dateCreated: DateTime.parse(json['dateCreated']),
      dateEcheance: json['dateEcheance'] != null
          ? DateTime.parse(json['dateEcheance'])
          : null,
    );
  }
}
```

**Key Concepts:**

- `required`: These parameters must be provided
- `?`: Nullable type (can be null)
- `this.isCompleted = false`: Default value
- `toJson()`: Converts object to Map for storage
- `factory`: Constructor that can return an instance
- `fromJson()`: Creates Task object from Map

### Step 5.3: Understanding the Task Properties

| Property | Type | Purpose |
|----------|------|---------|
| `id` | String | Unique identifier for each task |
| `title` | String | The task name/title |
| `description` | String? | Optional details about the task |
| `isCompleted` | bool | Whether task is done (true/false) |
| `dateCreated` | DateTime | When the task was created |
| `dateEcheance` | DateTime? | Optional deadline |

---

## Part 6: Building the Task Controller with GetX

### Step 6.1: Understanding Controllers

Controllers in GetX manage the state and business logic of your app. They:

- Hold observable data
- Provide methods to modify data
- Notify UI when data changes

### Step 6.2: Create task_controller.dart

Create `lib/controllers/task_controller.dart`:

```dart
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/task.dart';

class TaskController extends GetxController {
  // Observable list of tasks
  var tasks = <Task>[].obs;

  // GetStorage instance
  final storage = GetStorage();

  // Storage key constant
  static const String STORAGE_KEY = 'tasks';

  @override
  void onInit() {
    super.onInit();
    // Load tasks when controller initializes
    loadTasks();
  }

  // Load tasks from storage
  void loadTasks() {
    final List<dynamic>? storedTasks = storage.read(STORAGE_KEY);

    if (storedTasks != null) {
      tasks.value = storedTasks.map((e) => Task.fromJson(e)).toList();
    }
  }

  // Save tasks to storage
  void saveTasks() {
    List<Map<String, dynamic>> taskList = tasks
        .map((task) => task.toJson())
        .toList();
    storage.write(STORAGE_KEY, taskList);
  }

  // Add a new task
  void addTask(Task task) {
    tasks.add(task);
    saveTasks();
  }

  // Remove a task
  void removeTask(String taskId) {
    tasks.removeWhere((task) => task.id == taskId);
    saveTasks();
  }

  // Toggle task completion status
  void toggleTaskCompletion(int index) {
    if (index >= 0 && index < tasks.length) {
      tasks[index].isCompleted = !tasks[index].isCompleted;
      saveTasks();
      tasks.refresh(); // Notify listeners
    }
  }

  // Clear all tasks
  void clearTasks() {
    tasks.clear();
    saveTasks();
  }

  // Update a task
  void updateTask(int index, Task newTask) {
    if (index >= 0 && index < tasks.length) {
      tasks[index] = newTask;
    }
    saveTasks();
  }

  // Get total number of tasks
  int get totalTasks => tasks.length;
}
```

### Step 6.3: Understanding the Controller Methods

**Initialization:**
```dart
@override
void onInit() {
  super.onInit();
  loadTasks();
}
```
- Called automatically when controller is created
- Perfect place to load saved data

**Observable List:**
```dart
var tasks = <Task>[].obs;
```
- `.obs` makes the list reactive
- Any change automatically updates the UI

**CRUD Operations:**

1. **Create** (Add):
```dart
void addTask(Task task) {
  tasks.add(task);      // Add to list
  saveTasks();          // Save to storage
}
```

2. **Read** (Load):
```dart
void loadTasks() {
  final List<dynamic>? storedTasks = storage.read(STORAGE_KEY);
  if (storedTasks != null) {
    tasks.value = storedTasks.map((e) => Task.fromJson(e)).toList();
  }
}
```

3. **Update** (Toggle):
```dart
void toggleTaskCompletion(int index) {
  tasks[index].isCompleted = !tasks[index].isCompleted;
  saveTasks();
  tasks.refresh();
}
```

4. **Delete** (Remove):
```dart
void removeTask(String taskId) {
  tasks.removeWhere((task) => task.id == taskId);
  saveTasks();
}
```

---

## Part 7: Creating the Home Screen UI

### Step 7.1: Understanding the Screen Layout

Our home screen will have:
1. AppBar with title and info button
2. Welcome message
3. Input field to add new tasks
4. List of tasks with completion toggle

### Step 7.2: Create home_screen.dart

Create `lib/screens/home_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';
import '../models/task.dart';
import 'task_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Initialize controller
  final TaskController _taskController = Get.put(TaskController());

  // Text field controller
  final TextEditingController _titleController = TextEditingController();

  // Add task method
  void _addTask() {
    if (_titleController.text.isEmpty) return;

    final newTask = Task(
      id: DateTime.now().toString(),
      title: _titleController.text,
    );

    _taskController.addTask(newTask);
    _titleController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AfriTodo',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Mon Application de Todo \n Version 0.1"),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          "Les fonctionnalités de mon Application sont : \n Ajouter des Tâches \n Afficher la liste",
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            icon: Icon(Icons.info, color: Colors.white),
          ),
        ],
      ),
      body: Obx(() => Column(
        children: [
          // Welcome message
          Center(
            child: Text(
              'Bienvenue sur l\'application AfriTodo',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: Colors.blue),
            ),
          ),

          SizedBox(height: 25),

          // Add task form
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Titre de la tâche',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addTask,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.all(12),
                  ),
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),

          SizedBox(height: 40),

          // Task list
          Expanded(
            child: _taskController.tasks.isEmpty
                ? Center(child: Text('Aucune tâche à afficher.'))
                : ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: _taskController.totalTasks,
                    itemBuilder: (context, index) {
                      final task = _taskController.tasks[index];

                      return ListTile(
                        title: Text(task.title),
                        subtitle: Text(task.description ?? ''),
                        trailing: IconButton(
                          onPressed: () {
                            _taskController.toggleTaskCompletion(index);
                          },
                          icon: task.isCompleted
                              ? Icon(Icons.check_circle)
                              : Icon(Icons.circle),
                          color: task.isCompleted ? Colors.green : Colors.grey,
                        ),
                        onTap: () {
                          Get.to(() => TaskDetailScreen(task: task));
                        },
                      );
                    },
                  ),
          ),
        ],
      )),
    );
  }
}
```

### Step 7.3: Understanding the UI Components

**1. AppBar:**
```dart
AppBar(
  title: const Text('AfriTodo'),
  backgroundColor: Colors.blue,
  actions: [
    IconButton(/* Info dialog */)
  ],
)
```

**2. Obx Widget (GetX Reactive):**
```dart
Obx(() => Column(
  children: [
    // UI that updates automatically when tasks change
  ],
))
```
- `Obx()` watches observable variables
- Rebuilds only when observed data changes

**3. TextField with Controller:**
```dart
TextField(
  controller: _titleController,
  decoration: const InputDecoration(
    labelText: 'Titre de la tâche',
    border: OutlineInputBorder(),
  ),
)
```
- `TextEditingController` manages input text
- `decoration` styles the input field

**4. ListView.builder:**
```dart
ListView.builder(
  itemCount: _taskController.totalTasks,
  itemBuilder: (context, index) {
    final task = _taskController.tasks[index];
    return ListTile(/* ... */);
  },
)
```
- Efficient for long lists
- Only builds visible items
- `itemBuilder` creates each list item

**5. Conditional Rendering:**
```dart
_taskController.tasks.isEmpty
    ? Center(child: Text('Aucune tâche à afficher.'))
    : ListView.builder(/* ... */)
```
- Shows message when list is empty
- Shows list when tasks exist

---

## Part 8: Adding Persistent Storage with GetStorage

### Step 8.1: Why GetStorage?

GetStorage is a fast, lightweight key-value storage solution for Flutter:

- Simple API
- No native dependencies
- Very fast
- Perfect for simple data persistence

### Step 8.2: Initialize GetStorage

Update `lib/main.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'screens/home_screen.dart';

void main() async {
  // Initialize GetStorage
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(  // Note: GetMaterialApp, not MaterialApp
      debugShowCheckedModeBanner: false,
      title: 'AfriTask',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: HomeScreen(),
    );
  }
}
```

**Important changes:**

1. `await GetStorage.init()`: Initializes storage before app starts
2. `main() async`: Makes main function asynchronous
3. `GetMaterialApp`: Enables GetX features (navigation, etc.)

### Step 8.3: Understanding Storage Operations

**Write Data:**
```dart
final storage = GetStorage();
storage.write('key', 'value');
```

**Read Data:**
```dart
final value = storage.read('key');
```

**Delete Data:**
```dart
storage.remove('key');
```

**Clear All:**
```dart
storage.erase();
```

### Step 8.4: How Our App Uses Storage

In `task_controller.dart`, we already implemented storage:

**Saving Tasks:**
```dart
void saveTasks() {
  // Convert tasks to JSON
  List<Map<String, dynamic>> taskList = tasks
      .map((task) => task.toJson())
      .toList();

  // Save to storage
  storage.write(STORAGE_KEY, taskList);
}
```

**Loading Tasks:**
```dart
void loadTasks() {
  // Read from storage
  final List<dynamic>? storedTasks = storage.read(STORAGE_KEY);

  if (storedTasks != null) {
    // Convert JSON back to Task objects
    tasks.value = storedTasks.map((e) => Task.fromJson(e)).toList();
  }
}
```

**Flow:**
1. Task objects → `toJson()` → Map
2. Map → `storage.write()` → Saved
3. `storage.read()` → Map → `fromJson()` → Task objects

---

## Part 9: Task Detail Screen

### Step 9.1: Purpose of Detail Screen

The detail screen allows users to:
- View task details
- Toggle completion status
- See full description

### Step 9.2: Create task_detail_screen.dart

Create `lib/screens/task_detail_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';
import '../models/task.dart';

class TaskDetailScreen extends StatefulWidget {
  TaskDetailScreen({super.key, required this.task});
  Task task;

  @override
  createState() => TaskDetailScreenState();
}

class TaskDetailScreenState extends State<TaskDetailScreen> {
  final TaskController _taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext ctx) {
    final task = widget.task;

    return Scaffold(
      appBar: AppBar(
        title: Text("Details ${task.title}"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.task.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 16),
            Text(
              task.description ?? 'Pas de description',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 24),
            Text(
              'Créé le: ${task.dateCreated.day}/${task.dateCreated.month}/${task.dateCreated.year}',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _taskController.toggleTaskCompletion(
              _taskController.tasks.indexOf(task));
        },
        child: task.isCompleted
            ? Icon(Icons.check_circle, color: Colors.green)
            : Icon(Icons.circle, color: Colors.grey),
      ),
    );
  }
}
```

### Step 9.3: Navigation with GetX

In `home_screen.dart`, we navigate to detail screen:

```dart
ListTile(
  onTap: () {
    Get.to(() => TaskDetailScreen(task: task));
  },
  // ...
)
```

**GetX Navigation Benefits:**

- No context needed
- Simple syntax
- Automatic back button handling

**Traditional Navigation:**
```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => TaskDetailScreen()),
);
```

**GetX Navigation:**
```dart
Get.to(() => TaskDetailScreen());
```

---

## Part 10: Final Touches and Testing

### Step 10.1: Complete Project Structure

Verify your project structure:

```
lib/
├── main.dart
├── models/
│   └── task.dart
├── controllers/
│   └── task_controller.dart
└── screens/
    ├── home_screen.dart
    └── task_detail_screen.dart
```

### Step 10.2: Run the App

```bash
flutter run
```

### Step 10.3: Testing Features

**Test Checklist:**

- [ ] Add a task
- [ ] Task appears in list
- [ ] Toggle task completion
- [ ] Tap task to see details
- [ ] Close and reopen app (tasks should persist)
- [ ] Add multiple tasks
- [ ] Check info dialog

### Step 10.4: Common Issues and Solutions

**Issue 1: Tasks not persisting**
```dart
// Ensure GetStorage.init() is called in main()
void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}
```

**Issue 2: UI not updating**
```dart
// Make sure to use Obx() widget
Obx(() => ListView.builder(
  // ...
))

// And .obs on variables
var tasks = <Task>[].obs;
```

**Issue 3: GetX not working**
```dart
// Use GetMaterialApp instead of MaterialApp
return GetMaterialApp(
  // ...
);
```

### Step 10.5: Additional Features to Add

**Easy:**
1. Add task description input
2. Change app theme colors
3. Add task count display

**Intermediate:**
4. Add deadline/due date
5. Filter tasks (completed/incomplete)
6. Sort tasks by date

**Advanced:**
7. Categories/tags
8. Search functionality
9. Task priority levels
10. Notifications

---

## Conclusion and Next Steps

### What You've Learned

1. **Flutter Basics:**
   - Widget tree structure
   - StatefulWidget vs StatelessWidget
   - Common widgets (Container, Column, Row, ListView)

2. **GetX State Management:**
   - Observable variables (.obs)
   - Controllers (GetxController)
   - Reactive UI updates (Obx)
   - Navigation (Get.to)

3. **GetStorage:**
   - Local data persistence
   - JSON serialization (toJson/fromJson)
   - Read/Write operations

4. **App Architecture:**
   - Model-View-Controller pattern
   - Separating concerns (models, controllers, screens)
   - Clean code organization

5. **Real App Features:**
   - CRUD operations (Create, Read, Update, Delete)
   - List management
   - User input handling
   - Navigation between screens

### Next Steps

**1. Improve Your Todo App:**
```dart
// Add delete functionality
IconButton(
  icon: Icon(Icons.delete),
  onPressed: () => _taskController.removeTask(task.id),
)

// Add edit functionality
void editTask(int index, String newTitle) {
  tasks[index].title = newTitle;
  saveTasks();
  tasks.refresh();
}

// Add search
TextField(
  onChanged: (value) {
    // Filter tasks based on search
  },
)
```

**2. Learn More Flutter:**
- Animations
- Custom widgets
- HTTP requests
- Firebase integration
- State management alternatives (Provider, Riverpod, Bloc)

**3. Build More Apps:**
- Weather app (API integration)
- Notes app (rich text editing)
- Expense tracker (charts and graphs)
- Chat app (real-time data)

### Resources

**Official Documentation:**
- Flutter: https://flutter.dev/docs
- GetX: https://pub.dev/packages/get
- GetStorage: https://pub.dev/packages/get_storage

**Learning Platforms:**
- Flutter Codelabs: https://flutter.dev/codelabs
- Dart Language Tour: https://dart.dev/guides/language/language-tour
- Flutter YouTube Channel

**Community:**
- Flutter Community on Discord
- Stack Overflow (flutter tag)
- Reddit r/FlutterDev

---

## Quick Reference

### Common GetX Patterns

**1. Observable Variable:**
```dart
var count = 0.obs;
count.value++;
```

**2. Observable List:**
```dart
var items = <String>[].obs;
items.add('New item');
items.removeAt(0);
```

**3. Update UI:**
```dart
Obx(() => Text('${controller.count}'))
```

**4. Navigate:**
```dart
Get.to(() => NextScreen());
Get.back();
```

**5. Show Dialog:**
```dart
Get.dialog(AlertDialog(/* ... */));
```

**6. Show Snackbar:**
```dart
Get.snackbar('Title', 'Message');
```

### Common Flutter Widgets

```dart
// Layout
Container(), Column(), Row(), Stack(), Expanded()

// Text
Text(), TextField(), RichText()

// Buttons
ElevatedButton(), TextButton(), IconButton()

// Lists
ListView(), ListTile(), GridView()

// Input
TextField(), Checkbox(), Radio(), Switch()

// Display
Image(), Icon(), CircularProgressIndicator()

// Navigation
AppBar(), Drawer(), BottomNavigationBar()
```

### Dart Essentials

```dart
// Variables
var name = 'John';
String name = 'John';
int age = 25;
double price = 9.99;
bool isActive = true;

// Nullable
String? nullableName;
int? nullableAge;

// Lists
List<String> items = ['a', 'b', 'c'];
items.add('d');
items.removeAt(0);

// Maps
Map<String, int> ages = {'John': 25, 'Jane': 30};

// Functions
void myFunction() {}
String getString() => 'Hello';
int add(int a, int b) => a + b;

// Classes
class Person {
  String name;
  int age;

  Person({required this.name, required this.age});

  void sayHello() {
    print('Hello, I am $name');
  }
}
```

---

## Congratulations!

You've successfully built a complete Flutter Todo application with GetX state management and GetStorage for persistence. You've learned:

- How to structure a Flutter app
- State management with GetX
- Local data persistence
- Navigation
- UI design with Material widgets
- Clean code architecture

Keep building, keep learning, and most importantly, keep coding!

**Happy Flutter Development! 🚀**

---

*This tutorial was created for FL Master Africa - Week 1*
*Version 0.1 - AfriTodo Application*
