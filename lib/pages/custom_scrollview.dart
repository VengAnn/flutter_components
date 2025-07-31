import 'package:flutter/material.dart';

class CustomScrollViewWithTabsExample extends StatefulWidget {
  const CustomScrollViewWithTabsExample({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomScrollViewWithTabsExampleState createState() =>
      _CustomScrollViewWithTabsExampleState();
}

class _CustomScrollViewWithTabsExampleState
    extends State<CustomScrollViewWithTabsExample>
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

  Widget _buildList(String tab) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(), // Disable inner scroll
      shrinkWrap: true, // Let ListView take minimum height
      itemCount: 30,
      itemBuilder: (context, index) {
        return ListTile(title: Text('$tab Item $index'));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Collapsible AppBar with flexible space and TabBar
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            floating: true,
            snap: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('CustomScrollView Example'),
              background: Image.network(
                'https://picsum.photos/600/300',
                fit: BoxFit.cover,
              ),
            ),
            bottom: TabBar(
              controller: _tabController,
              tabs: tabs.map((e) => Tab(text: e)).toList(),
            ),
          ),

          // SliverFillRemaining fills the rest of the viewport
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: tabs.map((tab) {
                // Wrap each tab content in SingleChildScrollView
                return SingleChildScrollView(child: _buildList(tab));
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
