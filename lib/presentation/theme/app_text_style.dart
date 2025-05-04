import 'package:flutter/material.dart';

class AppTextStyle {
  static const String _defaultFont = 'Mulish';

  static const FontWeight _extraLightFontWeight = FontWeight.w200;
  static const FontWeight _lightFontWeight = FontWeight.w300;
  static const FontWeight _regularFontWeight = FontWeight.w400;
  static const FontWeight _mediumFontWeight = FontWeight.w500;
  static const FontWeight _semiBoldFontWeight = FontWeight.w600;
  static const FontWeight _boldFontWeight = FontWeight.w700;
  static const FontWeight _extraBoldFontWeight = FontWeight.w800;
  static const FontWeight _blackFontWeight = FontWeight.w900;

  static const double _size3XS = 9;
  static const double _size2XS = 10;
  static const double _sizeXS = 12;
  static const double _sizeSM = 14;
  static const double _sizeMD = 16;
  static const double _sizeLG = 18;
  static const double _sizeXL = 20;
  static const double _size2XL = 24;
  static const double _size3XL = 32;
  static const double _size4XL = 48;
  static const double _size5XL = 56;
  static const double _size6XL = 64;
  static const double _size7XL = 72;

  /// base [TextStyle] used for all custom styles
  static TextStyle _textStyle(double size, FontWeight fontWeight) {
    return TextStyle(
      fontSize: size,
      fontWeight: fontWeight,
      fontFamily: _defaultFont,
    );
  }

  static TextStyle get extraLight9 => _textStyle(_size3XS, _extraLightFontWeight);
  static TextStyle get extraLight10 => _textStyle(_size2XS, _extraLightFontWeight);
  static TextStyle get extraLight12 => _textStyle(_sizeXS, _extraLightFontWeight);
  static TextStyle get extraLight14 => _textStyle(_sizeSM, _extraLightFontWeight);
  static TextStyle get extraLight16 => _textStyle(_sizeMD, _extraLightFontWeight);
  static TextStyle get extraLight18 => _textStyle(_sizeLG, _extraLightFontWeight);
  static TextStyle get extraLight20 => _textStyle(_sizeXL, _extraLightFontWeight);
  static TextStyle get extraLight24 => _textStyle(_size2XL, _extraLightFontWeight);
  static TextStyle get extraLight32 => _textStyle(_size3XL, _extraLightFontWeight);
  static TextStyle get extraLight48 => _textStyle(_size4XL, _extraLightFontWeight);
  static TextStyle get extraLight56 => _textStyle(_size5XL, _extraLightFontWeight);
  static TextStyle get extraLight64 => _textStyle(_size6XL, _extraLightFontWeight);
  static TextStyle get extraLight72 => _textStyle(_size7XL, _extraLightFontWeight);
  static TextStyle get light9 => _textStyle(_size3XS, _lightFontWeight);
  static TextStyle get light10 => _textStyle(_size2XS, _lightFontWeight);
  static TextStyle get light12 => _textStyle(_sizeXS, _lightFontWeight);
  static TextStyle get light14 => _textStyle(_sizeSM, _lightFontWeight);
  static TextStyle get light16 => _textStyle(_sizeMD, _lightFontWeight);
  static TextStyle get light18 => _textStyle(_sizeLG, _lightFontWeight);
  static TextStyle get light20 => _textStyle(_sizeXL, _lightFontWeight);
  static TextStyle get light24 => _textStyle(_size2XL, _lightFontWeight);
  static TextStyle get light32 => _textStyle(_size3XL, _lightFontWeight);
  static TextStyle get light48 => _textStyle(_size4XL, _lightFontWeight);
  static TextStyle get light56 => _textStyle(_size5XL, _lightFontWeight);
  static TextStyle get light64 => _textStyle(_size6XL, _lightFontWeight);
  static TextStyle get light72 => _textStyle(_size7XL, _lightFontWeight);
  static TextStyle get regular9 => _textStyle(_size3XS, _regularFontWeight);
  static TextStyle get regular10 => _textStyle(_size2XS, _regularFontWeight);
  static TextStyle get regular12 => _textStyle(_sizeXS, _regularFontWeight);
  static TextStyle get regular14 => _textStyle(_sizeSM, _regularFontWeight);
  static TextStyle get regular16 => _textStyle(_sizeMD, _regularFontWeight);
  static TextStyle get regular18 => _textStyle(_sizeLG, _regularFontWeight);
  static TextStyle get regular20 => _textStyle(_sizeXL, _regularFontWeight);
  static TextStyle get regular24 => _textStyle(_size2XL, _regularFontWeight);
  static TextStyle get regular32 => _textStyle(_size3XL, _regularFontWeight);
  static TextStyle get regular48 => _textStyle(_size4XL, _regularFontWeight);
  static TextStyle get regular56 => _textStyle(_size5XL, _regularFontWeight);
  static TextStyle get regular64 => _textStyle(_size6XL, _regularFontWeight);
  static TextStyle get regular72 => _textStyle(_size7XL, _regularFontWeight);
  static TextStyle get medium9 => _textStyle(_size3XS, _mediumFontWeight);
  static TextStyle get medium10 => _textStyle(_size2XS, _mediumFontWeight);
  static TextStyle get medium12 => _textStyle(_sizeXS, _mediumFontWeight);
  static TextStyle get medium14 => _textStyle(_sizeSM, _mediumFontWeight);
  static TextStyle get medium16 => _textStyle(_sizeMD, _mediumFontWeight);
  static TextStyle get medium18 => _textStyle(_sizeLG, _mediumFontWeight);
  static TextStyle get medium20 => _textStyle(_sizeXL, _mediumFontWeight);
  static TextStyle get medium24 => _textStyle(_size2XL, _mediumFontWeight);
  static TextStyle get medium32 => _textStyle(_size3XL, _mediumFontWeight);
  static TextStyle get medium48 => _textStyle(_size4XL, _mediumFontWeight);
  static TextStyle get medium56 => _textStyle(_size5XL, _mediumFontWeight);
  static TextStyle get medium64 => _textStyle(_size6XL, _mediumFontWeight);
  static TextStyle get medium72 => _textStyle(_size7XL, _mediumFontWeight);
  static TextStyle get semiBold9 => _textStyle(_size3XS, _semiBoldFontWeight);
  static TextStyle get semiBold10 => _textStyle(_size2XS, _semiBoldFontWeight);
  static TextStyle get semiBold12 => _textStyle(_sizeXS, _semiBoldFontWeight);
  static TextStyle get semiBold14 => _textStyle(_sizeSM, _semiBoldFontWeight);
  static TextStyle get semiBold16 => _textStyle(_sizeMD, _semiBoldFontWeight);
  static TextStyle get semiBold18 => _textStyle(_sizeLG, _semiBoldFontWeight);
  static TextStyle get semiBold20 => _textStyle(_sizeXL, _semiBoldFontWeight);
  static TextStyle get semiBold24 => _textStyle(_size2XL, _semiBoldFontWeight);
  static TextStyle get semiBold32 => _textStyle(_size3XL, _semiBoldFontWeight);
  static TextStyle get semiBold48 => _textStyle(_size4XL, _semiBoldFontWeight);
  static TextStyle get semiBold56 => _textStyle(_size5XL, _semiBoldFontWeight);
  static TextStyle get semiBold64 => _textStyle(_size6XL, _semiBoldFontWeight);
  static TextStyle get semiBold72 => _textStyle(_size7XL, _semiBoldFontWeight);
  static TextStyle get bold9 => _textStyle(_size3XS, _boldFontWeight);
  static TextStyle get bold10 => _textStyle(_size2XS, _boldFontWeight);
  static TextStyle get bold12 => _textStyle(_sizeXS, _boldFontWeight);
  static TextStyle get bold14 => _textStyle(_sizeSM, _boldFontWeight);
  static TextStyle get bold16 => _textStyle(_sizeMD, _boldFontWeight);
  static TextStyle get bold18 => _textStyle(_sizeLG, _boldFontWeight);
  static TextStyle get bold20 => _textStyle(_sizeXL, _boldFontWeight);
  static TextStyle get bold24 => _textStyle(_size2XL, _boldFontWeight);
  static TextStyle get bold32 => _textStyle(_size3XL, _boldFontWeight);
  static TextStyle get bold48 => _textStyle(_size4XL, _boldFontWeight);
  static TextStyle get bold56 => _textStyle(_size5XL, _boldFontWeight);
  static TextStyle get bold64 => _textStyle(_size6XL, _boldFontWeight);
  static TextStyle get bold72 => _textStyle(_size7XL, _boldFontWeight);
  static TextStyle get extraBold9 => _textStyle(_size3XS, _extraBoldFontWeight);
  static TextStyle get extraBold10 => _textStyle(_size2XS, _extraBoldFontWeight);
  static TextStyle get extraBold12 => _textStyle(_sizeXS, _extraBoldFontWeight);
  static TextStyle get extraBold14 => _textStyle(_sizeSM, _extraBoldFontWeight);
  static TextStyle get extraBold16 => _textStyle(_sizeMD, _extraBoldFontWeight);
  static TextStyle get extraBold18 => _textStyle(_sizeLG, _extraBoldFontWeight);
  static TextStyle get extraBold20 => _textStyle(_sizeXL, _extraBoldFontWeight);
  static TextStyle get extraBold24 => _textStyle(_size2XL, _extraBoldFontWeight);
  static TextStyle get extraBold32 => _textStyle(_size3XL, _extraBoldFontWeight);
  static TextStyle get extraBold48 => _textStyle(_size4XL, _extraBoldFontWeight);
  static TextStyle get extraBold56 => _textStyle(_size5XL, _extraBoldFontWeight);
  static TextStyle get extraBold64 => _textStyle(_size6XL, _extraBoldFontWeight);
  static TextStyle get extraBold72 => _textStyle(_size7XL, _extraBoldFontWeight);
  static TextStyle get black9 => _textStyle(_size3XS, _blackFontWeight);
  static TextStyle get black10 => _textStyle(_size2XS, _blackFontWeight);
  static TextStyle get black12 => _textStyle(_sizeXS, _blackFontWeight);
  static TextStyle get black14 => _textStyle(_sizeSM, _blackFontWeight);
  static TextStyle get black16 => _textStyle(_sizeMD, _blackFontWeight);
  static TextStyle get black18 => _textStyle(_sizeLG, _blackFontWeight);
  static TextStyle get black20 => _textStyle(_sizeXL, _blackFontWeight);
  static TextStyle get black24 => _textStyle(_size2XL, _blackFontWeight);
  static TextStyle get black32 => _textStyle(_size3XL, _blackFontWeight);
  static TextStyle get black48 => _textStyle(_size4XL, _blackFontWeight);
  static TextStyle get black56 => _textStyle(_size5XL, _blackFontWeight);
  static TextStyle get black64 => _textStyle(_size6XL, _blackFontWeight);
  static TextStyle get black72 => _textStyle(_size7XL, _blackFontWeight);
}
