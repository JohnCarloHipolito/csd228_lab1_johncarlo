import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final PageController _pageController = PageController();

  final List<TouristSpot> spots = [
    const TouristSpot(
      name: 'Yellowstone National Park',
      location: 'Wyoming, USA',
      image: 'images/yellowstone.png',
      description: 'Yellowstone National Park is a nearly 3,500-sq.-mile '
          'wilderness recreation area atop a volcanic hot spot. Mostly in '
          'Wyoming, the park spreads into parts of Montana and Idaho too. '
          'Yellowstone features dramatic canyons, alpine rivers, lush '
          'forests, hot springs and gushing geysers, including its most '
          'famous, Old Faithful. It\'s also home to hundreds of animal '
          'species, including bears, wolves, bison, elk and antelope.',
      rating: '4.3',
    ),
    const TouristSpot(
      name: 'Great Wall of China',
      location: 'China',
      image: 'images/great_wall_of_china.png',
      description: 'The Great Wall of China is a series of fortifications '
          'made of stone, brick, tamped earth, wood, and other materials, '
          'generally built along an east-to-west line across the historical '
          'northern borders of China to protect the Chinese states and '
          'empires against the raids and invasions of the various nomadic '
          'groups of the Eurasian Steppe with an eye to expansion.',
      rating: '4.7',
    ),
    const TouristSpot(
      name: 'Machu Picchu',
      location: 'Peru',
      image: 'images/machu_picchu.png',
      description: 'Machu Picchu is a 15th-century Inca citadel located in '
          'the Eastern Cordillera of southern Peru on a 2,430-meter mountain '
          'ridge. It is located in the Machupicchu District within Urubamba '
          'Province above the Sacred Valley, which is 80 kilometers northwest '
          'of Cuzco. The Urubamba River flows past it, cutting through the '
          'Cordillera and creating a canyon with a tropical mountain climate.',
      rating: '5.0',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    const String appTitle = 'Famous Tourist Destinations';

    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.grey[900],
        scaffoldBackgroundColor: Colors.grey[850],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[900],
        ),
        colorScheme: ColorScheme.dark(
          primary: Colors.grey[900]!,
          onPrimary: Colors.white,
          surface: Colors.grey[850]!,
          onSurface: Colors.white,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        drawer: Drawer(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: spots.length,
            itemBuilder: (context, index) {
              final spot = spots[index];
              return ListTile(
                title: Text(spot.name),
                onTap: () {
                  Navigator.pop(context);
                  _pageController.jumpToPage(index);
                },
              );
            },
          ),
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: spots.length,
          itemBuilder: (context, index) {
            final spot = spots[index];
            return Column(
              children: [
                ImageSection(image: spot.image),
                TitleSection(name: spot.name, location: spot.location, rating: spot.rating),
                const ButtonSection(),
                TextSection(description: spot.description),
              ],
            );
          },
        ),
      ),
    );
  }
}

class TouristSpot {
  const TouristSpot({
    required this.name,
    required this.location,
    required this.image,
    required this.description,
    required this.rating,
  });

  final String name;
  final String location;
  final String image;
  final String description;
  final String rating;
}

class TitleSection extends StatelessWidget {
  const TitleSection({
    super.key,
    required this.name,
    required this.location,
    required this.rating,
  });

  final String name;
  final String location;
  final String rating;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Text(
                  location,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          RatingStars(rating: double.parse(rating)),
        ],
      ),
    );
  }
}

class RatingStars extends StatelessWidget {
  const RatingStars({
    super.key,
    required this.rating,
  });

  final double rating;

  @override
  Widget build(BuildContext context) {
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;
    int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);

    return Row(
      children: [
        for (int i = 0; i < fullStars; i++)
          const Icon(Icons.star, color: Colors.red),
        if (hasHalfStar)
          const Icon(Icons.star_half, color: Colors.red),
        for (int i = 0; i < emptyStars; i++)
          const Icon(Icons.star_border, color: Colors.red),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            rating.toStringAsFixed(1), // Format rating to one decimal place
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ButtonWithText(
            icon: Icons.call,
            label: 'CALL',
            color: Colors.blue,
          ),
          ButtonWithText(
            icon: Icons.near_me,
            label: 'ROUTE',
            color: Colors.green,
          ),
          ButtonWithText(
            icon: Icons.share,
            label: 'SHARE',
            color: Colors.yellow,
          ),
        ],
      ),
    );
  }
}

class ButtonWithText extends StatelessWidget {
  const ButtonWithText({
    super.key,
    required this.icon,
    required this.label,
    this.color = Colors.white, // Default color
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: color),
      label: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: color,
        ),
      ),
      style: ElevatedButton.styleFrom(
        foregroundColor: color, backgroundColor: Colors.black12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
    );
  }
}

class TextSection extends StatelessWidget {
  const TextSection({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Text(
        description,
        softWrap: true,
      ),
    );
  }
}

class ImageSection extends StatelessWidget {
  const ImageSection({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      width: 600,
      height: 240,
      fit: BoxFit.cover,
    );
  }
}
