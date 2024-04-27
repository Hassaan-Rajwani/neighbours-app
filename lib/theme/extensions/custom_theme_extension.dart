import 'package:flutter/material.dart';

extension ExtendedTheme on BuildContext {
  CustomThemeExtension get theme {
    return Theme.of(this).extension<CustomThemeExtension>()!;
  }
}

class CustomThemeExtension extends ThemeExtension<CustomThemeExtension> {
  const CustomThemeExtension({
    //COMMON
    this.primaryWelcomePine,
    this.primaryWelcomeGradientOne,
    this.primaryWelcomeGradientTwo,
    this.primaryWelcomeWhite,
    this.debitPistachio,
    this.creditSea,
    this.plusLand,
    this.atWorkGrass,
    this.secondaryMetal,
    this.secondarySteel,
  });

  final Color? primaryWelcomePine;
  final Color? primaryWelcomeGradientOne;
  final Color? primaryWelcomeGradientTwo;
  final Color? primaryWelcomeWhite;
  final Color? debitPistachio;
  final Color? creditSea;
  final Color? plusLand;
  final Color? atWorkGrass;
  final Color? secondaryMetal;
  final Color? secondarySteel;

//LIGHT MODE
  static const lightMode = CustomThemeExtension(
    primaryWelcomePine: Color(0xff07404b),
    primaryWelcomeGradientOne: Color(0xffbcdc49),
    primaryWelcomeGradientTwo: Color(0xff1b5cfd),
    primaryWelcomeWhite: Color(0xffffffff),
    debitPistachio: Color(0xffc6e5de),
    creditSea: Color(0xff9ed3ce),
    plusLand: Color(0xffbcdc49),
    atWorkGrass: Color(0xff75b83b),
    secondaryMetal: Color(0xffd6d8d8),
    secondarySteel: Color(0xffb8bcbc),
  );

  @override
  ThemeExtension<CustomThemeExtension> copyWith({
    Color? primaryWelcomePine,
    Color? primaryWelcomeGradientOne,
    Color? primaryWelcomeGradientTwo,
    Color? primaryWelcomeWhite,
    Color? debitPistachio,
    Color? creditSea,
    Color? plusLand,
    Color? atWorkGrass,
    Color? secondaryMetal,
    Color? secondarySteel,
  }) {
    return CustomThemeExtension(
        primaryWelcomePine: primaryWelcomePine ?? this.primaryWelcomePine,
        primaryWelcomeGradientOne:
            primaryWelcomeGradientOne ?? this.primaryWelcomeGradientOne,
        primaryWelcomeGradientTwo:
            primaryWelcomeGradientTwo ?? this.primaryWelcomeGradientTwo,
        primaryWelcomeWhite: primaryWelcomeWhite ?? this.primaryWelcomeWhite,
        debitPistachio: debitPistachio ?? this.debitPistachio,
        creditSea: creditSea ?? this.creditSea,
        plusLand: plusLand ?? this.plusLand,
        atWorkGrass: atWorkGrass ?? this.atWorkGrass,
        secondaryMetal: secondaryMetal ?? this.secondaryMetal,
        secondarySteel: secondarySteel ?? this.secondarySteel,);
  }

  @override
  ThemeExtension<CustomThemeExtension> lerp(
      ThemeExtension<CustomThemeExtension>? other, double t,) {
    if (other is! CustomThemeExtension) return this;
    return CustomThemeExtension(
      primaryWelcomePine: Color.lerp(
        primaryWelcomePine,
        other.primaryWelcomePine,
        t,
      ),
      primaryWelcomeGradientOne: Color.lerp(
        primaryWelcomeGradientOne,
        other.primaryWelcomeGradientOne,
        t,
      ),
      primaryWelcomeGradientTwo: Color.lerp(
        primaryWelcomeGradientTwo,
        other.primaryWelcomeGradientTwo,
        t,
      ),
      primaryWelcomeWhite: Color.lerp(
        primaryWelcomeWhite,
        other.primaryWelcomeWhite,
        t,
      ),
      debitPistachio: Color.lerp(
        debitPistachio,
        other.debitPistachio,
        t,
      ),
      creditSea: Color.lerp(creditSea, other.creditSea, t),
      plusLand: Color.lerp(plusLand, other.plusLand, t),
      atWorkGrass: Color.lerp(atWorkGrass, other.atWorkGrass, t),
      secondaryMetal: Color.lerp(secondaryMetal, other.secondaryMetal, t),
      secondarySteel: Color.lerp(secondarySteel, other.secondarySteel, t),
    );
  }
}
