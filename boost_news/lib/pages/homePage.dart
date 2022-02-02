import 'package:flutter/material.dart';
import 'package:news_app/pages/app_bar.dart';
import 'package:news_app/pages/everything.dart';
import 'package:news_app/pages/headlines.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBars(),
        body: TabBarView(
          children: [
            Headlines(),
            Everything(),
          ],
        ),
      ),
    );
  }
}
