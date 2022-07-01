import 'package:flutter/material.dart';

const MaterialColor kPrimaryColor = MaterialColor(
  0xFF7815F5,
  <int, Color>{
    50: Color(0xFF7815F5),
    100: Color(0xFF7815F5),
    200: Color(0xFF7815F5),
    300: Color(0xFF7815F5),
    400: Color(0xFF7815F5),
    500: Color(0xFF7815F5),
    600: Color(0xFF7815F5),
    700: Color(0xFF7815F5),
    800: Color(0xFF7815F5),
    900: Color(0xFF7815F5),
  },
);
const kButtonPrimaryColor = Color(0xFF181B1F);
const kBackgroundColor = Color(0xFFE5E5E5);
const kButtonGradientColor = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0xFF2CABED), Color(0xFF0078B7)],
);
const kSplashGradientColor = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0xFF4892F1), Color(0xFF4487DD)],
);
const kOnBoardGradientColor = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Colors.white, Color(0xFFE5E2FF)],
);
const headingStyle = TextStyle(
  fontWeight: FontWeight.w500,
  color: Colors.black,
  height: 1.5,
);
