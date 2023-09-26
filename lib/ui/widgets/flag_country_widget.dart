import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';

class FlagWCountryWidget extends StatelessWidget {
  final String country;
  const FlagWCountryWidget({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 30,
      child: ClipRRect(
        child: CountryFlag.fromCountryCode(
          country,
          height: 120,
          width: 120,
          borderRadius: 0,
        ),
      ),
    );
  }
}
