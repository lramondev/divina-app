import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:divina/modules/nfe/nfe_store.dart';

import 'package:divina/shared/widgets/dataview.dart';

class NfePage extends StatefulWidget {
  const NfePage({super.key});

  @override
  State<NfePage> createState() => _NfePageState();
}

class _NfePageState extends State<NfePage> {

  NfeStore nfeStore = Modular.get<NfeStore>();

  @override
  void initState() {
    super.initState();
    nfeStore.list();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(nfeStore.isSearching == true) {
          nfeStore.setSearching(false);
          nfeStore.list();
          return false;
        } 
        return true;
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: Theme.of(context).brightness == Brightness.dark ? SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
          systemNavigationBarIconBrightness: Brightness.light
        ) : SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
          systemNavigationBarIconBrightness: Brightness.dark
        ),
        child: Observer(
          builder: (context) {
            return DataViewWidget(
              pageTitle: 'NFe',
              apiRequest: nfeStore.apiRequest,
              apiResponse: nfeStore.apiResponse,
              data: nfeStore.data, 
              leading: const AssetImage('assets/img/nfe-32.png'), 
              isLoading: nfeStore.isLoading,
              isFetchError: nfeStore.isFetchError,
              isSearching: nfeStore.isSearching,
              setSearching: (value) => nfeStore.setSearching(value),
              search: (value) {  
                nfeStore.apiRequest.text = value; 
                nfeStore.list();
              },
              onTap: (int index) async {
                var response = await Modular.to.pushNamed('/nfe/view/', arguments: nfeStore.data[index]);
                if(response == true) nfeStore.list();
              },
              onPressed: (int index) => nfeStore.list(),
              onRefresh: (int index) => nfeStore.list(),
              nextPage: () => nfeStore.next(),
              backPage: () => nfeStore.back(),
              title: (int index) => nfeStore.data[index].emitente.nome_razao_social, 
              subtitle: (int index) => nfeStore.data[index].numero,
              row: (int index) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(DateFormat('dd/MM/yy HH:mm').format(DateTime.parse(nfeStore.data[index].datahora_emissao)), overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 16)),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.only(top: 8, bottom: 8, right: 16),
                      child: Text('R\$ ${(NumberFormat('#,###.00', 'pt_BR')).format(nfeStore.data[index].total)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
