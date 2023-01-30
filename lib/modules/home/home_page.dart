import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:divina/network/endpoints.dart';

import 'package:divina/modules/app/app_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  AppStore appStore = Modular.get<AppStore>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Platform.isIOS
          ? exit(0)
          : SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return true;
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
          systemNavigationBarIconBrightness: Theme.of(context).brightness == Brightness.dark ? Brightness.light : Brightness.dark
        ),
        child: Observer(
          builder: (context) {
            return appStore.isLoading ? const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ) : 
            Scaffold(
              extendBody: true,
              extendBodyBehindAppBar: true,
              floatingActionButton: FloatingActionButton(
                onPressed: () => Modular.to.pushNamed('/chat/'),
                child: const Icon(Icons.chat, color: Colors.white),
              ),
              body: Stack(
                children: <Widget>[
                  Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: 108,
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(32),
                                bottomRight: Radius.circular(32)
                              )
                            ),
                          
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 24, left: 24),
                                        child: CircleAvatar(
                                          radius: 32,
                                          backgroundImage: CachedNetworkImageProvider('${Endpoints.baseUrl}${appStore.user.avatar_url}')
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 32, left: 16),
                                        child: Text(appStore.user.name.split(' ').first, style: const TextStyle(fontSize: 22)),
                                      )
                                    ],
                                  )
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 24, left: 12),
                                        child: IconButton(
                                          icon: const Icon(Icons.notifications_outlined),
                                          onPressed: () => {},
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 24, right: 12),
                                        child: IconButton(
                                          icon: const Icon(Icons.exit_to_app),
                                          onPressed: () {
                                            appStore.logout().then((value) {
                                              ScaffoldMessenger.of(context).clearSnackBars();
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(
                                                  content:  Text('Você saiu!', style: TextStyle(fontSize: 18), textAlign: TextAlign.center)
                                                )
                                              );
                                              Modular.to.popAndPushNamed('/login/');
                                            });
                                          }
                                        ),
                                      )
                                    ],
                                  )
                                )
                              ],
                            )
                          ),
                          const Divider(
                            height: 2
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height - 134,
                            margin: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16)
                              )
                            ),
                            child: GridView.count(
                              childAspectRatio: 1.0,
                              padding: const EdgeInsets.all(16),
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Modular.to.pushNamed('/nfe/');
                                  },
                                  customBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)
                                    ),
                                    elevation: 1,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const <Widget>[
                                        Text('NFe', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Modular.to.pushNamed('/nfse/');
                                  },
                                  customBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)
                                    ),
                                    elevation: 1,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const <Widget>[
                                        Text('NFSe', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Modular.to.pushNamed('/recibo/');
                                  },
                                  customBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)
                                    ),
                                    elevation: 1,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const <Widget>[
                                        Text('Recibo', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          )
                        ],
                      ),
                    ),
                  )
                ]
              )
            );
          }
        )
      )
    );
  }
}
