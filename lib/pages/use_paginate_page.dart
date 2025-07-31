import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class UsePaginatePage extends StatefulWidget {
  const UsePaginatePage({super.key});

  @override
  State<UsePaginatePage> createState() => _UsePaginatePageState();
}

class _UsePaginatePageState extends State<UsePaginatePage> {
  static const int _pageSize = 10;

  PagingState<int, Map<String, dynamic>> _state = PagingState(
    pages: [],
    keys: [],
    hasNextPage: true,
    error: null,
    isLoading: false,
  );

  final Dio _dio = Dio();

  Future<void> _fetchNextPage() async {
    if (_state.isLoading || !(_state.hasNextPage)) return;

    setState(() {
      _state = _state.copyWith(isLoading: true, error: null);
    });

    // delay to see loading indicator a bit long time
    await Future.delayed(const Duration(seconds: 1));

    final currentPageKey = (_state.keys?.isNotEmpty ?? false)
        ? _state.keys!.last
        : 0;

    try {
      final response = await _dio.get(
        'https://dummyjson.com/products',
        queryParameters: {
          'limit': _pageSize,
          'skip': currentPageKey,
          // 'select': 'title,price',
        },
      );

      final List newItems = response.data['products'] ?? [];

      final isLastPage = newItems.length < _pageSize;
      final nextPageKey = currentPageKey + newItems.length;

      final updatedPages = [
        ...?_state.pages,
        newItems.cast<Map<String, dynamic>>(),
      ];

      final updatedKeys = [...?_state.keys, nextPageKey];

      setState(() {
        _state = _state.copyWith(
          pages: updatedPages,
          keys: updatedKeys,
          hasNextPage: !isLastPage,
          isLoading: false,
          error: null,
        );
      });
    } catch (error) {
      setState(() {
        _state = _state.copyWith(isLoading: false, error: error);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchNextPage();
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint('Current State: $_state');

    return Scaffold(
      appBar: AppBar(title: const Text('Paginated Products')),
      body: PagedListView<int, Map<String, dynamic>>(
        state: _state,
        fetchNextPage: _fetchNextPage,
        builderDelegate: PagedChildBuilderDelegate<Map<String, dynamic>>(
          itemBuilder: (context, item, index) => ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text(item['title'] ?? 'No Title'),
            subtitle: Text('Price: \$${item['price'] ?? 'N/A'}'),
            trailing:
                item["thumbnail"] != null &&
                    item["thumbnail"].toString().isNotEmpty
                ? Image.network(
                    item["thumbnail"],
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.broken_image, size: 50),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return SizedBox(
                        width: 100,
                        height: 100,
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                  )
                : const Icon(Icons.image_not_supported, size: 50),
          ),
          firstPageErrorIndicatorBuilder: (context) => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Failed to load products.'),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _fetchNextPage,
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
          noItemsFoundIndicatorBuilder: (context) =>
              const Center(child: Text('No products found.')),
          newPageErrorIndicatorBuilder: (context) => Center(
            child: ElevatedButton(
              onPressed: _fetchNextPage,
              child: const Text('Retry Loading More'),
            ),
          ),

          noMoreItemsIndicatorBuilder: (context) => const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'No more products',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          ),
          //
          newPageProgressIndicatorBuilder: (context) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    strokeWidth: 14,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
