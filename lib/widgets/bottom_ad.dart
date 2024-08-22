import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:snowbill/widgets/hide_if_paid.dart';

class BottomAd extends StatefulWidget {
  const BottomAd({Key? key}) : super(key: key);

  @override
  State<BottomAd> createState() => _BottomAdState();
}

class _BottomAdState extends State<BottomAd> {
  final AdManagerBannerAdListener listener = AdManagerBannerAdListener();
  final AdSize size = const AdSize(width: 320, height: 50);

  late AdManagerBannerAd adBanner;

  @override
  void initState() {
    super.initState();

    if (defaultTargetPlatform == TargetPlatform.android && kReleaseMode) {
      // create the android banner
      adBanner = AdManagerBannerAd(
        adUnitId: 'ca-app-pub-8977694002065112/1913556740',
        sizes: [AdSize.banner],
        request: const AdManagerAdRequest(),
        listener: listener,
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS && kReleaseMode) {
      // create the ios banner
      adBanner = AdManagerBannerAd(
        adUnitId: 'ca-app-pub-8977694002065112/2792088792',
        sizes: [AdSize.banner],
        request: const AdManagerAdRequest(),
        listener: listener,
      );
    } else {
      // set up a test device id
      MobileAds.instance.updateRequestConfiguration(
        RequestConfiguration(
          testDeviceIds: ['55E4D85837ED932E4F7D1701C583F809'],
        ),
      );
      // create the test banner
      adBanner = AdManagerBannerAd(
        adUnitId: '/6499/example/banner',
        sizes: [AdSize.banner],
        request: const AdManagerAdRequest(),
        listener: listener,
      );
    }

    // load the banner
    adBanner.load();
  }

  @override
  Widget build(BuildContext context) {
    return HideIfPaid(
      childBuilder: () => Container(
        alignment: Alignment.center,
        width: size.width.toDouble(),
        height: size.height.toDouble(),
        child: AdWidget(ad: adBanner),
      ),
    );
  }
}
