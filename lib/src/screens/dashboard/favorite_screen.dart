import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:places/src/core/base_widget.dart';
import 'package:places/src/model/dashboard/place_model.dart';
import 'package:places/src/viewmodels/dashboard/favorite_view_model.dart';
import 'package:places/src/widgets/error_view.dart';
import 'package:places/src/widgets/favorite_item.dart';
import 'package:places/src/widgets/loading_indicator.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<FavoriteViewModel>(
        model: FavoriteViewModel(service: Provider.of(context)),
        onModelReady: (model) async => await model.initialize(),
        builder: (context, FavoriteViewModel model, Widget? child) {
          return Container(
            padding: EdgeInsets.all(16),
            child: _buildBody(context, model),
          );
        });
  }

  Widget _buildBody(BuildContext context, FavoriteViewModel model) {
    if (model.busy) {
      return LoadingIndicator();
    }
    if (model.favorites.status == false) {
      return ErrorView(
          messages: model.favorites.message!,
          callback: () async => await model.initialize());
    }
    return ListView.builder(
      itemCount: model.favorites.data.length,
      padding: EdgeInsets.only(bottom: 12),
      itemBuilder: (BuildContext context, int index) {
        final PlaceModel place = model.favorites.data[index] as PlaceModel;
        return FavoriteItem(
          place: place,
          location: model.currentLocation,
          onFavoriteRemoved: (item){
            model.removeItemFromFavorite(place);
          },
        );
      },
    );
  }
}
