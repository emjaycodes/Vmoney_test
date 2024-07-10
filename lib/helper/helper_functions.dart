import 'dart:math';

class HelperFunctions {
  // Helper function to get a random image URL
static String getRandomImageUrl(int index) {
  final int randomImageId = Random().nextInt(1000); // Generates a random number between 0 and 999
  return 'https://picsum.photos/seed/$index/600/400'; // Using Lorem Picsum API
}

}