import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../widgets/list_nfe_produto_widget.dart';

import 'package:divina/modules/nfe/nfe_store.dart';
import 'package:divina/modules/nfe/models/nfe_model.dart';


class ViewPage extends StatefulWidget {
  const ViewPage({super.key});

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {

  Nfe? nfe;
  NfeStore nfeStore = Modular.get<NfeStore>();

  @override
  Widget build(BuildContext context) {

    if (ModalRoute.of(context)!.settings.arguments != null) {
      nfe = ModalRoute.of(context)!.settings.arguments as Nfe;
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
            floatingActionButton: nfeStore.isLoading ? const Padding(
              padding: EdgeInsets.all(12),
              child: CircularProgressIndicator(),
            ) : 
            FloatingActionButton(
              onPressed: () async {
                await nfeStore.approve(nfe).then((value) {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(value[0].message, style: const TextStyle(fontSize: 18), textAlign: TextAlign.center)
                    )
                  );
                  if(value[0].type != 'error') Modular.to.pop(true);      
                });
              },
              child: nfeStore.isLoading ? const CircularProgressIndicator() : const Icon(Icons.check, color: Colors.white),
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 12, right: 12, top: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Image.asset('assets/img/nfe-64.png', width: 48),
                    trailing: PopupMenuButton(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16))
                      ),
                      onSelected: (value) async => {
                        await Modular.to.pushNamed(value, arguments: nfe)
                      },
                      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: '/nfe/fatura/',
                          child: Text('Ver Fatura'),
                        ),
                        const PopupMenuItem<String>(
                          value: '/nfe/danfe/',
                          child: Text('Ver DANFe'),
                        ),
                      ],
                    ),
                    title: Text(nfe != null ? 'Nº ${nfe!.numero.toString()} / ${nfe!.serie.toString()}'  : '', overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 18)),
                    subtitle: Text(DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(nfe!.datahora_emissao)), overflow: TextOverflow.ellipsis)
                  ),
                  const Divider(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Text('Detalhes'),
                  ),
                  ListTile(
                    dense: true,
                    title: Text(nfe != null ? nfe!.emitente.nome_razao_social : '', overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 18)),
                    subtitle: Text(nfe != null ? nfe!.emitente.cpf_cnpj : ''),
                  ),
                  ListTile(
                    dense: true,
                    title: Text(nfe != null ? nfe!.destinatario.nome_razao_social : '', overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 18)),
                    subtitle: Text(nfe != null ? nfe!.destinatario.cpf_cnpj : ''),
                  ),
                  const Divider(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Text('Observação'),
                  ),
                  nfe!.observacao != null ? ListTile(
                    dense: true,
                    title: Text((nfe!.observacao != null ? '${nfe?.observacao}' : ''), style: const TextStyle(fontSize: 16)),
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
                    child: listNfeProdutoWidget(nfe)
                  ),
                  const Divider(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Text('Total'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('R\$ ${(NumberFormat('#,###.00', 'pt_BR')).format(nfe!.total)}', style: const TextStyle(fontSize: 24))
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