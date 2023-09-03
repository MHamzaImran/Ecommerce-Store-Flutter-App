import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'cart.dart';

class Details extends StatefulWidget {
  final int productId;

  const Details({super.key, required this.productId});

  @override
  DetailsState createState() => DetailsState();
}

class DetailsState extends State<Details> {
  late Future<Map<String, dynamic>> _productDetails;

  @override
  void initState() {
    super.initState();
    _productDetails = _fetchProductDetails(widget.productId);
  }

  Future<Map<String, dynamic>> _fetchProductDetails(int productId) async {
    final response = await http
        .get(Uri.parse('https://fakestoreapi.com/products/$productId'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load product details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: [
          // search
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Cart(),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder<Map<String, dynamic>>(
        future: _productDetails,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final product = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16,),
                Image.network(
                  product['image'],
                  fit: BoxFit.fitHeight  ,
                  height: 300.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['title'],
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        '\$${product['price']}',
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        product['description'],
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        children: [
                          const Text(
                            'Category: ',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            product['category'],
                            style: const TextStyle(fontSize: 16.0,color: Colors.blue),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton( 
                          onPressed: () {
                            // TODO: Implement add to cart functionality
                            Product productDetails = Product(
                              id: product['id'],
                              title: product['title'],
                              price: product['price'].toDouble(),
                              // description: product['description'],
                              // category: product['category'],
                              image: product['image'],
                              // rating: product['rating'],
                            );
                            // CartScreenState().addItemToCart(productDetails);
                            cartItems.add(productDetails);
                          },
                          child: const Text('Add to Cart'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Failed to load product details'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
