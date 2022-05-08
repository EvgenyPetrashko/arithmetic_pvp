import 'dart:developer';
import 'package:arithmetic_pvp/bloc/events/shop_events.dart';
import 'package:arithmetic_pvp/bloc/profile_bloc.dart';
import 'package:arithmetic_pvp/bloc/shop_bloc.dart';
import 'package:arithmetic_pvp/bloc/states/shop_states.dart';
import 'package:arithmetic_pvp/data/models/skin.dart';
import 'package:arithmetic_pvp/presentation/skins/skin_card.dart';
import 'package:arithmetic_pvp/presentation/skins/skin_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SkinsPage extends StatefulWidget {
  const SkinsPage({Key? key}) : super(key: key);

  @override
  State<SkinsPage> createState() => _SkinsPageState();
}

class _SkinsPageState extends State<SkinsPage> {
  late ShopBloc _shopBloc;
  List<Skin> _skins = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _shopBloc = ShopBloc(BlocProvider.of<ProfileBloc>(context));
    _shopBloc.add(SkinsEventLoading());
  }

  _handleState(BuildContext context, ShopState state) {
    log(state.toString());
    if (state is ShopSkinsState) {
      if (state is ShopSkinsStateLoaded) {
        setState(
          () {
            _skins = state.skins;
          },
        );
      } else if (state is ShopSkinsStateError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.error),
          ),
        );
      }
    } else if (state is ShopBuySkinState) {
      bool _setLoading = false;
      if (state is ShopBuyStateLoaded) {
        setState(
          () {
            for (var skin in _skins) {
              if (skin.id == state.skin.id) {
                skin.isOwner = true;
                break;
              }
            }
          },
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)?.success??"Success"),
          ),
        );
      } else if (state is ShopBuyStateError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.error),
          ),
        );
      } else {
        _setLoading = true;
      }
      if (!_setLoading) {
        Navigator.pop(context);
      }
      setState(
        () {
          _loading = _setLoading;
        },
      );
    } else if (state is ShopSelectSkinState) {
      bool _setLoading = false;
      if (state is ShopSelectSkinLoaded) {
        setState(
          () {
            if (state.isSuccess) {
              for (var skin in _skins) {
                if (skin.id == state.skin.id) {
                  skin.isSelected = true;
                } else {
                  skin.isSelected = false;
                }
              }
            }
          },
        );
      } else if (state is ShopSelectSkinError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.error),
          ),
        );
      } else {
        _setLoading = true;
      }
      setState(
        () {
          _loading = _setLoading;
        },
      );
    }
  }

  _buyButtonFunction(Skin skin) {
    if (!_loading) {
      setState(() {
        _loading = true;
      });
      _shopBloc.add(SkinsEventBuySkin(skin));
    }
  }

  _showBuyDialog(Skin skin) {
    return showDialog(
      context: context,
      builder: (context) {
        return SkinDialog(
            skin: skin, buyButtonFunction: _buyButtonFunction);
      },
    );
  }

  _selectSkin(Skin skin) {
    _shopBloc.add(
      SkinsEventSelectSkin(skin),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener(
        bloc: _shopBloc,
        listener: (context, ShopState state) => _handleState(context, state),
        child: LoadingOverlay(
          isLoading: _loading,
          color: Colors.black45,
          progressIndicator: JumpingText(
            '···',
            style: const TextStyle(fontSize: 60),
          ),
          child: (_skins.isNotEmpty)
              ? ListView.builder(
                  itemCount: _skins.length,
                  itemBuilder: (context, index) => ShopCard(
                    skin: _skins[index],
                    onBuyFunction: _showBuyDialog,
                    onSelectFunction: _selectSkin,
                  ),
                )
              : Center(
                  child: JumpingText(
                    '···',
                    style: const TextStyle(fontSize: 60),
                  ),
                ),
        ),
      ),
    );
  }
}
