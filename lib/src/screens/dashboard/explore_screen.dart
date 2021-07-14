import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:places/src/core/base_widget.dart';
import 'package:places/src/core/constants/route_paths.dart';
import 'package:places/src/model/dashboard/place_model.dart';
import 'package:places/src/utils/ad_helper.dart';
import 'package:places/src/viewmodels/dashboard/explore_view_model.dart';
import 'package:places/src/widgets/error_view.dart';
import 'package:places/src/widgets/loading_indicator.dart';
import 'package:places/src/widgets/place_item.dart';
import 'package:provider/provider.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen();

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ExploreViewModel>(
        model: ExploreViewModel(service: Provider.of(context)),
        onModelReady: (model) async {
          // initializeAd(model);
          await _initGoogleMobileAds();
          await model.initialize();
        },
        builder: (context, ExploreViewModel model, Widget? child) {
          return Container(
            padding: EdgeInsets.all(16),
            child: _buildBody(context, model),
          );
        });
  }

  Widget _buildBody(BuildContext context, ExploreViewModel model) {
    if (model.busy) {
      return LoadingIndicator();
    }
    if (model.places.status == false) {
      return ErrorView(
          messages: model.places.message!,
          callback: () async => await model.initialize());
    }
    return ListView.builder(
      itemCount: model.places.data.length + (model.places.data.length)~/2  ,
      padding: EdgeInsets.only(bottom: 12),
      itemBuilder: (BuildContext context, int index) {

        if(index %3 ==0 && index != 0){
          return _buildAdView(model);
        }

        final PlaceModel place = model.places.data[index - (index~/2)] as PlaceModel;
        return InkWell(
          onTap: () {
            Navigator.of(context)
                .pushNamed(RoutePaths.VIEW_DETAIL, arguments: place);
          },
          child: PlaceItem(
            place: place,
            location: model.currentLocation,
          ),
        );
      },
    );
  }

  Future<InitializationStatus> _initGoogleMobileAds() async {
    return MobileAds.instance.initialize();
  }

  Widget _buildAdView(ExploreViewModel model) {
   final _ad = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          // model.setAdLoaded(true);
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          // ad.dispose();

          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );

     // _ad.load();

    return FutureBuilder(
        future: _ad.load(),
        builder: (context, snapshot) {
          return Container(
            width: _ad.size.width.toDouble(),
            height: _ad.size.height.toDouble(),
            child: AdWidget(ad: _ad),
          );
        });
  }
}
