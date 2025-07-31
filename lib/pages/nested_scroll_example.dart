import 'package:flutter/material.dart';

class NestedScrollViewExample extends StatefulWidget {
  const NestedScrollViewExample({super.key});

  @override
  State<NestedScrollViewExample> createState() =>
      _NestedScrollViewExampleState();
}

class _NestedScrollViewExampleState extends State<NestedScrollViewExample>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> tabs = ['Tab 1', 'Tab 2', 'Tab 3'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget buildList(String tab) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: 30,
      itemBuilder: (context, index) =>
          ListTile(title: Text('$tab - Item ${index + 1}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: Text('NestedScrollView Example'),
              pinned: true,
              floating: true,
              snap: true,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  'https://picsum.photos/600/300',
                  fit: BoxFit.cover,
                ),
              ),
              bottom: TabBar(
                controller: _tabController,
                tabs: tabs.map((tab) => Tab(text: tab)).toList(),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: tabs.map((tab) => buildList(tab)).toList(),
        ),
      ),
    );
  }
}
