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
  String sortBy = 'Price: Low to High';
  List<Map<String, String>> cart = [];

  void addToCart(Map<String, String> car) {
    setState(() {
      cart.add(car);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    _screens.addAll([
      HomeContent(addToCart: addToCart),
      CartScreen(cart: cart),
      ProfileScreen(),
    ]);
  }

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
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
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
  final Function(Map<String, String>) addToCart;

  HomeContent({required this.addToCart});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CarList(addToCart: addToCart),
    );
  }
}

class CartScreen extends StatelessWidget {
  final List<Map<String, String>> cart;

  CartScreen({required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: cart.isEmpty
          ? Center(child: Text('Your cart is empty'))
          : ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          final car = cart[index];
          return ListTile(
            leading: Image.asset(car['image']!),
            title: Text(car['name']!),
            subtitle: Text(car['price']!),
          );
        },
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [
          Image.asset("assets/me.png"),
          SizedBox(height: 20,),
          Center(
            child: Text("User Name"),
          )
        ],
    );
  }
}

class CarList extends StatelessWidget {
  final Function(Map<String, String>) addToCart;
  final List<Map<String, String>> cars = [
    {'name': 'Tesla Model S', 'price': '50000', 'image': 'assets/noa.jpeg'},
    {'name': 'BMW X5', 'price': '40000', 'image': 'assets/tx.jpeg'},
    {'name': 'Toyota Camry', 'price': '25000', 'image': 'assets/vanette.jpeg'},
    {'name': 'Ford F-150', 'price': '35000', 'image': 'assets/vaguard.jpeg'},
    {'name': 'Honda Civic', 'price': '20000', 'image': 'assets/noa.jpeg'},
  ];

  CarList({required this.addToCart});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cars.length,
      itemBuilder: (context, index) {
        final car = cars[index];
        return Card(
          margin: EdgeInsets.all(10),
          child: ListTile(
            leading: Image.asset(car['image']!),
            title: Text(car['name']!),
            subtitle: Text('\$' + car['price']!),
            trailing: ElevatedButton(
              onPressed: () {
                addToCart(car);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${car['name']} added to cart!')),
                );
              },
              child: Text('Buy'),
            ),
          ),
        );
      },
    );
  }
}
