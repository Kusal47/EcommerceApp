import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

//height of display  divided by given container height (802.9/220 = 3.65, 802.9/120 = 6.69)

  static double pageView = screenHeight / 2.51;
  static double pageViewContainer = screenHeight / 3.65;
  static double pageViewTextContainer = screenHeight / 6.69;

// dynamic height padding and margin for making responsive for all devices
  static double heightFor10 = screenHeight / 80.9;
  static double heightFor15 = screenHeight / 53.53;
  static double heightFor20 = screenHeight / 40.15;
  static double heightFor30 = screenHeight / 26.76;
  static double heightFor40 = screenHeight / 20.07;
  static double heightFor45 = screenHeight / 17.84;
  static double heightFor60 = screenHeight / 13.18;
  static double heightFor70 = screenHeight / 11.47;
  static double heightFor80 = screenHeight / 10.03;
  static double heightFor160 = screenHeight / 5.01;
  static double heightFor200 = screenHeight / 4.0145;

// dynamic width padding and margin for  making responsive for all devices
// width = 392.72
  static double widthFor5 = screenWidth / 78.54;
  static double widthFor10 = screenWidth / 39.3;
  static double widthFor15 = screenWidth / 26.18;
  static double widthFor20 = screenWidth / 19.6;
  static double widthFor30 = screenWidth / 13.04;
  static double widthFor110 = screenWidth / 3.56;
  static double widthFor200 = screenWidth / 1.963;

// For FontSize making responsive for all devices
  static double font20 = screenHeight / 40.145;
  static double font24 = screenHeight/33.45;
  static double font26 = screenHeight / 30.88;
  static double font16 = screenHeight / 50.18;

  // For Border Radius making responsive for all devices
  static double radius15 = screenHeight / 53.53;
  static double radius20 = screenHeight / 40.15;
  static double radius30 = screenHeight / 26.76;

  //for icon size
  static double iconSize24 = screenHeight / 33.45;
  static double iconSize16 = screenHeight / 50.18;

  //List view size

  static double ListViewImage = screenWidth / 3.27;
  static double ListViewTextSize = screenWidth / 3.93;

  //FoodDetails
  static double foodDetailImageSize = screenHeight / 2;

//Bottom bar height
  static double bottomHeight = screenHeight / 16.058;
}

