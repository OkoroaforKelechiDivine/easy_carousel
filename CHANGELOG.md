# Changelog

All notable changes to the `easy_carousel` package will be documented in this file.

## 0.0.2

### Added
- **New Customization Parameters for `EasyCarousel`**:
  - `buttonColor`: Allows customization of the navigation button's background color (defaults to `Colors.black`).
  - `buttonTextColor`: Sets the text color for the navigation button (defaults to `Colors.white`).
  - `imageWidth`: Specifies the image width as a fraction of the screen width (defaults to `0.8`).
  - `imageHeight`: Sets the fixed height for carousel images (defaults to `250.0`).
  - `headlineFontSize`: Customizes the font size for headline text (defaults to `20.0`).
  - `captionFontSize`: Customizes the font size for caption text (defaults to `14.0`).
  - `headlineFontColor`: Sets the color for headline text (defaults to `Colors.black`).
  - `captionFontColor`: Sets the color for caption text (defaults to `Colors.grey`).
  - `imageSourceType`: An enum (`ImageSourceType.asset` or `ImageSourceType.network`) to specify whether images are loaded from assets or network URLs (defaults to `ImageSourceType.network`).
- **Text Color Parameter for `CarouselButton`**:
  - Added `textColor` parameter to allow customization of the button's text color, complementing the existing `backgroundColor` parameter (defaults to `Colors.white`).
- **Example Update**:
  - Updated the example in `main.dart` to demonstrate the new customization options, including:
    - Custom button colors (`buttonColor`, `buttonTextColor`).
    - Adjusted image sizes (`imageWidth`, `imageHeight`).
    - Custom font sizes and colors for headlines and captions.
    - Support for asset images with a fallback network image.
    - Enhanced indicator styling and text styles using the 'Roboto' font family.

### Fixed
- Corrected a parameter mismatch in `EasyCarousel` where `color` was incorrectly passed to `CarouselButton`. Updated to use `backgroundColor` to align with `CarouselButton`'s parameter name, resolving the "undefined named parameter" error.

### Changed
- Enhanced the `_buildImage` method in `EasyCarousel` to dynamically handle both asset and network images based on the `imageSourceType` parameter.
- Updated the example to include a modern, visually appealing design with a blue-themed button and indicator, larger image sizes, and custom typography.

## 0.0.1

### Added
- Initial release of the `easy_carousel` package.
- Core `EasyCarousel` widget with support for:
  - Image carousel with `PageView.builder`.
  - Customizable navigation button with `CarouselButton`.
  - Indicator dots with `CarouselIndicator`.
  - Headline and caption text with `CarouselText`.
  - Configurable positions for navigation button and indicators (`CarouselPosition` enum).
  - Auto-slide functionality with a 4-second interval.
  - Customizable text styles, indicator colors, and sizes.
  - Callback for carousel completion (`onCarouselComplete`).
- Basic example demonstrating a simple carousel with network images, navigation button, and indicators.