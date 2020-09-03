import 'package:flutter/material.dart';
import 'package:motodelivery/pedido/PedidoModel.dart';
import 'package:motodelivery/pedido/pedido_repository.dart';

class PedidoPage extends StatefulWidget {
  final PedidoModel pedido;
  PedidoPage({Key key, @required this.pedido}) : super(key: key);

  @override
  _PedidoPageState createState() => _PedidoPageState();
}

class _PedidoPageState extends State<PedidoPage> {
  final _formKey = GlobalKey<FormState>();

  PedidoRepository repository = PedidoRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: "Endereco"),
                        autocorrect: false,
                        initialValue: widget.pedido.endereco ?? "",
                        validator: (value) {
                          if (value.trim().length < 5) {
                            return 'Nome da rua inválido';
                          }
                          return null;
                        },
                        onSaved: (val) {
                          widget.pedido.endereco = val;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: TextFormField(
                        decoration:
                            InputDecoration(labelText: "Forma Pagamento"),
                        autocorrect: false,
                        initialValue: widget.pedido.formaPagamento ?? "",
                        validator: (value) {
                          if (value.trim().length < 5) {
                            return 'No Forma Pagamento inválido';
                          }
                          return null;
                        },
                        onSaved: (val) {
                          widget.pedido.formaPagamento = val;
                        },
                      ),
                    ),
                    /*Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: TextFormField(
                        decoration:
                            InputDecoration(labelText: "Forma Pagamento"),
                        autocorrect: false,
                        initialValue: widget.pedido.formaPagamento ?? "",
                        validator: (value) {
                          if (value.trim().length < 5) {
                            return 'No Forma Pagamento inválido';
                          }
                          return null;
                        },
                        onSaved: (val) {
                          widget.pedido.formaPagamento = val;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: TextFormField(
                        decoration:
                            InputDecoration(labelText: "Forma Pagamento"),
                        autocorrect: false,
                        initialValue: widget.pedido.formaPagamento ?? "",
                        validator: (value) {
                          if (value.trim().length < 5) {
                            return 'No Forma Pagamento inválido';
                          }
                          return null;
                        },
                        onSaved: (val) {
                          widget.pedido.formaPagamento = val;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: TextFormField(
                        decoration:
                            InputDecoration(labelText: "Forma Pagamento"),
                        autocorrect: false,
                        initialValue: widget.pedido.formaPagamento ?? "",
                        validator: (value) {
                          if (value.trim().length < 5) {
                            return 'No Forma Pagamento inválido';
                          }
                          return null;
                        },
                        onSaved: (val) {
                          widget.pedido.formaPagamento = val;
                        },
                      ),
                    ),*/
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(
                          padding: EdgeInsets.all(8),
                          onPressed: () {
                            //TODO: validar se deseja sair sem salvar
                            Navigator.pop(context);

                            debugPrint("Cancelado Pedido");
                          },
                          child: Text(
                            "Voltar",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        RaisedButton(
                          padding: EdgeInsets.all(8),
                          onPressed: () {
                            final form = _formKey.currentState;
                            if (!form.validate()) return;
                            form.save();

                            /* Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text('Enviando'),
                              duration: Duration(seconds: 2),
                            ));*/

                            repository.enviarPedido(widget.pedido);
                            Navigator.pop(context);

                            debugPrint("enviando Pedido");
                          },
                          child: Text(
                            "Enviar",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ))),
    );
  }
}
