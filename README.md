# 📸 EasyCarousel

[![pub.dev](https://img.shields.io/pub/v/easy_carousel?color=blue)](https://pub.dev/packages/easy_carousel)
[![GitHub stars](https://img.shields.io/github/stars/your-username/easy_carousel?style=social)](https://github.com/OkoroaforKelechiDivine/easy_carousel)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)

**EasyCarousel** is a highly customizable, developer-friendly Flutter widget that makes it easy to build carousels, onboarding flows, and image sliders with styled headlines, captions, indicators, and navigation buttons.

---

## ✨ Features
 Add images, headlines, and captions easily  
 Positionable indicators and buttons  
 Custom indicator colors, sizes, and spacing  
 Auto slide with timer  
 Lightweight and clean codebase  
 Developer-friendly parameter names  
 Perfect for onboarding screens, promos, and tutorials

---

## 📦 Installation

Add it to your `pubspec.yaml`:

```yaml
dependencies:
  easy_carousel: ^0.2.0

## Run

```console
flutter pub get

```


```dart
import 'package:flutter/material.dart';
import 'package:easy_carousel/easy_carousel.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
            continueButtonText: 'Next',
            completeButtonText: 'Get Started',
            navigationButtonIcon: Icon(Icons.arrow_forward, color: Colors.white),
            navigationButtonPosition: CarouselPosition.bottomRight,
            isIndicatorVisible: true,
            indicatorPosition: CarouselPosition.bottomCenter,
            spaceBetweenImageAndText: 32,
            pageController: pageController,

            // Customize indicators
            activeIndicatorDotColor: Colors.blue,
            inactiveIndicatorDotColor: Colors.grey.shade400,
            activeIndicatorDotWidth: 24,
            activeIndicatorDotHeight: 6,
            inactiveIndicatorDotWidth: 12,
            inactiveIndicatorDotHeight: 6,
            indicatorDotSpacing: 10,

            // Customize button text
            navigationButtonTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),

            // Callback
            onCarouselComplete: () {
              debugPrint('Carousel completed!');
            },
          ),
        ),
      ),
    );
  }
}
```

## 🔧 Constructor Parameters

| Parameter                     | Type              | Description                                                                 |
|------------------------------|-------------------|-----------------------------------------------------------------------------|
| `imageUrls`                  | `List<String>`    | List of image URLs to display.                                              |
| `headlineTexts`              | `List<String>`    | Headline text for each carousel page.                                       |
| `captionTexts`               | `List<String>`    | Caption text for each carousel page.                                        |
| `isNavigationButtonVisible`  | `bool`            | Whether the navigation button is shown (default: `true`).                   |
| `continueButtonText`         | `String`          | Text displayed on the "next" button (default: `'Continue'`).                |
| `completeButtonText`         | `String`          | Text displayed on the "finish" button (default: `'Complete'`).             |
| `navigationButtonIcon`       | `Widget?`         | Optional icon widget beside the button text.                                |
| `navigationButtonTextStyle`  | `TextStyle?`      | Style to apply to the button text.                                          |
| `navigationButtonPosition`   | `CarouselPosition`| Position of the navigation button (default: `CarouselPosition.bottomRight`).|
| `isIndicatorVisible`         | `bool`            | Whether the indicator dots are shown (default: `true`).                     |
| `indicatorPosition`          | `CarouselPosition`| Position of the indicator dots.                                             |
| `activeIndicatorDotColor`    | `Color`           | Color of the currently active indicator dot.                                |
| `activeIndicatorDotWidth`    | `double`          | Width of the active indicator dot (default: `20`).                          |
| `activeIndicatorDotHeight`   | `double`          | Height of the active indicator dot (default: `5`).                          |
| `inactiveIndicatorDotColor`  | `Color`           | Color of the inactive indicator dots.                                       |
| `inactiveIndicatorDotWidth`  | `double`          | Width of inactive indicator dots (default: `10`).                           |
| `inactiveIndicatorDotHeight` | `double`          | Height of inactive indicator dots (default: `5`).                           |
| `indicatorDotSpacing`        | `double`          | Horizontal space between each indicator dot (default: `8`).                 |
| `onCarouselComplete`         | `VoidCallback?`   | Callback triggered when the final button is pressed.                        |
| `headlineTextStyle`          | `TextStyle?`      | Optional style to override the headline text.                               |
| `captionTextStyle`           | `TextStyle?`      | Optional style to override the caption text.         
                       |

## 🤝 Contributing

1. Fork the repo  
2. Create your branch:  
   ```bash
   git checkout -b feature/amazing-feature

3. Commit your changes:
    ``` bash
    git commit -am 'Add amazing feature'
4. Push to the branch:
    ``` bash
    git push origin feature/amazing-feature
5. Create a pull request ✅


## Built for Developers, by Developers
EasyCarousel isn’t just a widget it’s your new Flutter shortcut. Write less, ship more.

