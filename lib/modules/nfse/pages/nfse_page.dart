import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:divina/modules/nfse/nfse_store.dart';

import 'package:divina/shared/widgets/dataview.dart';

class NfsePage extends StatefulWidget {
  const NfsePage({super.key});

  @override
  State<NfsePage> createState() => _NfsePageState();
}

class Debouncer {
   Debouncer({required this.milliseconds});
   final int milliseconds;
   Timer? _timer;
   void run(VoidCallback action) {
      if (_timer?.isActive ?? false) _timer?.cancel();
      _timer = Timer(Duration(milliseconds: milliseconds), action);
   }
}

class _NfsePageState extends State<NfsePage> {

  NfseStore nfseStore = Modular.get<NfseStore>();

  final _focusNode = FocusNode();
  final _searchController = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 1000);

  @override
  void initState() {
    super.initState();
    nfseStore.list();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(nfseStore.isSearching == true) {
          _searchController.text = "";
          nfseStore.setSearching(false);
          nfseStore.list();
          return false;
        } 
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
            return DataViewWidget(
              pageTitle: 'NFSe',
              apiRequest: nfseStore.apiRequest,
              apiResponse: nfseStore.apiResponse,
              data: nfseStore.data, 
              leading: const AssetImage('assets/img/nfse-32.png'), 
              isLoading: nfseStore.isLoading,
              isFetchError: nfseStore.isFetchError,
              isSearching: nfseStore.isSearching,
              setSearching: (value) => nfseStore.setSearching(value),
              search: (value) {  
                nfseStore.apiRequest.text = value; 
                nfseStore.list();
              },
              onTap: (int index) async {
                var response = await Modular.to.pushNamed('/nfse/view/', arguments: nfseStore.data[index]);
                if(response == true) nfseStore.list();
              },
              onPressed: (int index) => nfseStore.list(),
              onRefresh: (int index) => nfseStore.list(),
              nextPage: () => nfseStore.next(),
              backPage: () => nfseStore.back(),
              title: (int index) => nfseStore.data[index].emitente.nome_razao_social, 
              subtitle: (int index) => nfseStore.data[index].numero,
              row: (int index) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(DateFormat('dd/MM/yy HH:mm').format(DateTime.parse(nfseStore.data[index].datahora_emissao)), overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 16)),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.only(top: 8, bottom: 8, right: 16),
                      child: Text('R\$ ${(NumberFormat('#,###.00', 'pt_BR')).format(nfseStore.data[index].total)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              )
            );
          }
        )
      )
    );
  }
}
