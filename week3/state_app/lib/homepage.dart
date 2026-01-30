import 'package:flutter/material.dart';

// imuabble widget : Ce qidget ne changes pas une fois qu'il est construit
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _counterController = TextEditingController();
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _counter = 10;
  }

  void _decrementerCounter() {
    setState(() {
      _counter >= 10 ? _counter = _counter - 10 : _counter = 0;
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter = _counter + 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text("Veillew entrer le nombre initial du compteur"),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _counterController,
                keyboardType: TextInputType.number,
                onChanged: (value) => {
                  setState(() {
                    _counter = int.tryParse(value) ?? 0;
                  }),
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Entrez un nombre',
                ),
              ),
            ),
            const Text('Vous avez cliquer sur ce bouton :'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text("Fois"),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: _decrementerCounter,
            tooltip: 'Decremeter',
            child: const Icon(Icons.remove),
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
