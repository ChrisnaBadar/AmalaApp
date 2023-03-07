import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:amala/constants/core_data.dart';

class AdMobService {
  static String get bannerAdUnitId {
    if (CoreData.isTestMode) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else {
      return 'ca-app-pub-6705737681125281/3673076537';
    }
  }

  static String get appOpenAdUnit {
    if (CoreData.isTestMode) {
      return 'ca-app-pub-3940256099942544/3419835294';
    } else {
      return 'ca-app-pub-6705737681125281/9992176528';
    }
  }

  static String get interstitialAdUnitId {
    if (CoreData.isTestMode) {
      return 'ca-app-pub-3940256099942544/1033173712';
    } else {
      return 'ca-app-pub-6705737681125281/5784234556';
    }
  }

  static String get nativeAdUnitId {
    if (CoreData.isTestMode) {
      return 'ca-app-pub-3940256099942544/2247696110';
    } else {
      return 'ca-app-pub-6705737681125281/9577243556';
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
      onAdLoaded: (ad) => print('adLoaded'), //TODO: user snackbar
      onAdFailedToLoad: (ad, error) {
        ad.dispose();
        print('failed to load: $error');
      },
      onAdOpened: (ad) => print('ad opened'), //TODO: user snackbar
      onAdClosed: (ad) => print('ad closed')); //TODO: user snackbar
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
