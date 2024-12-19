import 'package:flutter/material.dart';
import 'package:frontend/screens/edit_listing_screen.dart';

class MyListingsScreen extends StatefulWidget {
  const MyListingsScreen({Key? key}) : super(key: key);

  @override
  State<MyListingsScreen> createState() => _MyListingsScreenState();
}

class _MyListingsScreenState extends State<MyListingsScreen> {
  final List<Map<String, dynamic>> _listings = [
    {
      'name': 'Product 1',
      'price': 25000,
      'views': 10,
      'image': 'assets/images/products/product1.png',
      'status': 'active'
    },
    {
      'name': 'Product 2',
      'price': 15000,
      'views': 8,
      'image': 'assets/images/products/product2.png',
      'status': 'active'
    },
    {
      'name': 'Product 3',
      'price': 30000,
      'views': 15,
      'image': 'assets/images/products/product3.png',
      'status': 'sold'
    },
  ];

  void _removeListing(int index) {
    final removedItem = _listings[index];
    setState(() {
      _listings.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Listing removed'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              _listings.insert(index, removedItem);
            });
          },
        ),
      ),
    );
  }

  void _editListing(int index) {
    final item = _listings[index];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditListingScreen(
          listing: item,
          onSave: (updatedListing) {
            setState(() {
              _listings[index] = updatedListing;
            });
          },
        ),
      ),
    );
  }

  void _toggleStatus(int index) {
    setState(() {
      _listings[index]['status'] =
          _listings[index]['status'] == 'active' ? 'sold' : 'active';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Column(
          children: [
            const Text(
              'My Listings',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              '${_listings.length} items',
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: _listings.isEmpty
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
                      Icons.store_outlined,
                      size: 80,
                      color: Colors.blue.shade300,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'No Listings Yet',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Start selling by adding your first item',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/sell-item');
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add New Listing'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _listings.length,
              itemBuilder: (context, index) {
                final item = _listings[index];
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
                  onDismissed: (direction) => _removeListing(index),
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
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                              child: Image.asset(
                                item['image'],
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 12,
                              right: 12,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: item['status'] == 'active'
                                      ? Colors.green
                                      : Colors.orange,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  item['status'].toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      item['name'],
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'MWK ${item['price']}',
                                    style: TextStyle(
                                      color: Colors.green.shade700,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.remove_red_eye_outlined,
                                    size: 16,
                                    color: Colors.grey[600],
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${item['views']} views',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      onPressed: () => _editListing(index),
                                      icon: const Icon(Icons.edit_outlined),
                                      label: const Text('Edit'),
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Colors.blue,
                                        side: const BorderSide(
                                            color: Colors.blue),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: () => _toggleStatus(index),
                                      icon: Icon(
                                        item['status'] == 'active'
                                            ? Icons.check_circle_outline
                                            : Icons.refresh,
                                      ),
                                      label: Text(
                                        item['status'] == 'active'
                                            ? 'Mark as Sold'
                                            : 'Relist Item',
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            item['status'] == 'active'
                                                ? Colors.green
                                                : Colors.orange,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/sell-item');
        },
        icon: const Icon(Icons.add),
        label: const Text('New Listing'),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
