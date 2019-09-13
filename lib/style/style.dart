import 'package:flutter/material.dart';

final primary = const Color(0xFF77BB23);
final secondary = const Color(0xFFFFB70F);
final tertiary = const Color(0xFFFF5752);
final orange = const Color(0xFFFF600E);
final danger = const Color(0xFFcb202d);
final dark = const Color(0xFF040C0E);
final darker = const Color(0xFF483E3E);
final darkLight = const Color(0xFF132226);
final darkLighter = const Color(0xFF525B56);
final light = const Color(0xFFA4978E);
final borderColor = const Color(0xFFA4978D);
final gold = const Color(0xFFff9600);
final bgGrey = Color(0xFFF3F3F2);
final darkGrey = const Color(0xFF525252);
final lightBlue = const Color(0xFFececec);
final border = const Color(0xFF707070);
final grey = const Color(0xFF232222);

//--------------------------- screen height & width ----------------------------

double screenHeight(context) {
  return MediaQuery.of(context).size.height;
}

double screenWidth(context) {
  return MediaQuery.of(context).size.width;
}

//---------------------------------- text-styles sans italic -------------------

TextStyle smallAddressWhiteSI() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12.0,
    color: Colors.white,
    fontFamily: 'OpenSansItalic',
  );
}

//---------------------------------- text-styles sans Regular ------------------


TextStyle subTitleWhite2SR() {
  return new TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14.0,
    color: Colors.white,
    letterSpacing: 0.5,
    fontFamily: 'OpenSansRegular',
  );
}

TextStyle smallAddressGreySR() {
  return new TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 12.0,
    color: grey,
    fontFamily: 'OpenSansRegular',
  );
}

TextStyle smallAddressWhiteSR() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12.0,
    color: Colors.white,
    fontFamily: 'OpenSansRegular',
  );
}

TextStyle smallAddressWhite2SR() {
  return new TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 12.0,
    color: Colors.white.withOpacity(0.69),
    letterSpacing: 0.7,
    fontFamily: 'OpenSansRegular',
  );
}

TextStyle subTitleWhiteSR() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16.0,
    color: Colors.white,
    letterSpacing: 1.0,
    fontFamily: 'OpenSansRegular',
  );
}

TextStyle categoryWhiteSR() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 15.0,
    color: Colors.white,
    fontFamily: 'OpenSansRegular',
  );
}

TextStyle subTitleWhiteUnderline2SR() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
    color: Colors.white,
    letterSpacing: 1.0,
    fontFamily: 'OpenSansRegular',
    decoration: TextDecoration.underline,
  );
}

//---------------------------------- text-styles sans semibold -------------------------------

TextStyle headerTitleLight() {
  return TextStyle(
    fontSize: 24.0,
    color: Colors.white,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.0,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle emptyScreenHeaderTitle() {
  return TextStyle(
    fontSize: 20.0,
    color: Colors.white,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.0,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle lightHeaderTitle() {
  return TextStyle(
    fontSize: 16.0,
    color: lightBlue,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.0,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle subBoldTitleStyle() {
  return new TextStyle(
    fontSize: 16.0,
    color: Colors.white,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.0,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle hintStyleDarkSmall() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12.0,
    color: Colors.black26,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle smallDescription() {
  return new TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 12.0,
    color: Colors.black38,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle smallBoldDescription() {
  return new TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 12.0,
    color: Colors.black54,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle smallAddress() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
    color: Colors.black45,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle address() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
    color: Colors.black87,
    letterSpacing: 1.0,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle category() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
    color: darkLighter,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle cardText() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 13.0,
    color: Colors.black,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle subTitle() {
  return new TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16.0,
    color: darkGrey,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle subBoldTitle() {
  return new TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
    color: darkLighter,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle subBoldTitleUnderline() {
  return new TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
    color: darkLighter,
    fontFamily: 'OpenSansSemiBold',
    decoration: TextDecoration.underline
  );
}

TextStyle priceDescription() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 15.0,
    color: Colors.black38,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle priceDescriptionText() {
  return new TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 15.0,
    color: Colors.black54,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle hintStyleDark() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
    color: Colors.black54,
    letterSpacing: 1.0,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle subTitleBlack() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
    color: Colors.black87,
    letterSpacing: 1.0,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle roundButton() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
    color: darkLight,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle categoryTitle2() {
  return new TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
    color: Colors.black45,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle productTitle() {
  return new TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14.0,
    color: Colors.black87,
    letterSpacing: 1.0,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle categoryTitle() {
  return new TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 13.0,
    color: darker,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle titleStyle() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
    color: darkLight,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle titleBlack() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 18.0,
    color: darker,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle titleStyleBoldLight() {
  return new TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16.0,
    color: darker,
    letterSpacing: 1.0,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle titleLighter() {
  return new TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18.0,
    color: Colors.black45,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle title() {
  return new TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18.0,
    color: Colors.black87,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle titleLight() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 20.0,
    color: Colors.black87,
    letterSpacing: 1.0,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle textStyleGreySS() {
  return new TextStyle(
    fontWeight: FontWeight.w900,
    fontSize: 14.0,
    color: darkGrey,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle textSmallStyleGreySS() {
  return new TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
    color: darkGrey,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle titleStyleBold() {
  return new TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 20.0,
    color: Colors.black87,
    letterSpacing: 1.0,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle titleStyleLight() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
    color: darker,
    letterSpacing: 1.0,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle titleStyleLighter() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 22.0,
    color: darker,
    letterSpacing: 0.0,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle titleStyle2() {
  return new TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 22.0,
    color: Colors.black87,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle titleStyle3() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 38.0,
    color: darkLight,
    decoration: TextDecoration.underline,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle subTitleDarkSS() {
  return new TextStyle(
    fontWeight: FontWeight.w900,
    fontSize: 11.0,
    color: grey,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle smallAddressSS() {
  return new TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 12.0,
    color: grey.withOpacity(0.61),
    fontFamily: 'OpenSansSemiBold',
  );
}

//------------------------------ white-text ------------------------------------

TextStyle smallDescriptionWhite() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12.0,
    color: Colors.white30,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle smallBoldDescriptionWhite() {
  return new TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 12.0,
    color: Colors.white30,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle hintStyle() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
    color: Colors.white70,
    letterSpacing: 1.0,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle categoryTitleWhite() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
    color: Colors.white70,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle smallAddressWhite() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
    color: Colors.white,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle subBoldTitleWhite() {
  return new TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
    color: Colors.white,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle subBoldTitleWhiteLight() {
  return new TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
    color: Colors.white70,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle priceDescriptionTextWhite() {
  return new TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 15.0,
    color: Colors.white70,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle descriptionWhite() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16.0,
    color: Colors.white30,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle productTitleWhite() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16.0,
    color: Colors.white70,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle subTitleWhite() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 11.0,
    color: Colors.white,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle subTitleWhite2() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
    color: Colors.white,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle subTitleWhiteUnderline2() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
    color: Colors.white,
    letterSpacing: 1.0,
    fontFamily: 'OpenSansSemiBold',
    decoration: TextDecoration.underline,
  );
}

TextStyle subTitleWhiteUnderline() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16.0,
    color: Colors.white,
    letterSpacing: 1.0,
    fontFamily: 'OpenSansSemiBold',
    decoration: TextDecoration.underline,
  );
}

TextStyle categoryLightWhite() {
  return new TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16.0,
    color: Colors.white30,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle categoryWhite() {
  return new TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
    color: Colors.white,
    letterSpacing: 1.0,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle titleWhite2() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 18.0,
    color: Colors.white,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle titleWhiteBold() {
  return new TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18.0,
    color: Colors.white,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle titleBoldWhite() {
  return new TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16.0,
    color: Colors.white,
    letterSpacing: 1.0,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle buttonStyle() {
  return new TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 18.0,
    color: Colors.white,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle subTitleUnderline() {
  return new TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 15.0,
    color: Colors.white,
//    decoration: TextDecoration.underline,
    letterSpacing: 1.0,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle titleStyleWhite() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 20.0,
    color: Colors.white70,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle titleWhite() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 20.0,
    color: Colors.white,
    letterSpacing: 1.0,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle titleStyle2White() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 22.0,
    color: Colors.white70,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle titleStyleBoldWhite() {
  return new TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 24.0,
    color: Colors.white70,
    fontFamily: 'OpenSansSemiBold',
  );
}

//---------------------------------- primary-text ------------------------------
TextStyle primaryText() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12.0,
    color: primary,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle primaryTitleText() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16.0,
    color: primary,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle deliverText() {
  return new TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16.0,
    color: primary,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle primaryTextUnderline() {
  return new TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
    color: primary,
    decoration: TextDecoration.underline,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle primaryHeaderText() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 18.0,
    color: primary,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle primaryBoldHeaderText() {
  return new TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18.0,
    color: primary,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle primaryTitle() {
  return new TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 20.0,
    color: primary,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle primaryTitleLight() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 20.0,
    color: primary,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle primaryHeaderTitle() {
  return new TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 32.0,
    color: primary,
    fontFamily: 'OpenSansSemiBold',
  );
}

//--------------------------------- red-text -----------------------------------

TextStyle redText() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
    color: tertiary,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle redBoldText() {
  return new TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
    color: tertiary,
    fontFamily: 'OpenSansSemiBold',
  );
}
//--------------------------------- yellow-text --------------------------------

TextStyle titleStyleYellow() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 18.0,
    color: Colors.yellow.shade400,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle titleStyleBoldYellow() {
  return new TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 20.0,
    color: Colors.yellow,
    fontFamily: 'OpenSansSemiBold',
  );
}

//--------------------------------- offer-text ---------------------------------

TextStyle offer() {
  return new TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 22.0,
    color: Colors.grey.shade500,
    fontFamily: 'RobotoMono',
  );
}

//--------------------------------- blue-text ----------------------------------

TextStyle blueText() {
  return new TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14.0,
    color: Colors.blueAccent,
    fontFamily: 'RobotoMono',
  );
}

//--------------------------------- logo-text ----------------------------------

TextStyle logoText() {
  return new TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 28.0,
    color: Colors.white,
    fontFamily: 'DancingScript',
  );
}

TextStyle infoText() {
  return new TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 24.0,
    color: Colors.white,
    fontFamily: 'DancingScript',
  );
}

//-------------------------------- secondary-text ------------------------------

TextStyle secondaryTitleText() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16.0,
    color: secondary,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle secondaryBoldTitleText() {
  return new TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16.0,
    color: secondary,
    fontFamily: 'OpenSansSemiBold',
  );
}

//-------------------------------------- red-text ------------------------------

TextStyle textStyleRed() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12.0,
    color: danger,
    fontFamily: 'OpenSansSemiBold',
  );
}

//-------------------------------------- orange-text ------------------------------

TextStyle textStyleOrangeSS() {
  return new TextStyle(
    fontWeight: FontWeight.w900,
    fontSize: 14.0,
    color: orange,
    fontFamily: 'OpenSansSemiBold',
  );
}

TextStyle productTitleOrange() {
  return new TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14.0,
    color: orange,
    letterSpacing: 1.0,
    fontFamily: 'OpenSansSemiBold',
  );
}