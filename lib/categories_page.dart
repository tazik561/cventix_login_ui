import 'package:cventix_login_ui/blocs/bloc/categories_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<CategoriesBloc>(context);
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[500],
          elevation: 0.0,
          brightness: Brightness.light,
          title: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
                  decoration: BoxDecoration(
                    color: Colors.green[800],
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            autocorrect: false,
                            decoration: InputDecoration(
                              fillColor: Colors.transparent,
                              filled: true,
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: "Tap to search",
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              suffixIcon: Icon(
                                Icons.cancel,
                                color: Colors.white,
                              ),
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FlatButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                onPressed: () {},
              )
            ],
          ),
          // bottomOpacity: 1,
        ),
        body: topCatList(bloc),
      ),
    );
  }
}

Widget topCatList(bloc) {
  return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
    if (state is CategoriesInitial) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (state is CategoriesLoaded) {
      var catItems = state.catItems;
      var selectedCatItems = state.selectedCatItems;
      return Column(
        children: <Widget>[
          Container(
            height: 80,
            color: Colors.green[500],
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.catItems.length,
              itemBuilder: (context, index) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        bloc.add(TriggeredItemEvent(catItems[index].id));
                        // bloc.add(SelectedCategoryEvent(catItems[index].id));
                      },
                      child: Container(
                        width: 100,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: catItems[index].selected
                              ? Colors.red
                              : Colors.green[300],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Icon(
                              catItems[index].prefixIcon,
                              color: Colors.white,
                            ),
                            Text(
                              catItems[index].title,
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16.0,
                    )
                  ],
                );
              },
            ),
          ),
          selectedCatItems == null
              ? Container()
              : detailsCatList(selectedCatItems),
        ],
      );
    }
    return Text('Something went wrong!');
  });
}

Widget detailsCatList(List<CategoryItem> selectedCatItems) {
  return Expanded(
    child: ListView.builder(
      itemCount: selectedCatItems == null ? 0 : selectedCatItems.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: Colors.black12, width: 1)),
                child: ClipRRect(
                  child: Image.asset(
                    selectedCatItems[index].image,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}
