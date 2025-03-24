import 'package:flutter/material.dart';

class PaginationExample extends StatefulWidget {
  @override
  _PaginationExampleState createState() => _PaginationExampleState();
}

class _PaginationExampleState extends State<PaginationExample> {
  final ScrollController _scrollController = ScrollController();
  List<int> numbers = List.generate(40, (index) => index + 1);
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _loadMoreData();
    }
  }

  Future<void> _loadMoreData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      // Simulate API delay
      await Future.delayed(Duration(seconds: 3));

      List<int> newNumbers = List.generate(40, (index) => numbers.length + index + 1);
      setState(() {
        numbers.addAll(newNumbers);
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pagination Example")),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: numbers.length + 1, // Extra item for the loader
        itemBuilder: (context, index) {
          if (index == numbers.length) {
            return isLoading
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: CircularProgressIndicator()),
                  )
                : SizedBox.shrink();
          }
          return ListTile(
            title: Text("Item ${numbers[index]}"),
          );
        },
      ),
    );
  }
}
