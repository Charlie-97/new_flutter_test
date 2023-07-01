import 'package:flutter/material.dart';
import 'package:new_flutter_test/second_page.dart';

void main() {
  runApp(MaterialApp(
    home: const MyApp(),
    routes: {
      '/home': (context) => const MyApp(),
      '/nextPage': (context) => const NextPage(),
    },
    theme: ThemeData.from(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Tile 1'),
              onTap: () {
                print('Tap recieved');
                Navigator.pushNamed(context, '/nextPage');
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Tile 2'),
              onTap: () {
                Navigator.pushNamed(context, '/home');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("A New Flutter Test"),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "This is a counter:",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              "$counter",
              style: const TextStyle(
                fontSize: 30.0,
              ),
            ),
            const SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  onPressed: () {
                    if (counter > 0) {
                      setState(() {
                        counter--;
                      });
                    } else {
                      counter = 0;
                    }
                  },
                  icon: const Icon(Icons.remove),
                  label: const Text("Decrease Counter"),
                  style: TextButton.styleFrom(
                      // backgroundColor: ColorScheme.fromSwatch().primary,
                      ),
                ),
                ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        counter++;
                      });
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Increase Counter")),
              ],
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/nextPage');
              },
              child: const Text('Next Page >'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            counter = 0;
          });
        },
        child: const Icon(Icons.refresh),
        tooltip: "Reset the counter",
      ),
    );
  }
}
