import 'package:flutter/material.dart';

class ListWidget extends StatelessWidget {

  List<dynamic> data;

  bool isLoading = false;
  bool isFetchError = false;

  Function onPressed;
  Function onRefresh;
  Function(int index) onTap;
 
  Function(int index) title;
  Function(int index) subtitle;
  ImageProvider Function(int index) leading;

  ListWidget({ 
    super.key, 
    required this.data, 
    required this.isLoading, 
    required this.isFetchError, 
    required this.onTap, 
    required this.onPressed,
    required this.onRefresh,
    required this.title, 
    required this.subtitle,
    required this.leading, 
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.transparent
        ),
        child: isFetchError ? 
          Center(
            child: Ink(
              decoration: BoxDecoration(
                color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.refresh_outlined), 
                onPressed: () => onRefresh(),
              ),
            )
          ) : (isLoading ? const Center(child: CircularProgressIndicator()) : 
          ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async => onTap(index),
                /*customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),*/
                child: Card(
                  color: Colors.transparent,
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  /*shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)
                  ),*/
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: CircleAvatar(backgroundImage: leading(index), radius: 28),
                        title: Text(title(index).toString(), overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 18)),
                        subtitle: Text(subtitle(index) != null ? subtitle(index).toString() : '', overflow: TextOverflow.ellipsis),
                      )
                    ],
                  ),
                ),
              );
            }
          )
        )
      )
    );
  }
}