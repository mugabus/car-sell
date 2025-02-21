import 'package:flutter/material.dart';

void main() {
  runApp(CarSellingApp());
}

class CarSellingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All';

  void updateCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Marketplace'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search cars...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          CategorySection(
            selectedCategory: selectedCategory,
            onCategorySelected: updateCategory,
          ),
          Expanded(
            child: CarList(selectedCategory: selectedCategory),
          ),
        ],
      ),
    );
  }
}

class CategorySection extends StatelessWidget {
  final List<String> categories = ['All', 'New', 'Used', 'SUV', 'Sedan', 'Truck'];
  final String selectedCategory;
  final Function(String) onCategorySelected;

  CategorySection({required this.selectedCategory, required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onCategorySelected(categories[index]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Chip(
                label: Text(categories[index]),
                backgroundColor: categories[index] == selectedCategory ? Colors.blueAccent : Colors.grey.shade200,
                labelStyle: TextStyle(color: categories[index] == selectedCategory ? Colors.white : Colors.black),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CarList extends StatelessWidget {
  final String selectedCategory;
  final List<Map<String, String>> cars = [
    {'name': 'Tesla Model S', 'price': '\$50,000', 'image': 'assets/noa.jpeg', 'category': 'New'},
    {'name': 'BMW X5', 'price': '\$40,000', 'image': 'assets/tx.jpeg', 'category': 'SUV'},
    {'name': 'Toyota Camry', 'price': '\$25,000', 'image': 'assets/vaguard.jpeg', 'category': 'Sedan'},
    {'name': 'Ford F-150', 'price': '\$35,000', 'image': 'assets/vanette.jpeg', 'category': 'Truck'},
    {'name': 'Honda Civic', 'price': '\$20,000', 'image': 'assets/noa.jpeg', 'category': 'Used'},
  ];

  CarList({required this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredCars = selectedCategory == 'All'
        ? cars
        : cars.where((car) => car['category'] == selectedCategory).toList();

    return ListView.builder(
      itemCount: filteredCars.length,
      itemBuilder: (context, index) {
        final car = filteredCars[index];
        return Card(
          margin: EdgeInsets.all(10),
          child: ListTile(
            leading: Image.asset(car['image']!),
            title: Text(car['name']!),
            subtitle: Text(car['price']!),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
        );
      },
    );
  }
}
