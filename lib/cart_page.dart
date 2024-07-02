import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:shopping_app/global_variables.dart';
import 'package:shopping_app/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>().cart;
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Cart")),
      ),
      body: ListView.builder(
          itemCount: cart.length,
          itemBuilder: (context, index) {
            final cartItem = cart[index];

            return ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(cartItem['imageUrl'] as String),
                radius: 30,
              ),
              trailing: IconButton(
                onPressed: () {
                  showDialog(
                    barrierDismissible:
                        true, // touching outside Dialog will exit dialog box
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          "Delete Product",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        content: const Text(
                          "Are you sure you want to Delete this from Cart ?",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Provider.of<CartProvider>(context,
                                        listen: false)
                                    .removeProduct(cartItem);
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                "Yes",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              "No",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
              title: Text(
                cartItem['title'].toString(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              subtitle: Text('Size: ${cartItem['size']}'),
            );
          }),
    );
  }
}
