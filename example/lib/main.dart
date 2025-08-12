import 'package:flutter/material.dart';
import 'package:easy_carousel/easy_carousel.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: const Text('EasyCarousel Demo'),
          backgroundColor: Colors.blueAccent,
        ),
        body: EasyCarousel(
          imageUrls: [
            'assets/images/image1.jpg',
            'assets/images/image2.jpg',
            'https://picsum.photos/id/1013/600/400',
          ],
          headlineTexts: ['Welcome', 'Explore', 'Enjoy'],
          captionTexts: [
            'Discover the power of EasyCarousel!',
            'Swipe to explore amazing features',
            'Build stunning carousels with ease!',
          ],
          isNavigationButtonVisible: true,
          continueButtonText: 'Next',
          completeButtonText: 'Get Started',
          navigationButtonIcon: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
          navigationButtonPosition: CarouselPosition.bottomRight,
          isIndicatorVisible: true,
          indicatorPosition: CarouselPosition.bottomLeft,
          onCarouselComplete: () {
            debugPrint('You finished the carousel!');
          },
          buttonColor: Colors.blueAccent,
          buttonTextColor: Colors.white,
          imageWidth: 0.9,
          imageHeight: 300.0,
          headlineFontSize: 24.0,
          captionFontSize: 16.0,
          headlineFontColor: Colors.black87,
          captionFontColor: Colors.grey[600]!,
          imageSourceType: ImageSourceType.asset,
          activeIndicatorDotColor: Colors.blueAccent,
          inactiveIndicatorDotColor: Colors.grey[300]!,
          activeIndicatorDotWidth: 24.0,
          activeIndicatorDotHeight: 6.0,
          inactiveIndicatorDotWidth: 12.0,
          inactiveIndicatorDotHeight: 6.0,
          indicatorDotSpacing: 10.0,
          spaceBetweenImageAndText: 40.0,
          headlineTextStyle: const TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
          ),
          captionTextStyle: const TextStyle(
            fontFamily: 'Roboto',
            fontStyle: FontStyle.italic,
          ),
          navigationButtonTextStyle: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}