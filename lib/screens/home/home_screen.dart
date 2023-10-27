import 'package:flutter/material.dart';
import 'package:fitness/constants.dart';

import '../../components/my_bottom_nav_bar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          top: 80,
          left: 15,
          right: 15,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _header(),
              _searchbar(),
              _workoutseeall(),
              _filterButtons(),
              _imageScroller(),
              _newWorkoutscroller()
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

class _newWorkoutscroller extends StatelessWidget {
  final List<String> imageUrls = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqBHyHWLjNNsFGO-nUpWqL_tklP6ks4nkeVVtv9KHsHQ&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTydmIYEMF8OkkRffFVhew9R_-Z6S0cBNcK8rAHZg-YcwRZi6_FvVrj6Qm7G2TssathAk0&usqp=CAU',
    'https://images.unsplash.com/photo-1526506118085-60ce8714f8c5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Z3ltfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60',
    // Add more image URLs
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15), // Add spacing between text and images
        SizedBox(
          height: 150, // Adjust the height as needed
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: imageUrls.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 5), // Add some spacing between images
                child: Stack(
                  children: [
                    ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.6),
                        BlendMode.srcATop,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          imageUrls[index],
                          width: 300, // Adjust the width as needed
                          height: 150, // Adjust the height as needed
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            'Workout Weightlifting ${index + 1}\n6 Workouts for Beginner', // Add your desired text here
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      top: 10,
                      right: 10,
                      child: Icon(
                        Icons.bookmark_border,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _workoutseeall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Workout Categories",
            style: TextStyle(color: white, fontSize: 20)),
        TextButton(
          onPressed: () {},
          child: const Text("See all",
              style: TextStyle(color: yellow, fontSize: 18)),
        ),
      ],
    );
  }
}

class _searchbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search, size: 30, color: Colors.black),
          hintText: 'Search...',
          hintStyle: const TextStyle(color: Colors.white),
          filled: true,
          fillColor: Colors.grey[800],
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class _header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Discover How \nTo Shape The \nBody",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notifications,
            size: 50,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class _filterButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {},
          child: const Text(
            'Beginner',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.yellow; // Color when button is disabled
                }
                if (states.contains(MaterialState.pressed)) {
                  return Colors.yellow; // Color when button is pressed
                }
                return const Color.fromARGB(
                    255, 238, 238, 238); // Color when button is enabled
              },
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          child:
              const Text('Intermediate', style: TextStyle(color: Colors.black)),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.grey; // Color when button is disabled
                }
                if (states.contains(MaterialState.pressed)) {
                  return Colors.yellow; // Color when button is pressed
                }
                return Colors.grey; // Color when button is enabled
              },
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Advanced', style: TextStyle(color: Colors.black)),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.grey; // Color when button is disabled
                }
                if (states.contains(MaterialState.pressed)) {
                  return Colors.yellow; // Color when button is pressed
                }
                return Colors.grey; // Color when button is enabled
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _imageScroller extends StatelessWidget {
  final List<String> imageUrls = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqBHyHWLjNNsFGO-nUpWqL_tklP6ks4nkeVVtv9KHsHQ&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTydmIYEMF8OkkRffFVhew9R_-Z6S0cBNcK8rAHZg-YcwRZi6_FvVrj6Qm7G2TssathAk0&usqp=CAU',
    'https://images.unsplash.com/photo-1526506118085-60ce8714f8c5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Z3ltfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60',
    // Add more image URLs
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("New Workouts "),
        const SizedBox(height: 15), // Add spacing between text and images
        SizedBox(
          height: 150, // Adjust the height as needed
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: imageUrls.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 5), // Add some spacing between images
                child: Stack(
                  children: [
                    ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.6),
                        BlendMode.srcATop,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          imageUrls[index],
                          width: 300, // Adjust the width as needed
                          height: 150, // Adjust the height as needed
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            'Workout Weightlifting ${index + 1}\n6 Workouts for Beginner', // Add your desired text here
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      top: 10,
                      right: 10,
                      child: Icon(
                        Icons.bookmark_border,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
