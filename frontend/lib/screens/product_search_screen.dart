import 'package:flutter/material.dart';

class ProductSearchScreen extends StatefulWidget {
  const ProductSearchScreen({Key? key}) : super(key: key);

  @override
  State<ProductSearchScreen> createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  RangeValues _currentRangeValues = const RangeValues(0, 100000);
  String? _selectedDistrict;
  String? _selectedCategory;
  bool _showFilters = false;

  final List<String> _categories = [
    'All Categories',
    'Electronics',
    'Fashion',
    'Home',
    'Books',
    'Sports',
  ];

  final List<String> _districts = [
    'All Districts',
    'Lilongwe',
    'Blantyre',
    'Mzuzu',
    'Zomba',
    'Mangochi',
    'Salima',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Products'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // Search Bar with Filter Toggle
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  offset: const Offset(0, 2),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search products...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        color:
                            _showFilters ? Colors.blue : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.tune,
                          color: _showFilters
                              ? Colors.white
                              : Colors.grey.shade700,
                        ),
                        onPressed: () {
                          setState(() {
                            _showFilters = !_showFilters;
                          });
                        },
                      ),
                    ),
                  ],
                ),

                // Collapsible Filters
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: _showFilters ? 320 : 0,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        // Category Filter
                        DropdownButtonFormField<String>(
                          value: _selectedCategory,
                          decoration: InputDecoration(
                            labelText: 'Category',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade50,
                          ),
                          items: _categories
                              .map((category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(category),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                        ),
                        const SizedBox(height: 16),

                        // Location Filter
                        DropdownButtonFormField<String>(
                          value: _selectedDistrict,
                          decoration: InputDecoration(
                            labelText: 'Location',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade50,
                          ),
                          items: _districts
                              .map((district) => DropdownMenuItem(
                                    value: district,
                                    child: Text(district),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedDistrict = value;
                            });
                          },
                        ),
                        const SizedBox(height: 16),

                        // Price Range Filter
                        const Text(
                          'Price Range (MWK)',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        RangeSlider(
                          values: _currentRangeValues,
                          min: 0,
                          max: 100000,
                          divisions: 100,
                          labels: RangeLabels(
                            _currentRangeValues.start.round().toString(),
                            _currentRangeValues.end.round().toString(),
                          ),
                          onChanged: (RangeValues values) {
                            setState(() {
                              _currentRangeValues = values;
                            });
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'MWK ${_currentRangeValues.start.round()}',
                              style: TextStyle(color: Colors.grey.shade700),
                            ),
                            Text(
                              'MWK ${_currentRangeValues.end.round()}',
                              style: TextStyle(color: Colors.grey.shade700),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Apply Filters Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // Apply filters and close filter panel
                              setState(() {
                                _showFilters = false;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Apply Filters'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Search Results Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 10, // Replace with actual search results count
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        child: Image.asset(
                          'assets/images/products/product${(index % 5) + 1}.png',
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Product ${index + 1}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'MWK ${(index + 1) * 10000}',
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    'Lilongwe',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
