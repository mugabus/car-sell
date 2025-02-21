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
  int _selectedIndex = 0;
  String selectedCategory = 'All';

  void updateCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _screens = [
    HomeContent(),
    CardScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Marketplace'),
        backgroundColor: Colors.blueAccent,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Card'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
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
          child: CarList(selectedCategory: 'All'),
        ),
      ],
    );
  }
}

class CardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Card Screen'),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Profile Screen'),
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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CarDetailScreen(car: car),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class CarDetailScreen extends StatelessWidget {
  final Map<String, String> car;

  CarDetailScreen({required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(car['name']!),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(car['image']!),
            ),
            SizedBox(height: 20),
            Text(
              car['name']!,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              car['price']!,
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
            SizedBox(height: 20),
            Text(
              'Category: ${car['category']!}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Car purchased successfully!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: Text('Buy Now'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
