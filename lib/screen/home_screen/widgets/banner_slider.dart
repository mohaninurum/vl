import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../model/banner_slider.dart';

class AdvancedAutoBannerSlider extends StatefulWidget {
  @override
  _AdvancedAutoBannerSliderState createState() => _AdvancedAutoBannerSliderState();
}

class _AdvancedAutoBannerSliderState extends State<AdvancedAutoBannerSlider> {
  PageController _pageController = PageController();
  Timer? _timer;
  int _currentPage = 0;
  bool _isPaused = false;

  final List<BannerData> banners = [BannerData(image: 'https://fastly.picsum.photos/id/20/3670/2462.jpg?hmac=CmQ0ln-k5ZqkdtLvVO23LjVAEabZQx2wOaT4pyeG10I', title: 'Learn Today', subtitle: 'Up to 50% off on all items'), BannerData(image: 'https://fastly.picsum.photos/id/24/4855/1803.jpg?hmac=ICVhP1pUXDLXaTkgwDJinSUS59UWalMxf4SOIWb9Ui4', title: 'Subscription', subtitle: 'Discover our latest products'), BannerData(image: 'https://fastly.picsum.photos/id/25/5000/3333.jpg?hmac=yCz9LeSs-i72Ru0YvvpsoECnCTxZjzGde805gWrAHkM', title: 'Free ', subtitle: 'On orders above 100'), BannerData(image: 'https://fastly.picsum.photos/id/56/2880/1920.jpg?hmac=BIplhYgNZ9bsjPXYhD0xx6M1yPgmg4HtthKkCeJp6Fk', title: 'Best Deals', subtitle: 'Limited time offers')];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer?.cancel();
    if (!_isPaused) {
      _timer = Timer.periodic(Duration(seconds: 4), (timer) {
        if (_currentPage < banners.length - 1) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }

        if (_pageController.hasClients) {
          _pageController.animateToPage(_currentPage, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
        }
      });
    }
  }

  void _pauseAutoSlide() {
    setState(() {
      _isPaused = true;
    });
    _timer?.cancel();

    // Resume after 5 seconds
    Timer(Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isPaused = false;
        });
        _startAutoSlide();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          GestureDetector(
            onTap: _pauseAutoSlide,
            child: Container(
              height: 180,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: banners.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4))]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Stack(
                        children: [
                          CachedNetworkImage(fit: BoxFit.cover, width: double.infinity, height: double.infinity, imageUrl: banners[index].image, placeholder: (context, url) => Center(child: CircularProgressIndicator()), errorWidget: (context, url, error) => Icon(Icons.error)),
                          // Image.network(
                          //   banners[index].image,
                          //   fit: BoxFit.cover,
                          //   width: double.infinity,
                          //   height: double.infinity,
                          //   errorBuilder: (context, error, stackTrace) {
                          //     return Container(color: Colors.grey[300], child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.image, size: 40, color: Colors.grey[600]), SizedBox(height: 8), Text(banners[index].title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))])));
                          //   },
                          // ),
                          // Gradient Overlay
                          Container(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black.withOpacity(0.7)]))),
                          // Text Content
                          Positioned(bottom: 20, left: 20, right: 20, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(banners[index].title, style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)), SizedBox(height: 4), Text(banners[index].subtitle, style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 16))])),
                          // Pause Indicator
                          if (_isPaused) Positioned(top: 10, right: 10, child: Container(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.black.withOpacity(0.7), borderRadius: BorderRadius.circular(12)), child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.pause, color: Colors.white, size: 16), SizedBox(width: 4), Text('Paused', style: TextStyle(color: Colors.white, fontSize: 12))]))),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 16),
          // Page Indicators
          Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(banners.length, (index) => AnimatedContainer(duration: Duration(milliseconds: 300), margin: EdgeInsets.symmetric(horizontal: 4), height: 8, width: _currentPage == index ? 24 : 8, decoration: BoxDecoration(color: _currentPage == index ? Colors.blue : Colors.grey[400], borderRadius: BorderRadius.circular(4))))),
          SizedBox(height: 8),
          // Text('Tap banner to pause for 5 seconds', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        ],
      ),
    );
  }
}
