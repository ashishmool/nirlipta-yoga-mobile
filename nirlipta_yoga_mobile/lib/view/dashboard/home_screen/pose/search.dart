import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> allItems = [
    'Downward Dog',
    'Child’s Pose',
    'Tree Pose',
    'Warrior I',
    'Warrior II',
    'Cobra Pose',
    'Lotus Pose',
    'Bridge Pose',
  ];
  List<String> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = allItems; // Initially show all items
  }

  void _filterSearchResults(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredItems = allItems;
      });
    } else {
      setState(() {
        filteredItems = allItems
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _filterSearchResults,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.grey),
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                              filteredItems = allItems;
                            });
                          },
                        )
                      : null,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Search Results
            Expanded(
              child: filteredItems.isEmpty
                  ? const Center(
                      child: Text(
                        'No results found',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.deepPurple,
                            child: Text(
                              filteredItems[index][0].toUpperCase(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(
                            filteredItems[index],
                            style: const TextStyle(fontSize: 16),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
