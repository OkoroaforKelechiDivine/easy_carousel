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
  underHeadline,
  aboveCaption,
  underCaption,
}

enum ImageSourceType {
  asset,
  network,
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

  final Color activeIndicatorBorderColor;
  final double activeIndicatorBorderWidth;
  final Color inactiveIndicatorBorderColor;
  final double inactiveIndicatorBorderWidth;

  final Color buttonColor;
  final Color buttonTextColor;
  final double imageWidth;
  final double imageHeight;
  final double headlineFontSize;
  final double captionFontSize;
  final Color headlineFontColor;
  final Color captionFontColor;
  final String? headlineFontFamily;
  final String? captionFontFamily;
  final ImageSourceType imageSourceType;

  final VoidCallback? onCarouselComplete;

  final TextStyle? headlineTextStyle;
  final TextStyle? captionTextStyle;
  final TextStyle? navigationButtonTextStyle;

  final PageController? pageController;

  const EasyCarousel({
    super.key,
    this.imageUrls = const <String>[],
    this.headlineTexts = const <String>[],
    this.captionTexts = const <String>[],
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
    this.pageController,
    this.buttonColor = Colors.black,
    this.buttonTextColor = Colors.white,
    this.imageWidth = 0.8,
    this.imageHeight = 250.0,
    this.headlineFontSize = 20.0,
    this.captionFontSize = 14.0,
    this.headlineFontColor = Colors.black,
    this.captionFontColor = Colors.grey,
    this.headlineFontFamily,
    this.captionFontFamily,
    this.imageSourceType = ImageSourceType.network,
    this.activeIndicatorBorderColor = Colors.transparent,
    this.activeIndicatorBorderWidth = 0.0,
    this.inactiveIndicatorBorderColor = Colors.transparent,
    this.inactiveIndicatorBorderWidth = 0.0,
  });

  @override
  State<EasyCarousel> createState() => _EasyCarouselState();
}

class _EasyCarouselState extends State<EasyCarousel> {
  late final PageController _internalController;
  Timer? _autoSlideTimer;
  int _currentPageIndex = 0;
  bool get _usesInternalController => widget.pageController == null;

  PageController get _controller =>
      widget.pageController ?? _internalController;

  bool _isInlinePosition(CarouselPosition position) {
    return position == CarouselPosition.bottomCenter ||
           position == CarouselPosition.underHeadline ||
           position == CarouselPosition.aboveCaption ||
           position == CarouselPosition.underCaption;
  }

  @override
  void initState() {
    super.initState();
    _internalController = PageController();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _autoSlideTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (_controller.hasClients) {
        if (_currentPageIndex == widget.imageUrls.length - 1) {
          _controller.jumpToPage(0);
        } else {
          _controller.nextPage(
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
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    if (_usesInternalController) {
      _internalController.dispose();
    }
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
      case CarouselPosition.underHeadline:
        return Alignment.center;
      case CarouselPosition.aboveCaption:
        return Alignment.center;
      case CarouselPosition.underCaption:
        return Alignment.center;
    }
  }

  Widget _buildImage(String imagePath) {
    switch (widget.imageSourceType) {
      case ImageSourceType.asset:
        return Image.asset(
          imagePath,
          fit: BoxFit.contain,
          width: MediaQuery.of(context).size.width * widget.imageWidth,
          height: widget.imageHeight,
        );
      case ImageSourceType.network:
        return Image.network(
          imagePath,
          fit: BoxFit.contain,
          width: MediaQuery.of(context).size.width * widget.imageWidth,
          height: widget.imageHeight,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Center(
          child: PageView.builder(
            controller: _controller,
            onPageChanged: _onPageChanged,
            itemCount: widget.imageUrls.length,
            itemBuilder: (context, index) {
              String headline = (index < widget.headlineTexts.length) ? widget.headlineTexts[index] : '';
              String caption = (index < widget.captionTexts.length) ? widget.captionTexts[index] : '';
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    SizedBox(
                      height: widget.imageHeight,
                      width: screenWidth * widget.imageWidth,
                      child: _buildImage(widget.imageUrls[index]),
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
                          activeBorderColor: widget.activeIndicatorBorderColor,
                          activeBorderWidth: widget.activeIndicatorBorderWidth,
                          inactiveBorderColor: widget.inactiveIndicatorBorderColor,
                          inactiveBorderWidth: widget.inactiveIndicatorBorderWidth,
                        ),
                      ),
                    if (headline.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: CarouselText(
                          text: headline,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.bold,
                          fontSize: widget.headlineFontSize,
                          color: widget.headlineFontColor,
                          fontFamily: widget.headlineFontFamily ?? widget.headlineTextStyle?.fontFamily,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    if (widget.isIndicatorVisible &&
                        widget.indicatorPosition == CarouselPosition.underHeadline)
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
                          activeBorderColor: widget.activeIndicatorBorderColor,
                          activeBorderWidth: widget.activeIndicatorBorderWidth,
                          inactiveBorderColor: widget.inactiveIndicatorBorderColor,
                          inactiveBorderWidth: widget.inactiveIndicatorBorderWidth,
                        ),
                      ),
                    if (headline.isNotEmpty) const SizedBox(height: 10),
                    if (widget.isIndicatorVisible &&
                        widget.indicatorPosition == CarouselPosition.aboveCaption)
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
                          activeBorderColor: widget.activeIndicatorBorderColor,
                          activeBorderWidth: widget.activeIndicatorBorderWidth,
                          inactiveBorderColor: widget.inactiveIndicatorBorderColor,
                          inactiveBorderWidth: widget.inactiveIndicatorBorderWidth,
                        ),
                      ),
                    if (caption.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: CarouselText(
                          text: caption,
                          textAlign: TextAlign.center,
                          fontSize: widget.captionFontSize,
                          color: widget.captionFontColor,
                          fontFamily: widget.captionFontFamily ?? widget.captionTextStyle?.fontFamily,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    if (widget.isIndicatorVisible &&
                        widget.indicatorPosition == CarouselPosition.underCaption)
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
                          activeBorderColor: widget.activeIndicatorBorderColor,
                          activeBorderWidth: widget.activeIndicatorBorderWidth,
                          inactiveBorderColor: widget.inactiveIndicatorBorderColor,
                          inactiveBorderWidth: widget.inactiveIndicatorBorderWidth,
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
        if (widget.isIndicatorVisible && !_isInlinePosition(widget.indicatorPosition))
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
                activeBorderColor: widget.activeIndicatorBorderColor,
                activeBorderWidth: widget.activeIndicatorBorderWidth,
                inactiveBorderColor: widget.inactiveIndicatorBorderColor,
                inactiveBorderWidth: widget.inactiveIndicatorBorderWidth,
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
                backgroundColor: widget.buttonColor,
                textColor: widget.buttonTextColor,
              ),
            ),
          ),
      ],
    );
  }
}