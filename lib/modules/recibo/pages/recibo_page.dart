import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:divina/modules/recibo/recibo_store.dart';

import 'package:divina/shared/widgets/dataview.dart';

class ReciboPage extends StatefulWidget {
  const ReciboPage({super.key});

  @override
  State<ReciboPage> createState() => _ReciboPageState();
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

class _ReciboPageState extends State<ReciboPage> {

  ReciboStore reciboStore = Modular.get<ReciboStore>();

  final _focusNode = FocusNode();
  final _searchController = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 1000);

  @override
  void initState() {
    super.initState();
    reciboStore.list();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(reciboStore.isSearching == true) {
          _searchController.text = "";
          reciboStore.setSearching(false);
          reciboStore.list();
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
              pageTitle: 'Recibo',
              apiRequest: reciboStore.apiRequest,
              apiResponse: reciboStore.apiResponse,
              data: reciboStore.data, 
              leading: const AssetImage('assets/img/recibo-32.png'), 
              isLoading: reciboStore.isLoading,
              isFetchError: reciboStore.isFetchError,
              isSearching: reciboStore.isSearching,
              setSearching: (value) => reciboStore.setSearching(value),
              search: (value) {  
                reciboStore.apiRequest.text = value; 
                reciboStore.list();
              },
              onTap: (int index) async {
                var response = await Modular.to.pushNamed('/recibo/view/', arguments: reciboStore.data[index]);
                if(response == true) reciboStore.list();
              },
              onPressed: (int index) => reciboStore.list(),
              onRefresh: (int index) => reciboStore.list(),
              nextPage: () => reciboStore.next(),
              backPage: () => reciboStore.back(),
              title: (int index) => reciboStore.data[index].emitente.nome_razao_social, 
              subtitle: (int index) => reciboStore.data[index].numero,
              row: (int index) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(DateFormat('dd/MM/yy HH:mm').format(DateTime.parse(reciboStore.data[index].datahora_emissao)), overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 16)),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.only(top: 8, bottom: 8, right: 16),
                      child: Text('R\$ ${(NumberFormat('#,###.00', 'pt_BR')).format(reciboStore.data[index].total)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
