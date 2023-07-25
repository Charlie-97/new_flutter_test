import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:new_flutter_test/second_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        routes: {
          '/': (context) => MyHomePage(),
          '/second': (context) => NextPage(),
          '/third': (context) => Placeholder(),
        },
        //Define the theme of the app
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            foregroundColor: Theme.of(context).colorScheme.onSecondary,
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
        ),
        // home: MyHomePage(),
      ),
    );
  }
}

//Create class to get random word pairs
class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_outline;
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      drawer: newDrawer(context),
      appBar: newAppBar(context, "Home Page"),
      body: GeneratorPage(pair: pair, appState: appState, icon: icon),
      floatingActionButton: newFAButton(
        context,
        Icon(
          Icons.favorite,
        ),
        "second",
      ),
    );
  }

  Drawer newDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            // margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 3.0),
            padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 3.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: Row(
              children: [
                CircleAvatar(),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  "The Drawer Header",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.home),
                SizedBox(
                  width: 10.0,
                ),
                Text("Home"),
              ],
            ),
            onTap: () => Navigator.pushNamed(context, '/'),
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.favorite),
                SizedBox(
                  width: 10.0,
                ),
                Text("Favourites"),
              ],
            ),
            onTap: () => Navigator.pushNamed(context, '/second'),
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.circle),
                SizedBox(
                  width: 10.0,
                ),
                Text("Empty Page"),
              ],
            ),
            onTap: () => Navigator.pushNamed(context, '/third'),
          ),
        ],
      ),
    );
  }

  FloatingActionButton newFAButton(
      BuildContext context, Icon icon, String route) {
    return FloatingActionButton(
      onPressed: (() {
        Navigator.pushNamed(context, '/$route');
      }),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: icon,
    );
  }

  AppBar newAppBar(BuildContext context, String title) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Theme.of(context).colorScheme.onSecondary,
      ),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      ),
      centerTitle: true,
      elevation: 10.0,
    );
  }
}

class GeneratorPage extends StatelessWidget {
  const GeneratorPage({
    super.key,
    required this.pair,
    required this.appState,
    required this.icon,
  });

  final WordPair pair;
  final MyAppState appState;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('A random idea:'),
          BigCard(pair: pair),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(
                width: 10.0,
              ),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    Key? key,
    required this.pair,
  }) : super(key: key);

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final wordStyle = theme.textTheme.displayLarge!.copyWith(
      color: theme.colorScheme.onSecondary,
    );

    return Card(
      color: theme.colorScheme.secondary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          pair.asPascalCase,
          style: wordStyle,
          semanticsLabel: pair.asPascalCase,
        ),
      ),
    );
  }
}
