# Difference Between CustomScrollView and NestedScrollView

| Feature                        | CustomScrollView                                          | NestedScrollView                                    |
| ------------------------------ | --------------------------------------------------------- | --------------------------------------------------- |
| **Purpose**                    | Build custom scrollable layouts with slivers              | Coordinate scrolling between outer and inner views   |
| **Scroll Behavior**            | Single continuous scroll                                   | Sync scroll between parent and child scrollables     |
| **Use Case**                   | Custom complex scroll effects (lists, grids, headers)     | Collapsible app bars with tabs or nested lists       |
| **Scroll Coordination**        | Manual control needed                                      | Automatic coordination of nested scrolls             |
| **Widgets Used**               | Uses slivers (SliverList, SliverGrid, SliverAppBar, etc.)| Uses inner scroll views inside a parent scroll view  |
| **Handling Collapsing Header** | Requires building with SliverAppBar                       | Built-in support for header and body coordination     |
| **Complexity**                 | More flexible but requires more setup                     | Easier for nested scroll scenarios                   |
| **Scrolling Conflicts**        | May occur if nesting scrollables                           | Avoids scroll conflicts automatically                |