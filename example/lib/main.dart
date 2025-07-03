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
          leading: BackButton(),
          title: const Text('EasyCarousel'),
        ),
        body: Center(
          child: EasyCarousel(
            imageUrls: [
              'https://picsum.photos/id/1011/600/400',
              'https://picsum.photos/id/1012/600/400',
              'https://picsum.photos/id/1013/600/400',
            ],
            headlineTexts: ['Welcome', 'Explore', 'Enjoy'],
            captionTexts: [
              'Welcome to EasyCarousel package demo',
              'Swipe to explore features',
              'Enjoy building carousels!',
            ],
            isNavigationButtonVisible: true,
            activeIndicatorDotHeight: 5,
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
              print('You finished the carousel!');
            },
          ),
        ),
      ),
    );
  }
}
