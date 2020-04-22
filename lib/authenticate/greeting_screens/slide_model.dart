import 'package:flutter/material.dart';

class Slide {
  final String imageUrl;
  final String title;
  final String description;

  Slide({
    @required this.imageUrl,
    @required this.title,
    @required this.description,
  });
}

final slideList = [
  Slide(
    imageUrl: 'assets/onboarding_graphics/home.svg',
    title: 'Control your smart devices',
    description: 'Go into a room from the home page to control the devices in it',
  ),
  Slide(
    imageUrl: 'assets/onboarding_graphics/relax.svg',
    title: 'Set routines',
    description: 'Automate your devices with the power of AI',
  ),
  Slide(
    imageUrl: 'assets/onboarding_graphics/analytics.svg',
    title: 'Energy statistics',
    description: 'Beautifully visualised graphs that give you an insight on your energy usage',
  ),
  Slide(
    imageUrl: 'assets/onboarding_graphics/voice.svg',
    title: 'Voice assistant',
    description: 'Just say the sentence, "Turn on living room lamp"',
  ),
  Slide(
    imageUrl: 'assets/onboarding_graphics/fav.svg',
    title: 'Favourite devices',
    description: 'Access your most used smart devices from the home screen',
  ),
  Slide(
    imageUrl: 'assets/onboarding_graphics/comm.svg',
    title: 'Community leaderboard',
    description: 'Compete with your neighbors on who consumes the least amount of energy',
  ),
  Slide(
    imageUrl: 'assets/onboarding_graphics/welcome.svg',
    title: 'Welcome to Homi',
    description: 'The future of smart home control',
  ),
];
