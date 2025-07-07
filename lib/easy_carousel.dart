import 'dart:async';
import 'package:flutter/material.dart';
import 'carousel_button.dart';
import 'carousel_indicator.dart';
import 'carousel_text.dart';

enum CarouselPosition {
  topLeft,
  topCenter,
  topRight,
  bottomLeft,
  bottomCenter,
  bottomRight,
  centerLeft,
  centerRight,
}

class EasyCarousel extends StatefulWidget {
  final List<String> imageUrls;
  final List<String> headlineTexts;
  final List<String> captionTexts;

  final bool isNavigationButtonVisible;
  final bool isIndicatorVisible;

  final String continueButtonText;
  final String completeButtonText;

  final Widget? navigationButtonIcon;

  final CarouselPosition navigationButtonPosition;
  final CarouselPosition indicatorPosition;

  final Color activeIndicatorDotColor;
  final Color inactiveIndicatorDotColor;

  final double inactiveIndicatorDotWidth;
  final double inactiveIndicatorDotHeight;
  final double indicatorDotSpacing;
  final double spaceBetweenImageAndText;
  final double activeIndicatorDotWidth;
  final double activeIndicatorDotHeight;

  final VoidCallback? onCarouselComplete;

  final TextStyle? headlineTextStyle;
  final TextStyle? captionTextStyle;
  final TextStyle? navigationButtonTextStyle;

  const EasyCarousel({
    super.key,
    required this.imageUrls,
    required this.headlineTexts,
    required this.captionTexts,
    this.isNavigationButtonVisible = true,
    this.continueButtonText = 'Continue',
    this.completeButtonText = 'Complete',
    this.navigationButtonIcon,
    this.navigationButtonPosition = CarouselPosition.bottomRight,
    this.isIndicatorVisible = true,
    this.indicatorPosition = CarouselPosition.bottomCenter,
    this.onCarouselComplete,
    this.headlineTextStyle,
    this.activeIndicatorDotColor = Colors.black,
    this.activeIndicatorDotWidth = 20,
    this.activeIndicatorDotHeight = 5,
    this.inactiveIndicatorDotColor = Colors.grey,
    this.inactiveIndicatorDotWidth = 10,
    this.inactiveIndicatorDotHeight = 5,
    this.indicatorDotSpacing = 8,
    this.captionTextStyle,
    this.navigationButtonTextStyle,
    this.spaceBetweenImageAndText = 16.0,
  }) : assert(
          imageUrls.length == headlineTexts.length &&
              headlineTexts.length == captionTexts.length,
          "imageUrls, headlineTexts, and captionTexts must all have the same length",
        );

  @override
  State<EasyCarousel> createState() => _EasyCarouselState();
}

class _EasyCarouselState extends State<EasyCarousel> {
  late final PageController _pageController;
  late Timer _autoSlideTimer;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _autoSlideTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (_pageController.hasClients) {
        if (_currentPageIndex == widget.imageUrls.length - 1) {
          _pageController.jumpToPage(0);
        } else {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
          );
        }
      }
    });
  }

  void _onPageChanged(int newIndex) {
    setState(() {
      _currentPageIndex = newIndex;
    });
  }

  void _onNavigationButtonPressed() {
    if (_currentPageIndex == widget.imageUrls.length - 1) {
      widget.onCarouselComplete?.call();
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _autoSlideTimer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Alignment _alignmentFromPosition(CarouselPosition position) {
    switch (position) {
      case CarouselPosition.topLeft:
        return Alignment.topLeft;
      case CarouselPosition.topCenter:
        return Alignment.topCenter;
      case CarouselPosition.topRight:
        return Alignment.topRight;
      case CarouselPosition.bottomLeft:
        return Alignment.bottomLeft;
      case CarouselPosition.bottomCenter:
        return Alignment.bottomCenter;
      case CarouselPosition.bottomRight:
        return Alignment.bottomRight;
      case CarouselPosition.centerLeft:
        return Alignment.centerLeft;
      case CarouselPosition.centerRight:
        return Alignment.centerRight;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Center(
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: widget.imageUrls.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 250,
                    width: screenWidth * 0.8,
                    child: Image.network(
                      widget.imageUrls[index],
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: widget.spaceBetweenImageAndText),

                  if (widget.isIndicatorVisible &&
                      widget.indicatorPosition == CarouselPosition.bottomCenter)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: CarouselIndicator(
                        itemCount: widget.imageUrls.length,
                        currentIndex: _currentPageIndex,
                        activeColor: widget.activeIndicatorDotColor,
                        activeWidth: widget.activeIndicatorDotWidth,
                        activeHeight: widget.activeIndicatorDotHeight,
                        inactiveColor: widget.inactiveIndicatorDotColor,
                        inactiveWidth: widget.inactiveIndicatorDotWidth,
                        inactiveHeight: widget.inactiveIndicatorDotHeight,
                        spacing: widget.indicatorDotSpacing,
                      ),
                    ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: CarouselText(
                      text: widget.headlineTexts[index],
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: widget.headlineTextStyle?.color,
                      fontFamily: widget.headlineTextStyle?.fontFamily,
                      overflow: TextOverflow.visible,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: CarouselText(
                      text: widget.captionTexts[index],
                      textAlign: TextAlign.center,
                      fontSize: 14,
                      color: widget.captionTextStyle?.color ?? Colors.grey,
                      fontFamily: widget.captionTextStyle?.fontFamily,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        if (widget.isIndicatorVisible &&
            widget.indicatorPosition != CarouselPosition.bottomCenter)
          Align(
            alignment: _alignmentFromPosition(widget.indicatorPosition),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: CarouselIndicator(
                itemCount: widget.imageUrls.length,
                currentIndex: _currentPageIndex,
                activeColor: widget.activeIndicatorDotColor,
                activeWidth: widget.activeIndicatorDotWidth,
                activeHeight: widget.activeIndicatorDotHeight,
                inactiveColor: widget.inactiveIndicatorDotColor,
                inactiveWidth: widget.inactiveIndicatorDotWidth,
                inactiveHeight: widget.inactiveIndicatorDotHeight,
                spacing: widget.indicatorDotSpacing,
              ),
            ),
          ),

        if (widget.isNavigationButtonVisible)
          Align(
            alignment: _alignmentFromPosition(widget.navigationButtonPosition),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: CarouselButton(
                text: _currentPageIndex == widget.imageUrls.length - 1
                    ? widget.completeButtonText
                    : widget.continueButtonText,
                icon: widget.navigationButtonIcon,
                onPressed: _onNavigationButtonPressed,
                textStyle: widget.navigationButtonTextStyle,
              ),
            ),
          ),
      ],
    );
  }
}
