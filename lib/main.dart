import 'package:flutter/material.dart';

import 'pages/use_paginate_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter ',
      // home: TabBarWidget(),
      home: const UsePaginatePage(),
      // home: TestUseCustomDropDown(),
      // home: NestedScrollViewExample(),
      // home: CustomScrollViewWithTabsExample(),
    );
  }
}
