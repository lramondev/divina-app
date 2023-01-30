import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/nfe_model.dart';

ListView listNfeProdutoWidget (Nfe? nfe) {
  return ListView.builder(
    padding: const EdgeInsets.only(top: 0),
    shrinkWrap: true,
    itemCount: nfe!.nfe_produto.length,
    itemBuilder: (BuildContext context, int index) {
      return ListTile(
        dense: true,
        title: Text('${nfe.nfe_produto[index]!.item} - ${nfe.nfe_produto[index]!.descricao} (${nfe.nfe_produto[index]!.codigo})'),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${(NumberFormat('#,###.00', 'pt_BR').format(nfe.nfe_produto[index]!.quantidade))} X R\$ ${(NumberFormat('#,###.00', 'pt_BR')).format(nfe.nfe_produto[index]!.valor_unitario)}'),
            Text('R\$ ${(NumberFormat('#,###.00', 'pt_BR')).format(nfe.nfe_produto[index]!.total)}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        ),
      );
    }
  );
}