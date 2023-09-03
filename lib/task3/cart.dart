import 'package:flutter/material.dart';
import 'package:mab_lab8/store/store_screen.dart';

final List<Product> cartItems = [];


class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  CartState createState() => CartState();

  static addItemToCart(Product product) {
    cartItems.add(product);
  }
}

class CartState extends State<Cart> {
  void removeItemFromCart(Product product) {
    setState(() {
      cartItems.remove(product);
    });
  }

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text('Your cart is empty.'),
            )
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (BuildContext context, int index) {
                final product = cartItems[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Card(
                    child: Row(
                      children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(product.image,
                                fit: BoxFit.fitHeight),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                '\$${product.price.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => removeItemFromCart(product),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class Product {
  final int id;
  final String title;
  final double price;
  final String image;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
  });
}
