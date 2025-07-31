import 'package:flutter/material.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: scaffoldKey,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: const [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text(
                  'Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              ListTile(leading: Icon(Icons.home), title: Text('Home')),
              ListTile(leading: Icon(Icons.settings), title: Text('Settings')),
            ],
          ),
        ),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            color: Colors.blue,
            child: SafeArea(
              child: Row(
                children: [
                  // Menu icon that opens drawer
                  IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white),
                    onPressed: () {
                      scaffoldKey.currentState?.openDrawer();
                    },
                  ),
                  // TabBar in the same row
                  Expanded(
                    child: TabBar(
                      indicatorColor: Colors.white,
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.white70,
                      tabs: const [
                        Tab(text: 'Tab 1', icon: Icon(Icons.abc)),
                        Tab(text: 'Tab 2', icon: Icon(Icons.perm_camera_mic)),
                        Tab(text: 'Tab 3', icon: Icon(Icons.import_contacts)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('Content for Tab 1')),
            Center(child: Text('Content for Tab 2')),
            Center(child: Text('Content for Tab 3')),
          ],
        ),
      ),
    );
  }
}
