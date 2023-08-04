import 'package:AdvertiseMe/providers/adlistprovider.dart';
import 'package:AdvertiseMe/screen/view_ad_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../firebase/adrepository.dart';
import '../models/admodels.dart';
import '../widgets/adcard.dart';



class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  final FocusNode _searchFocusNode = FocusNode(); // Create a FocusNode

@override
  void initState() {
    super.initState();
    Future.microtask(() => getAd());
  }

  getAd() async {
    AdRepository adRepository=AdRepository();
    List<AdModel> ads=await adRepository.fetchAds();
    Provider.of<AdListProvider>(context,listen: false).ads=ads;

  }

  @override
  void dispose() {
    super.dispose();
    _searchFocusNode.dispose(); // Dispose the FocusNode when it's no longer needed
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  Provider.of<AdListProvider>(context,listen: false).searchText=value;
                },onTapOutside: (event) {
                _searchFocusNode.unfocus();
                // print(event);
                },

                focusNode: _searchFocusNode,
                decoration: InputDecoration(
                  labelText: 'Search',
                  hintText: 'Enter your search here',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Consumer<AdListProvider>(
                builder: (context,adlistProvider,child) {
                  return AdGridView(adlistProvider.searchText,adlistProvider.ads);
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AdGridView extends StatelessWidget {
  final String searchText;

   List<AdModel> adList =[];

  AdGridView(this.searchText,this.adList);



  @override
  Widget build(BuildContext context) {
    final filteredAdList = searchText.isEmpty?adList:
         adList
        .where((adTitle) => adTitle.title.toLowerCase().contains(searchText.toLowerCase()))
        .toList();

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns in the grid
        crossAxisSpacing: 8.0, // Spacing between columns
        mainAxisSpacing: 8.0, // Spacing between rows
        mainAxisExtent: 240
      ),
      itemCount: filteredAdList.length,
      itemBuilder: (context, index) {
        return InkWell(onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAdScreen(adList[index]),));
        },child:AdCardWidget(filteredAdList[index]));
      },
    );
  }


}
