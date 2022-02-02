import 'package:flutter/material.dart';
import 'package:news_app/pages/search/search_page.dart';

class AppBars extends StatefulWidget with PreferredSizeWidget {
  @override
  _AppBarsState createState() => _AppBarsState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 1.7);
}

class _AppBarsState extends State<AppBars> {
  @override
  Widget build(BuildContext context) {
    Widget customTitle = Image.asset(
      'images/logo.png',
      width: 70,
      height: 40,
    );

    return AppBar(
      title: customTitle,
      automaticallyImplyLeading: false,
      actions: [SearchPage()],
      bottom: TabBar(
        indicatorColor: Colors.amber[700],
        indicatorWeight: 3.0,
        unselectedLabelColor: Colors.white,
        tabs: const [
          Tab(
            child: Text(
              'Headlines',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Tab(
            child: Text(
              'News',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
