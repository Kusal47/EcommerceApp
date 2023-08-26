import 'package:flutter/material.dart';
import '../../Dimension/food_items_list.dart';
import '../../Dimension/height_width.dart';
import 'Food/recommended_food.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchQuery = '';
  List<String> searchResults = [];
  TextEditingController _searchController = TextEditingController();

  void searchItems(String query) {
    setState(() {
      searchQuery = query;
      searchResults = []; // Clear previous search results

      // Search in each list and add matching items to searchResults
      searchInList(popularfoodNames, query);
      searchInList(foodNames, query);
      searchInList(breakfastNames, query);
      searchInList(snacksNames, query);
      searchInList(dinnerNames, query);
      searchInList(drinkNames, query);
      searchInList(teaNames, query);
      searchInList(coffeeNames, query);
      searchInList(dessertNames, query);
    });
  }

  void searchInList(List<String> itemList, String query) {
    query = query
        .toLowerCase(); // Convert search query to lowercase for case-insensitive search

    for (int i = 0; i < itemList.length; i++) {
      String itemName = itemList[i]
          .toLowerCase(); // Convert item name to lowercase for case-insensitive comparison

      if (itemName.contains(query) && !searchResults.contains(itemList[i])) {
        searchResults.add(itemList[i]);
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Search Page'),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.home_filled),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _searchController,
              onChanged: (value) {
                searchItems(value);
              },
              decoration: InputDecoration(
                labelText: 'Search',
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: searchResults.isEmpty
                  ? Center(
                      child: Text(' Search for food items'),
                    )
                  : searchQuery.isNotEmpty
                      ? ListView.builder(
                          itemCount: searchResults.length,
                          itemBuilder: (context, index) {
                            String result = searchResults[index];
                            // Fetch details based on the search result
                            String foodName = '';
                            double foodPrices = 0;
                            String image = '';

                            if (popularfoodNames.contains(result)) {
                              int idx = popularfoodNames.indexOf(result);
                              if (popularfoodNames[idx] == result) {
                                foodName = popularfoodNames[idx];
                                foodPrices = popularfoodPrice[idx];
                                image = popularImageList[idx];
                              }
                            } else if (foodNames.contains(result)) {
                              int idx = foodNames.indexOf(result);
                              if (foodNames[idx] == result) {
                                foodName = foodNames[idx];
                                foodPrices = foodPrice[idx];
                                image = imageList[idx];
                              }
                            } else if (breakfastNames.contains(result)) {
                              int idx = breakfastNames.indexOf(result);
                              if (breakfastNames[idx] == result) {
                                foodName = breakfastNames[idx];
                                foodPrices = breakfastPrice[idx];
                                image = breakfastImages[idx];
                              }
                            } else if (snacksNames.contains(result)) {
                              int idx = snacksNames.indexOf(result);
                              if (snacksNames[idx] == result) {
                                foodName = snacksNames[idx];
                                foodPrices = snacksPrice[idx];
                                image = snacksImages[idx];
                              }
                            } else if (dinnerNames.contains(result)) {
                              int idx = dinnerNames.indexOf(result);
                              if (dinnerNames[idx] == result) {
                                foodName = dinnerNames[idx];
                                foodPrices = dinnerPrice[idx];
                                image = dinnerImages[idx];
                              }
                            } else if (drinkNames.contains(result)) {
                              int idx = drinkNames.indexOf(result);
                              if (drinkNames[idx] == result) {
                                foodName = drinkNames[idx];
                                foodPrices = drinkPrice[idx];
                                image = drinkImages[idx];
                              }
                            } else if (teaNames.contains(result)) {
                              int idx = teaNames.indexOf(result);
                              if (teaNames[idx] == result) {
                                foodName = teaNames[idx];
                                foodPrices = teaPrice[idx];
                                image = TeaImages[idx];
                              }
                            } else if (coffeeNames.contains(result)) {
                              int idx = coffeeNames.indexOf(result);
                              if (coffeeNames[idx] == result) {
                                foodName = coffeeNames[idx];
                                foodPrices = coffeePrice[idx];
                                image = CoffeeImages[idx];
                              }
                            } else if (dessertNames.contains(result)) {
                              int idx = dessertNames.indexOf(result);
                              if (dessertNames[idx] == result) {
                                foodName = dessertNames[idx];
                                foodPrices = dessertPrice[idx];
                                image = dessertImages[idx];
                              }
                            }

                            return InkWell(
                              onTap: () {
                                // Navigate to the details page of the tapped food item
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RecommendedFood(
                                        pageIndex: index,
                                      ),
                                    ));
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: Dimensions.widthFor10,
                                    right: Dimensions.widthFor10,
                                    bottom: Dimensions.heightFor10),
                                child: Row(children: [
                                  Container(
                                    width: Dimensions.ListViewImage,
                                    height: Dimensions.ListViewImage,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius20),
                                        color: Colors.red,
                                        image: DecorationImage(
                                          image: AssetImage(
                                            image,
                                          ),
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: Dimensions.ListViewTextSize,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(
                                              Dimensions.radius20),
                                          bottomRight: Radius.circular(
                                              Dimensions.radius20),
                                        ),
                                        // color: Colors.blue[200],
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: Dimensions.widthFor10 / 2,
                                            right: Dimensions.widthFor10 / 2),
                                        child: ListTile(
                                            contentPadding: EdgeInsets.all(
                                                Dimensions.heightFor10),
                                            title: Text(foodName,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        Dimensions.font24)),
                                            subtitle: Text('Price: $foodPrices',
                                                style: TextStyle(
                                                    fontSize:
                                                        Dimensions.font20))),
                                      ),
                                    ),
                                  )
                                ]),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Text('Searched food items will appear here'),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
