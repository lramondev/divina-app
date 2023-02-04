import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:divina/modules/recibo/recibo_store.dart';
import 'package:divina/modules/recibo/models/recibo_model.dart';
import 'package:divina/modules/recibo/widgets/list_recibo_produto_widget.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({super.key});

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {

  Recibo? recibo;
  ReciboStore reciboStore = Modular.get<ReciboStore>();

  @override
  Widget build(BuildContext context) {

    if (ModalRoute.of(context)!.settings.arguments != null) {
      recibo = ModalRoute.of(context)!.settings.arguments as Recibo;
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
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
          return Scaffold(
            floatingActionButton: reciboStore.isLoading ? const Padding(
              padding: EdgeInsets.all(12),
              child: CircularProgressIndicator(),
            ) : FloatingActionButton(
              onPressed: () async {
                await reciboStore.approve(recibo).then((value) {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(value[0].message, style: const TextStyle(fontSize: 18), textAlign: TextAlign.center)
                    )
                  );
                  if(value[0].type != 'error') Modular.to.pop(true);      
                });
              },
              child: reciboStore.isLoading ? const CircularProgressIndicator() : const Icon(Icons.check, color: Colors.white),
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 12, right: 12, top: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Image.asset('assets/img/recibo-64.png', width: 48),
                    trailing: PopupMenuButton(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16))
                      ),
                      onSelected: (value) async => {
                        await Modular.to.pushNamed(value, arguments: recibo)
                      },
                      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: '/recibo/fatura/',
                          child: Text('Ver Fatura'),
                        ),
                        const PopupMenuItem<String>(
                          value: '/recibo/pdf/',
                          child: Text('Ver PDF'),
                        ),
                      ],
                    ),
                    title: Text(recibo != null ? 'Nº ${recibo!.numero.toString()} / ${recibo!.serie.toString()}'  : '', overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 18)),
                    subtitle: Text(DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(recibo!.datahora_emissao)), overflow: TextOverflow.ellipsis)
                  ),
                  const Divider(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Text('Detalhes'),
                  ),
                  ListTile(
                    dense: true,
                    title: Text(recibo != null ? recibo!.emitente.nome_razao_social : '', overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 18)),
                    subtitle: Text(recibo != null ? recibo!.emitente.cpf_cnpj : ''),
                  ),
                  ListTile(
                    dense: true,
                    title: Text(recibo != null ? recibo!.destinatario.nome_razao_social : '', overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 18)),
                    subtitle: Text(recibo != null ? recibo!.destinatario.cpf_cnpj : ''),
                  ),
                  const Divider(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Text('Observação'),
                  ),
                  recibo!.observacao != null ? ListTile(
                    dense: true,
                    title: Text((recibo!.observacao != null ? '${recibo?.observacao}' : ''), style: const TextStyle(fontSize: 16)),
                  ) : Container(),
                  const Divider(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Text('Produtos'),
                  ),
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height - 480,
                    ),
                    child: listReciboProdutoWidget(recibo)
                  ),
                  const Divider(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Text('Total'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('R\$ ${(NumberFormat('#,###.00', 'pt_BR')).format(recibo!.total)}', style: const TextStyle(fontSize: 24))
                    ],
                  )
                ],
              ),
            ),
          );
        }
      )
    );
  }
}