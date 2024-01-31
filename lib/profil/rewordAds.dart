import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

class AdmobHelper {

  RewardedAd? _rewardedAd;

  static initialization() {
    if (MobileAds.instance == null) {
      MobileAds.instance.initialize();
    }
  }
  void createRewardAd() {
    RewardedAd.load(
        adUnitId: 'ca-app-pub-3940256099942544/5224354917',
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            this._rewardedAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
          },
        ));
  }

  void showRewardAd() {
    _rewardedAd?.show(
        onUserEarnedReward: ( ad,  rewardItem) {
          print("Adds Reward is ${rewardItem.amount}");

        });

    _rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('$ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
      },
      onAdImpression: (RewardedAd ad) => print('$ad impression occurred.'),
    );
  }




  // banner ads

  BannerAd bAd = new BannerAd(size: AdSize.banner, adUnitId: 'ca-app-pub-3940256099942544/6300978111', listener: BannerAdListener(
      onAdClosed: (Ad ad){
        print("Ad Closed");
      },
      onAdFailedToLoad: (Ad ad,LoadAdError error){
        ad.dispose();
      },
      onAdLoaded: (Ad ad){
        print('Ad Loaded');
      },
      onAdOpened: (Ad ad){
        print('Ad opened');
      }
  ), request: AdRequest());

}