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

class HomeScreen extends StatelessWidget {
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
          Expanded(
            child: ListView(
              children: [
                CategorySection(),
                CarList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategorySection extends StatelessWidget {
  final List<String> categories = ['All', 'New', 'Used', 'SUV', 'Sedan', 'Truck'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Chip(
              label: Text(categories[index]),
              backgroundColor: Colors.grey.shade200,
            ),
          );
        },
      ),
    );
  }
}

class CarList extends StatelessWidget {
  final List<Map<String, String>> cars = [
    {'name': 'Tesla Model S', 'price': '\$50,000', 'image': 'assets/noa.jpeg'},
    {'name': 'BMW X5', 'price': '\$40,000', 'image': 'assets/tx.jpeg'},
    {'name': 'Toyota Camry', 'price': '\$25,000', 'image': 'assets/vanette.jpeg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: cars.map((car) {
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
      }).toList(),
    );
  }
}
