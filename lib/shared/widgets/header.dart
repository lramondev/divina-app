import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {

  int? from;
  int? to;
  int? total;

  HeaderWidget({ super.key, this.from, this.to, this.total });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text('Exibindo: ${from ?? 0} - ${to ?? 0} / ${total ?? 0}', style: const TextStyle(fontSize: 18)),
          )
        ],
      )
    );
  }
}