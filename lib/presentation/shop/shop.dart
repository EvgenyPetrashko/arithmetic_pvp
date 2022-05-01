import 'dart:developer';

import 'package:arithmetic_pvp/bloc/events/shop_events.dart';
import 'package:arithmetic_pvp/bloc/shop_bloc.dart';
import 'package:arithmetic_pvp/bloc/states/shop_states.dart';
import 'package:arithmetic_pvp/presentation/shop/shop_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final _shopBloc = ShopBloc();

  @override
  void initState() {
    super.initState();
    _shopBloc.add(ShopUserEventLoading());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<ShopBloc, ShopState>(
          bloc: _shopBloc,
          listener: (context, state) => {},
          builder: (context, state) {
            log(state.toString());
            if (state is ShopStateSkinsLoaded) {
              return ListView.builder(
                itemCount: state.skins.length,
                itemBuilder: (context, index) => ShopCard(
                  name: state.skins[index].name,
                  description: state.skins[index].description,
                  imageUrl:
                  state.skins[index].assetUrl,
                  isOwner: state.skins[index].isOwner,
                  cost: state.skins[index].cost,
                ),
              );
            } else if (state is ShopStateSkinsLoading){
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else {
              return const Center(
                child: Text("Something went wrong. Please try again later"),
              );
            }
          }),
    );
  }
}
