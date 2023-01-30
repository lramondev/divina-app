import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/recibo_model.dart';

ListView listReciboProdutoWidget (Recibo? recibo) {
  return ListView.builder(
    padding: const EdgeInsets.only(top: 0),
    shrinkWrap: true,
    itemCount: recibo!.recibo_produto.length,
    itemBuilder: (BuildContext context, int index) {
      return ListTile(
        dense: true,
        title: Text('${recibo.recibo_produto[index]!.item} - ${recibo.recibo_produto[index]!.descricao} (${recibo.recibo_produto[index]!.codigo})'),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${(NumberFormat('#,###.00', 'pt_BR').format(recibo.recibo_produto[index]!.quantidade))} X R\$ ${(NumberFormat('#,###.00', 'pt_BR')).format(recibo.recibo_produto[index]!.valor_unitario)}'),
            Text('R\$ ${(NumberFormat('#,###.00', 'pt_BR')).format(recibo.recibo_produto[index]!.total)}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        ),
      );
    }
  );
}