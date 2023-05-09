import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:amala/constants/core_data.dart';

class AdMobService {
  static String get bannerAdUnitId {
    if (CoreData.isTestMode) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else {
      return 'ca-app-pub-6705737681125281/1977614190';
    }
  }

  static String get appOpenAdUnit {
    if (CoreData.isTestMode) {
      return 'ca-app-pub-3940256099942544/3419835294';
    } else {
      return 'ca-app-pub-6705737681125281/9992176528';
    }
  }

  /// Maximum duration allowed between loading and showing the ad.
  final Duration maxCacheDuration = const Duration(hours: 4);

  /// Keep track of load time so we don't show an expired ad.
  DateTime? _appOpenLoadTime;

  //appOpenAdUnit
  AppOpenAd? _appOpenAd;
  bool _isShowingAd = false;

  /// Load an AppOpenAd.
  void loadAd() {
    // We will implement this below.
    AppOpenAd.load(
      adUnitId: AdMobService.appOpenAdUnit,
      orientation: AppOpenAd.orientationPortrait,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenLoadTime = DateTime.now();
          _appOpenAd = ad;
        },
        onAdFailedToLoad: (error) {
          // Handle the error.
        },
      ),
    );
  }

  /// Whether an ad is available to be shown.
  bool get isAdAvailable {
    return _appOpenAd != null;
  }

  void showAdIfAvailable() {
    if (!isAdAvailable) {
      loadAd();
      return;
    }
    if (_isShowingAd) {
      return;
    }
    if (DateTime.now().subtract(maxCacheDuration).isAfter(_appOpenLoadTime!)) {
      _appOpenAd!.dispose();
      _appOpenAd = null;
      loadAd();
      return;
    }
    // Set the fullScreenContentCallback and show the ad.
    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAd = true;
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
      },
      onAdDismissedFullScreenContent: (ad) {
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        loadAd();
      },
    );
  }

  //BANNER Ad
  static final BannerAdListener bannerListener = BannerAdListener(
    //onAdLoaded: (ad) => print('adLoaded'),
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
    },
    //onAdOpened: (ad) => print('ad opened'),
    //onAdClosed: (ad) => print('ad closed')
  );
}

class AppLifecycleReactor {
  final AdMobService? adMobService;

  AppLifecycleReactor({this.adMobService});

  void listenToAppStateChanges() {
    AppStateEventNotifier.startListening();
    AppStateEventNotifier.appStateStream
        .forEach((state) => _onAppStateChanged(state));
  }

  void _onAppStateChanged(AppState appState) {
    // Try to show an app open ad if the app is being resumed and
    // we're not already showing an app open ad.
    if (appState == AppState.foreground) {
      adMobService!.showAdIfAvailable();
    }
  }
}
