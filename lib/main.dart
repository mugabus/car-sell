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
        title: Center(
          child: Text("Car marketplace"),
        ),
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
    return CarList(addToCart: addToCart);
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
    return Center(
      child: Column(
        children: [
          SizedBox(height: 20,),
          CircleAvatar(
            backgroundImage: AssetImage("me.png"),
          ),
          SizedBox(height: 20,),
          Text("eddy"),
          SizedBox(height: 20,),
          Text("fatakimugaruka91@gmail.com"),
          SizedBox(height: 40,),
          Text("Historizes")
        ],
      ),
    );

  }
}

class CarList extends StatelessWidget {
  final Function(Map<String, String>) addToCart;
  final List<Map<String, String>> cars = [
    {'name': 'Tesla Model S', 'price': '\$50,000', 'image': 'assets/noa.jpeg'},
    {'name': 'BMW X5', 'price': '\$40,000', 'image': 'assets/tx.jpeg'},
    {'name': 'Toyota Camry', 'price': '\$25,000', 'image': 'assets/vanette.jpeg'},
    {'name': 'Ford F-150', 'price': '\$35,000', 'image': 'assets/vaguard.jpeg'},
    {'name': 'Honda Civic', 'price': '\$20,000', 'image': 'assets/noa.jpeg'},
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
            subtitle: Text(car['price']!),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CarDetailScreen(car: car, addToCart: addToCart),
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
  final Function(Map<String, String>) addToCart;

  CarDetailScreen({required this.car, required this.addToCart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(car['name']!)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(car['image']!),
            SizedBox(height: 20),
            Text(car['name']!, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(car['price']!, style: TextStyle(fontSize: 20, color: Colors.green)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                addToCart(car);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${car['name']} added to cart!')),
                );
                Navigator.pop(context);
              },
              child: Text('Buy Now'),
            ),
          ],
        ),
      ),
    );
  }
}
