import 'package:flutter/material.dart';

class ListWidget extends StatelessWidget {

  List<dynamic> data;
  ImageProvider leading;

  bool isLoading = false;
  bool isFetchError = false;

  Function(int index) onTap;
  Function onPressed;
  Function onRefresh;
  Function(int index) title;
  Function(int index) subtitle;
  Function(int index)? row;

  ListWidget({ 
    super.key, 
    required this.data, 
    required this.leading, 
    required this.isLoading, 
    required this.isFetchError, 
    required this.onTap, 
    required this.onPressed,
    required this.onRefresh,
    required this.title, 
    required this.subtitle, 
    this.row 
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
       child: SizedBox(
          height: MediaQuery.of(context).size.height - 180,
          width: MediaQuery.of(context).size.width,
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
            ListView.separated(
              padding: const EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
              separatorBuilder: (context, index) => const Divider(height: 16),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async => onTap(index),
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Image(image: leading, width: 32),
                            title: Text(title(index).toString(), overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 18)),
                            subtitle: Text(subtitle(index).toString()),
                          ),
                          row!(index)
                        ],
                      ),
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