import 'dart:developer';
import 'package:arithmetic_pvp/bloc/balance_bloc.dart';
import 'package:arithmetic_pvp/bloc/events/shop_events.dart';
import 'package:arithmetic_pvp/bloc/shop_bloc.dart';
import 'package:arithmetic_pvp/bloc/states/shop_states.dart';
import 'package:arithmetic_pvp/data/models/skin.dart';
import 'package:arithmetic_pvp/presentation/skins/skin_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

class SkinsPage extends StatefulWidget {
  const SkinsPage({Key? key}) : super(key: key);

  @override
  State<SkinsPage> createState() => _SkinsPageState();
}

class _SkinsPageState extends State<SkinsPage> {
  late ShopBloc _shopBloc;
  List<Skin> skins = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _shopBloc = ShopBloc(BlocProvider.of<BalanceBloc>(context));
    _shopBloc.add(ShopUserEventSkinsLoading());
  }

  _handleState(BuildContext context, ShopState state) {
    log(state.toString());
    if (state is ShopSkinsState) {
      if (state is ShopSkinsStateLoaded) {
        setState(() {
          skins = state.skins;
        });
      } else if (state is ShopSkinsStateError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.error),
        ));
      }
    } else if (state is ShopBuySkinState) {
      bool _loading = false;
      if (state is ShopBuyStateLoaded) {
        setState(() {
          for (var skin in skins) {
            if (skin.id == state.skin.id) {
              skin.isOwner = true;
              break;
            }
          }
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Success"),
        ));
      } else if (state is ShopBuyStateError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.error),
        ));
      } else {
        _loading = true;
      }
      if (!_loading) {
        _dismissDialog();
      }
    } else if (state is ShopSelectSkinState) {
      bool _loading = false;
      if (state is ShopSelectSkinLoaded) {
        setState(() {
          if (state.isSuccess) {
            for (var skin in skins) {
              if (skin.id == state.skin.id) {
                skin.isSelected = true;
              } else {
                skin.isSelected = false;
              }
            }
          }
        });
      } else if (state is ShopSelectSkinError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.error),
        ));
      } else {
        _loading = true;
      }
      setState(
        () {
          loading = _loading;
        },
      );
    }
  }

  _showBuyDialog(Skin skin) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        bool loading = false;
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Skin purchase'),
              content: Text(
                  "Do you want to buy this skin? It will cost ${skin.cost}"),
              actions: <Widget>[
                TextButton(
                    onPressed: (!loading) ? _dismissDialog : null,
                    child: const Text('Close')),
                TextButton(
                  onPressed: (!loading)
                      ? () {
                          setState(() {
                            loading = true;
                          });
                          _shopBloc.add(ShopUserEventBuySkin(skin));
                        }
                      : null,
                  child: const Text('Ok'),
                )
              ],
            );
          },
        );
      },
    );
  }

  _dismissDialog() {
    Navigator.pop(context);
  }

  _selectSkin(Skin skin) {
    _shopBloc.add(ShopUserEventSelectSkin(skin));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener(
        bloc: _shopBloc,
        listener: (context, ShopState state) => _handleState(context, state),
        child: LoadingOverlay(
          isLoading: loading,
          color: Colors.black45,
          child: (skins.isNotEmpty)
              ? ListView.builder(
                  itemCount: skins.length,
                  itemBuilder: (context, index) => ShopCard(
                    skin: skins[index],
                    onBuyFunction: _showBuyDialog,
                    onSelectFunction: _selectSkin,
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
        ),
      ),
    );
  }
}
