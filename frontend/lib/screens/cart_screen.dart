import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<Map<String, dynamic>> _cartItems = [
    {
      'name': 'Product 1',
      'price': 25000,
      'quantity': 1,
      'image': 'assets/images/products/product1.png'
    },
    {
      'name': 'Product 2',
      'price': 15000,
      'quantity': 2,
      'image': 'assets/images/products/product2.png'
    },
    {
      'name': 'Product 3',
      'price': 30000,
      'quantity': 1,
      'image': 'assets/images/products/product3.png'
    },
  ];

  String? _selectedPaymentMethod;
  final List<String> _paymentMethods = ['TNM Mpamba', 'Airtel Money', 'Bank'];

  double get _totalPrice {
    return _cartItems.fold(
        0, (sum, item) => sum + (item['price'] * item['quantity']));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Column(
          children: [
            const Text(
              'Shopping Cart',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '${_cartItems.length} items',
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: _cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      size: 80,
                      color: Colors.blue.shade300,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Your cart is empty',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Looks like you haven\'t added\nany items to your cart yet',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 48, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Start Shopping',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _cartItems.length,
                    itemBuilder: (context, index) {
                      final item = _cartItems[index];
                      return Dismissible(
                        key: Key(item['name']),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                            color: Colors.red.shade100,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            Icons.delete_outline,
                            color: Colors.red.shade700,
                            size: 28,
                          ),
                        ),
                        onDismissed: (direction) {
                          setState(() {
                            _cartItems.removeAt(index);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('${item['name']} removed from cart'),
                              action: SnackBarAction(
                                label: 'UNDO',
                                onPressed: () {
                                  setState(() {
                                    _cartItems.insert(index, item);
                                  });
                                },
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: AssetImage(item['image']),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['name'],
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'MWK ${item['price']}',
                                        style: TextStyle(
                                          color: Colors.green.shade700,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade50,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.remove),
                                              onPressed: () {
                                                setState(() {
                                                  if (item['quantity'] > 1) {
                                                    item['quantity']--;
                                                  }
                                                });
                                              },
                                              iconSize: 20,
                                            ),
                                            Text(
                                              '${item['quantity']}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.add),
                                              onPressed: () {
                                                setState(() {
                                                  item['quantity']++;
                                                });
                                              },
                                              iconSize: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 20,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total:',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'MWK $_totalPrice',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.green.shade700,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              hint: const Text('Select Payment Method'),
                              value: _selectedPaymentMethod,
                              items: _paymentMethods.map((String method) {
                                return DropdownMenuItem<String>(
                                  value: method,
                                  child: Row(
                                    children: [
                                      Icon(
                                        method == 'Bank'
                                            ? Icons.account_balance
                                            : Icons.phone_android,
                                        color: Colors.blue,
                                      ),
                                      const SizedBox(width: 12),
                                      Text(method),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  _selectedPaymentMethod = value;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_selectedPaymentMethod != null) {
                                _showPinDialog();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Please select a payment method'),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Proceed to Payment',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> _showPinDialog() async {
    final pinController = TextEditingController();
    bool obscureText = true;

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Column(
                children: [
                  Icon(
                    _selectedPaymentMethod == 'Bank'
                        ? Icons.account_balance
                        : Icons.phone_android,
                    size: 40,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Enter $_selectedPaymentMethod PIN',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Amount: MWK $_totalPrice',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: pinController,
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    obscureText: obscureText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24, letterSpacing: 8),
                    decoration: InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: '• • • •',
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscureText ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.blue, Colors.blueAccent],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextButton(
                    onPressed: () {
                      if (pinController.text.length == 4) {
                        Navigator.pop(context);
                        // Simulate payment processing
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );

                        // Simulate API call
                        Future.delayed(const Duration(seconds: 2), () {
                          Navigator.pop(context); // Close loading dialog
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Payment successful!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          // Clear cart or navigate to success screen
                          setState(() {
                            _cartItems.clear();
                          });
                        });
                      }
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Confirm Payment'),
                  ),
                ),
                const SizedBox(width: 8),
              ],
            );
          },
        );
      },
    );
  }
}
