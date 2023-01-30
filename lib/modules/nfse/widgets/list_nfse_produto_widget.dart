import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/nfse_model.dart';

ListView listNfseProdutoWidget (Nfse? nfse) {
  return ListView.builder(
    padding: const EdgeInsets.only(top: 0),
    shrinkWrap: true,
    itemCount: nfse!.nfse_produto.length,
    itemBuilder: (BuildContext context, int index) {
      return ListTile(
        dense: true,
        title: Text('${nfse.nfse_produto[index]!.item} - ${nfse.nfse_produto[index]!.descricao} (${nfse.nfse_produto[index]!.codigo})'),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${(NumberFormat('#,###.00', 'pt_BR').format(nfse.nfse_produto[index]!.quantidade))} X R\$ ${(NumberFormat('#,###.00', 'pt_BR')).format(nfse.nfse_produto[index]!.valor_unitario)}'),
            Text('R\$ ${(NumberFormat('#,###.00', 'pt_BR')).format(nfse.nfse_produto[index]!.total)}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        ),
      );
    }
  );
}