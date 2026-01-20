import '../models/place.dart';

List<Place> asiaPlaces = [
  Place(
    name: 'Bali',
    country: 'Indonesia',
    imagePath: 'images/bali.jpg',
    description: 'Beautiful beaches and temples in Bali.',
    rating: 4.8,
    price: 850.0,
    reviews: 1205,
  ),
  Place(
    name: 'Tokyo',
    country: 'Japan',
    imagePath: 'images/tokyo.jpg',
    description: 'Modern city with traditional culture.',
    rating: 4.7,
    price: 1300.0,
    reviews: 3400,
  ),
  Place(
    name: 'Bangkok',
    country: 'Thailand',
    imagePath: 'images/bangkok.jpg',
    description: 'Vibrant city with street food and temples.',
    rating: 4.5,
    price: 600.0,
    reviews: 2100,
  ),
];

List<Place> europePlaces = [
  Place(
    name: 'Paris',
    country: 'France',
    imagePath: 'images/paris.jpg',
    description: 'City of lights and romance.',
    rating: 4.9,
    price: 1500.0,
    reviews: 5600,
  ),
  Place(
    name: 'Rome',
    country: 'Italy',
    imagePath: 'images/rome.jpg',
    description: 'Ancient history and delicious food.',
    rating: 4.8,
    price: 1100.0,
    reviews: 4300,
  ),
  Place(
    name: 'Barcelona',
    country: 'Spain',
    imagePath: 'images/barcelona.jpg',
    description: 'Gaudi architecture and beaches.',
    rating: 4.6,
    price: 950.0,
    reviews: 2800,
  ),
];

List<Place> southAmericaPlaces = [
  Place(
    name: 'Rio de Janeiro',
    country: 'Brazil',
    imagePath: 'images/brazil.jpg',
    description: 'Carnival and Christ the Redeemer.',
    rating: 4.7,
    price: 1200.0,
    reviews: 1900,
  ),
  Place(
    name: 'Machu Picchu',
    country: 'Peru',
    imagePath: 'images/machu_picchu.jpg',
    description: 'Ancient Incan citadel.',
    rating: 4.9,
    price: 1400.0,
    reviews: 3100,
  ),
];

List<Place> northAmericaPlaces = [
  Place(
    name: 'New York',
    country: 'USA',
    imagePath: 'images/new_york.jpg',
    description: 'The Big Apple, Statue of Liberty.',
    rating: 4.8,
    price: 1800.0,
    reviews: 6700,
  ),
];

List<Place> africaPlaces = [
  Place(
    name: 'Cairo',
    country: 'Egypt',
    imagePath: 'images/cairo.jpg',
    description: 'Pyramids of Giza and ancient history.',
    rating: 4.7,
    price: 800.0,
    reviews: 2500,
  ),
];

List<Place> oceaniaPlaces = [
  Place(
    name: 'Sydney',
    country: 'Australia',
    imagePath: 'images/sydney.jpg',
    description: 'Opera House and Harbour Bridge.',
    rating: 4.8,
    price: 1600.0,
    reviews: 3200,
  ),
];

Map<String, List<Place>> allPlaces = {
  'Asia': asiaPlaces,
  'Europe': europePlaces,
  'South America': southAmericaPlaces,
  'North America': northAmericaPlaces,
  'Africa': africaPlaces,
  'Oceania': oceaniaPlaces,
};