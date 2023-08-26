import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import '../../Dimension/food_items_list.dart';
import '../../Dimension/height_width.dart';
import '../../Widgets/detail_design.dart';
import '../../Widgets/large_font.dart';
import '../../Widgets/list_view_design.dart';
import 'Food/food_details.dart';
import 'Food/recommended_food.dart';

class PageBody extends StatefulWidget {
  const PageBody({
    super.key,
  });

  @override
  State<PageBody> createState() => _PageBodyState();
}

class _PageBodyState extends State<PageBody> {
  PageController pageController = PageController(viewportFraction: 0.9);
  var currentPageValue = 0.0;
  double scaleFactor = 0.2;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CarouselSlider.builder(
              itemCount: 5,
              itemBuilder: (context, index, _) {
                return buildPageItem(index);
              },
              options: CarouselOptions(
                height: Dimensions.pageView,
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 2),
                onPageChanged: (index, reason) {
                  setState(() {
                    currentPageValue = index.toDouble();
                  });
                },
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: DotsIndicator(
                dotsCount: 5,
                position: currentPageValue.toInt(),
                decorator: DotsDecorator(
                  activeColor: Colors.red,
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: Dimensions.heightFor30,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimensions.widthFor20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextSize(
                text: 'Recommended',
              ),
            ],
          ),
        ),
        SizedBox(
          height: Dimensions.heightFor20,
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 7,
            itemBuilder: ((context, index) {
              return GestureDetector(
                onTap: () {
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
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: Colors.red,
                          image: DecorationImage(
                            image: AssetImage(
                              imageList[index],
                            ),
                            fit: BoxFit.cover,
                          )),
                    ),
                    Expanded(
                      child: Container(
                          height: Dimensions.ListViewTextSize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(Dimensions.radius20),
                              bottomRight: Radius.circular(Dimensions.radius20),
                            ),
                            // color: Colors.blue[200],
                          ),
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: Dimensions.widthFor10 / 2,
                                  right: Dimensions.widthFor10 / 2),
                              child: ListDetailDesign(
                                  text: foodNames[index],
                                  text2: dishDescription[index],
                                  text3: dishStatus[index],
                                  text4: foodPrice[index]))),
                    ),
                  ]),
                ),
              );
            }))
      ],
    );
  }

  Widget buildPageItem(int index) {
    return InkWell(
      onTap: () {
        // Navigator.pushNamed(context, Routes.getPopularFood(index));
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FoodDetails(
                pageIndex: index,
              ),
            ));
      },
      child: Stack(
        children: [
          Container(
            height: Dimensions
                .pageViewContainer, //  pageViewContainer as it is static we can use them by their classname
            margin: EdgeInsets.only(
                left: Dimensions.heightFor10, right: Dimensions.heightFor10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: index.isEven ? Colors.amber : Colors.blue,
                image: DecorationImage(
                  image: AssetImage(popularImageList[index]),
                  fit: BoxFit.cover,
                )),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.widthFor20,
                  right: Dimensions.widthFor20,
                  bottom: Dimensions.heightFor30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 5,
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, 0),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(5, 0),
                  ),
                ],
                color: Colors.white,
              ),
              child: Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.heightFor15,
                      left: Dimensions.widthFor10,
                      right: Dimensions.widthFor10),
                  child: DetailDesign(
                    text: popularfoodNames[index],
                    text2: ratingDish[index],
                    text3: dishStatus[index],
                    text4: popularfoodPrice[index].toString(),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
