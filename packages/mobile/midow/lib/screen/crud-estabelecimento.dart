import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:midow/bloc/estabelecimento.dart';
import 'package:midow/model/estabelecimento.dart';

class EstabelecimentoCrudPage extends ModalRoute<void> {
  final Estabelecimento estabelecimento;
  EstabelecimentoCrudPage({this.estabelecimento});

  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  final bloc = BlocProvider.getBloc<EstabelecimentoBloc>();

  final nomeController = TextEditingController();

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Material(
        type: MaterialType.transparency,
        // make sure that the overlay content is not cut off
        child: SafeArea(
            bottom: false,
            top: true,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 70,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    child: Container(
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(30.0),
                                topRight: const Radius.circular(30.0))),
                        child: Container(
                            margin: EdgeInsets.only(top: 30),
                            child: Scaffold(
                                backgroundColor: Colors.transparent,
                                appBar: AppBar(
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  iconTheme: IconThemeData(
                                      color: Theme.of(context).primaryColor),
                                ),
                                body: Container(
                                  padding: EdgeInsets.all(20),
                                  child: Consumer<EstabelecimentoBloc>(builder:
                                      (BuildContext context,
                                          EstabelecimentoBloc bloc) {
                                    if (bloc.loading) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    } else {
                                      return Stack(
                                        children: <Widget>[
                                          Positioned(
                                            top: 0,
                                            left: 0,
                                            right: 0,
                                            bottom: 50,
                                            child: Column(
                                              children: <Widget>[
                                                TextField(
                                                    controller: nomeController,
                                                    decoration: new InputDecoration(
                                                        hasFloatingPlaceholder:
                                                            true,
                                                        filled: true,
                                                        labelText:
                                                            'Nome do estabelecimento'))
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                              left: 0,
                                              right: 0,
                                              bottom: 15,
                                              child: SizedBox(
                                                  height: 60,
                                                  child: OutlineButton(
                                                    highlightedBorderColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    focusColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                    textColor: Theme.of(context)
                                                        .primaryColor,
                                                    onPressed: () {
                                                      estabelecimento.nome =
                                                          nomeController.text;
                                                      bloc.store(
                                                          estabelecimento);
                                                    },
                                                    child: Text('Salvar'),
                                                  )))
                                        ],
                                      );
                                    }
                                  }),
                                )))),
                  ),
                )
              ],
            )));
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return new SlideTransition(
      position: new Tween<Offset>(
        begin: const Offset(0.0, 1.0),
        end: Offset.zero,
      ).animate(
          new CurvedAnimation(parent: animation, curve: Curves.easeInBack)),
      child: child,
    );
  }
}