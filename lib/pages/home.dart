import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/places.dart';
import '../widgets/place_card.dart';
import '../models/place.dart';
import 'details_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  String selectedContinent = 'Asia';
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  Set<String> favorites = {};
  String searchQuery = '';
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
    _loadFavorites();
  }

  @override
  void dispose() {
    _animationController.dispose();
    searchController.dispose();
    super.dispose();
  }

  void _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      favorites = prefs.getStringList('favorites')?.toSet() ?? {};
    });
  }

  void _toggleFavorite(String placeKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (favorites.contains(placeKey)) {
        favorites.remove(placeKey);
      } else {
        favorites.add(placeKey);
      }
    });
    await prefs.setStringList('favorites', favorites.toList());
  }

  void _selectContinent(String continent) {
    setState(() {
      selectedContinent = continent;
      // Also reset text field just to be clean, or keep it.
      // searchController.clear();
      // searchQuery = '';
    });
    _animationController.reset();
    _animationController.forward();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 40.0, left: 30.0),
        child: Column(
          children: [
            // Ligne : texte + image
            Row(
              children: [
                Text(
                  "Hello, let's traveling !",
                  style: GoogleFonts.poppins(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 183, 58, 121),
                  ),
                ),
                const SizedBox(width: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset(
                    'images/travel.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Ligne : champ recherche + bouton filtre
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value.toLowerCase();
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search your destination',
                      hintStyle: GoogleFonts.poppins(color: Colors.grey),
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(
                      'images/filter.jpg',
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Liste horizontale (choix des continents)
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: allPlaces.keys.map((continent) {
                  bool isSelected = selectedContinent == continent;
                  return GestureDetector(
                    onTap: () => _selectContinent(continent),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.only(right: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color.fromARGB(255, 183, 58, 121)
                            : const Color.fromARGB(255, 243, 237, 237),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Center(
                        child: Text(
                          continent,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : Colors.grey[800],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Builder(
                  builder: (context) {
                    List<Place> places = allPlaces[selectedContinent]!
                        .where((place) =>
                            place.name.toLowerCase().contains(searchQuery) ||
                            place.country.toLowerCase().contains(searchQuery) ||
                            place.description.toLowerCase().contains(searchQuery))
                        .toList();
                    return GridView.builder(
                      padding: const EdgeInsets.only(right: 30.0, bottom: 20.0),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: places.length,
                      itemBuilder: (context, index) {
                        Place place = places[index];
                        String placeKey = '${place.country}_${place.name}';
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsPage(place: place),
                              ),
                            );
                          },
                          child: PlaceCard(
                            place: place,
                            isFavorite: favorites.contains(placeKey),
                            onFavoriteToggle: () => _toggleFavorite(placeKey),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
