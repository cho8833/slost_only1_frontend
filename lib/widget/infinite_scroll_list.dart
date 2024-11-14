import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:slost_only1/support/server_response.dart';

class InfiniteScrollList<T> extends StatefulWidget {
  const InfiniteScrollList(
      {super.key,
      required this.pageRequest,
      required this.onMount,
      required this.itemBuilder});

  final Future<PagedData<T>> Function(int) pageRequest;

  final void Function(PagingController) onMount;

  final Widget Function(BuildContext, T, int) itemBuilder;

  @override
  State<InfiniteScrollList<T>> createState() => _InfiniteScrollListState();
}

class _InfiniteScrollListState<T> extends State<InfiniteScrollList<T>> {
  final PagingController<int, T> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    widget.onMount(_pagingController);
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      PagedData<T> fetch = await widget.pageRequest(pageKey);

      final bool isLastPage = fetch.last!;
      if (isLastPage) {
        _pagingController.appendLastPage(fetch.content);
      } else {
        final int nextPageKey = pageKey + 1;
        _pagingController.appendPage(fetch.content, nextPageKey);
      }
    } catch (e) {
      _pagingController.error = e;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView.separated(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<T>(
            itemBuilder: (context, item, index) =>
                widget.itemBuilder(context, item, index)),
        separatorBuilder: (context, index) => const SizedBox(
              height: 8,
            ));
  }
}
