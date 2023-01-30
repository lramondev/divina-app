import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DanfePage extends StatefulWidget {
  const DanfePage({super.key});

  @override
  State<DanfePage> createState() => _DanfePageState();
}

class _DanfePageState extends State<DanfePage> {
  @override
  Widget build(BuildContext context) {
    
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
        systemNavigationBarIconBrightness: Theme.of(context).brightness == Brightness.dark ? Brightness.light : Brightness.dark
      ),
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(left: 12, right: 12, top: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                leading: Image.asset('assets/img/pdf-64.png', width: 48),
                title: const Text('DANFe', overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 18)),
                subtitle: const Text('subtitle', overflow: TextOverflow.ellipsis)
              ),
              const Divider(),
            ],
          )
        )
      )
    );
  }
}