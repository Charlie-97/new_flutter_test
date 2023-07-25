import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:new_flutter_test/main.dart';
import 'package:provider/provider.dart';

class NextPage extends StatefulWidget {
  const NextPage({super.key});

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  MyHomePage homePageObj = MyHomePage();
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return Scaffold(
        drawer: homePageObj.newDrawer(context),
        appBar: homePageObj.newAppBar(context, "Favourites Page"),
        body: Container(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Center(
            child: Text(
              'No Favourites yet',
              style: TextStyle(
                fontSize: 20.0,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ),
        ),
        floatingActionButton: homePageObj.newFAButton(
          context,
          Icon(Icons.home),
          '',
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        drawer: homePageObj.newDrawer(context),
        appBar: homePageObj.newAppBar(context, "Favourites Page"),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Text('You have '
                  '${appState.favorites.length} favourites:'),
            ),
            for (var pair in appState.favorites)
              ListTile(
                leading: IconButton(
                  onPressed: () {
                    setState(() {
                      appState.favorites.remove(pair);
                    });
                  },
                  icon: Icon(Icons.delete),
                ),
                title: Text(pair.asPascalCase),
              ),
          ],
        ),
        floatingActionButton: homePageObj.newFAButton(
          context,
          Icon(Icons.home),
          '',
        ),
      );
    }
  }
}
