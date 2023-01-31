import 'package:flutter/material.dart';

class ListWidget extends StatelessWidget {

  bool isLoading = false;
  bool isFetchError = false;

  List<dynamic> data;
  ImageProvider Function(int index) leading;

  int Function(int index) status;
  Function onPressed;
  Function onRefresh;
  Function(int index) onTap;
 
  Function(int index) title;
  Function(int index) subtitle;

  ListWidget({ 
    super.key, 
    required this.isLoading, 
    required this.isFetchError, 
    required this.data, 
    required this.status,
    required this.onPressed,
    required this.onRefresh,
    required this.onTap, 
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
                        leading: Stack(
                          children: [
                            CircleAvatar(backgroundImage: leading(index), radius: 28),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                  width: 1,
                                  color: Colors.white
                                ),
                                borderRadius: BorderRadius.circular(90),
                                color: status(index) == 0 ? Colors.grey : status(index) == 1 ? Colors.green : Colors.amber
                                )
                              )
                            )
                          ]
                        ),
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