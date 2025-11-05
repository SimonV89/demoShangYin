import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'theme_provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      value: themeProvider.isDarkMode() ? 1.0 : 0.0,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode();
    final screenSize = MediaQuery.of(context).size;

    // Define light and dark styles
    const lightBgColor = Colors.white;
    const darkBgColor = Colors.black;
    final lightGradient = [Colors.redAccent, Colors.orange];
    final darkGradient = [Colors.indigo, Colors.blue];

    // Determine current colors based on theme, not animation
    final currentBgColor = isDarkMode ? darkBgColor : lightBgColor;
    final currentTextColor = isDarkMode ? Colors.white : Colors.black;
    final currentShadowColor = isDarkMode ? Colors.black54 : Colors.grey.withOpacity(0.4);

    return Scaffold(
      backgroundColor: currentBgColor,
      body: Column(
        children: [
          Expanded(
              child: Center(
            child: Container(
              constraints: BoxConstraints(maxHeight: screenSize.height * 2 / 3),
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          return CustomPaint(
                            painter: MoonPainter(
                              animationValue: _animation.value,
                              lightGradientColors: lightGradient,
                              darkGradientColors: darkGradient,
                              backgroundColor: currentBgColor, // Use the static background color for the mask
                            ),
                            child: SizedBox(
                              width: screenSize.width / 3,
                              height: screenSize.width / 3,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 40),
                      Text(
                        'Choose a style',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: currentTextColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Pop a subtitle. Day or Night.\nCustom your interface',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: currentTextColor),
                      ),
                      const SizedBox(height: 40),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: currentShadowColor,
                              spreadRadius: 1,
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ToggleSwitch(
                          minWidth: screenSize.width / 4,
                          initialLabelIndex: isDarkMode ? 1 : 0,
                          cornerRadius: 20.0,
                          radiusStyle: true,
                          activeFgColor: isDarkMode ? Colors.white : Colors.black,
                          inactiveBgColor: isDarkMode ? Colors.black : Colors.grey[300],
                          inactiveFgColor: currentTextColor,
                          totalSwitches: 2,
                          labels: const ['Light', 'Dark'],
                          activeBgColors: isDarkMode
                              ? [[Colors.grey[800]!], [Colors.grey[800]!]]
                              : [[Colors.white], [Colors.white]],
                          onToggle: (index) {
                            themeProvider.toggleTheme();
                            if (index == 1) {
                              _controller.forward();
                            } else {
                              _controller.reverse();
                            }
                          },
                        ),
                      ),
                    ],
                  );
                },
                itemCount: 3,
                index: 1,
                pagination: SwiperPagination(
                  builder: RectSwiperPaginationBuilder(
                    size: const Size(3.5, 3.5),
                    activeSize: const Size(10.0, 5.0),
                    space: 3,
                    color:isDarkMode?Colors.white30: Colors.black26,
                    activeColor:isDarkMode?Colors.white: Colors.black,
                  ),
                ),
              ),
            ),
          )),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Skip', style: TextStyle(color: currentTextColor)),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.arrow_forward, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MoonPainter extends CustomPainter {
  final double animationValue; // 0.0 for light, 1.0 for dark
  final List<Color> lightGradientColors;
  final List<Color> darkGradientColors;
  final Color backgroundColor;

  MoonPainter({
    required this.animationValue,
    required this.lightGradientColors,
    required this.darkGradientColors,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final currentGradient = LinearGradient.lerp(
      LinearGradient(colors: lightGradientColors, begin: Alignment.bottomLeft, end: Alignment.topRight),
      LinearGradient(colors: darkGradientColors, begin: Alignment.bottomLeft, end: Alignment.topRight),
      animationValue,
    )!;

    final moonPaint = Paint()
      ..shader = currentGradient.createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, moonPaint);

    if (animationValue <= 0) return;

    final overlayPaint = Paint()..color = backgroundColor;

    final finalOverlayRadius = radius + 5.0;
    final currentOverlayRadius = finalOverlayRadius * animationValue;

    final angle = -pi / 4;
    const shift = Offset(40.0, -40.0);

    final startDistance = radius;
    final endDistance = 15.0;

    final startPos = Offset(center.dx + startDistance * cos(angle), center.dy + startDistance * sin(angle)) + shift;
    final endPos = Offset(center.dx - endDistance * cos(angle), center.dy - endDistance * sin(angle)) + shift;

    final currentOffset = Offset.lerp(startPos, endPos, animationValue);

    if (currentOffset != null) {
      canvas.drawCircle(currentOffset, currentOverlayRadius, overlayPaint);
    }
  }

  @override
  bool shouldRepaint(covariant MoonPainter oldDelegate) {
    return animationValue != oldDelegate.animationValue ||
        backgroundColor != oldDelegate.backgroundColor;
  }
}
