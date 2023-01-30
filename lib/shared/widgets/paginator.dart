import 'package:flutter/material.dart';

class PaginatorWidget extends StatelessWidget {
  
  final bool isLoading;
  final int currentPage;
  final int lastPage;

  Function backPage;
  Function nextPage;

  PaginatorWidget({ super.key, required this.isLoading, required this.currentPage, required this.lastPage, required this.backPage, required this.nextPage });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: isLoading ? null : backPage()
          ),
          SizedBox(
            height: 48,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text('$currentPage / $lastPage', style: const TextStyle(fontSize: 20))
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: isLoading ? null : nextPage(),
          )
        ],
      ),
    );
  }
}
