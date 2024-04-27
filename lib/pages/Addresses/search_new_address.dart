// ignore_for_file: depend_on_referenced_packages, avoid_dynamic_calls, use_build_context_synchronously, lines_longer_than_80_chars, inference_failure_on_function_invocation
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:neighbour_app/config/environments.dart';
import 'package:neighbour_app/pages/AddAddress/apis/map_apis.dart';
import 'package:neighbour_app/pages/Addresses/add_new_address.dart';
import 'package:neighbour_app/pages/Addresses/widget/search_card.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/svg_constants.dart';
import 'package:neighbour_app/widgets/app_input.dart';
import 'package:neighbour_app/widgets/backbutton_appbar.dart';
import 'package:uuid/uuid.dart';

class SearchNewAddress extends StatefulWidget {
  const SearchNewAddress({
    required this.isFromJobPage,
    super.key,
  });

  final String isFromJobPage;
  static const routeName = '/search-address';

  @override
  State<SearchNewAddress> createState() => _SearchNewAddressState();
}

class _SearchNewAddressState extends State<SearchNewAddress> {
  final TextEditingController searchController = TextEditingController();
  final String mapApiKey = '${dotenv.env[Environments.mapApiKey]}';
  List<dynamic> placeLists = [];
  bool isSearchEmpty = true;
  dynamic sessionToken;
  final uuid = const Uuid();
  bool isLoading = false;
  int selectedLoadingIndex = 0;

  @override
  void initState() {
    searchController.addListener(onChangeText);
    super.initState();
  }

  void onChangeText() {
    if (sessionToken == null) {
      setState(() {
        sessionToken = uuid.v4();
      });
    }
    getSuggestion(searchController.text);
  }

  Future<void> getSuggestion(String input) async {
    try {
      const baseURL =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      final request =
          '$baseURL?input=$input&key=$mapApiKey&sessiontoken=$sessionToken';
      final response = await http.get(Uri.parse(request));
      if (response.statusCode == 200) {
        setState(() {
          placeLists =
              jsonDecode(response.body)['predictions'] as List<dynamic>;
        });
      }
    } catch (e) {
      debugPrint('$e Failed to load data ');
    }
  }

  Future<void> userAddress({required String userSelectedAddress}) async {
    final data = await getDataFromPlaces(userSelectedAddress);
    if (data!['error'] == 'error') {
      setState(() {
        isLoading = false;
      });
      keyboardDismissle(context: context);
      showAddressErrorBottomSheet(context: context);
    } else {
      final query = Uri(
        queryParameters: {
          'street': data['address']['street'],
          'city': data['address']['city'],
          'state': data['address']['state'],
          'zipcode': data['address']['zipcode'],
          'country': data['address']['country'],
          'lat': data['latitude'],
          'long': data['longitude'],
          'onEdit': 'false',
          'onCurrent': 'false',
          'isFromJobPage': widget.isFromJobPage == 'true' ? 'true' : 'false',
        },
      ).query;
      setState(() {
        isLoading = false;
      });
      keyboardDismissle(context: context);
      await context.push(
        '${AddNewAddress.routeName}?$query',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backButtonAppbar(
        context,
        icon: const Icon(Icons.arrow_back),
        text: 'Addresses',
        backgroundColor: Colors.white,
        elevation: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppInput(
            onEnventSumbit: (value) {
              showAddressErrorBottomSheet(context: context);
            },
            isAutoFocus: true,
            onChanged: (text) {
              setState(() {
                isSearchEmpty = text.trim().isEmpty;
              });
            },
            controller: searchController,
            placeHolder: 'Search Places',
            prefixIcon: const Icon(
              Icons.search,
              color: Color(0xFF8D99AE),
            ),
            postfixIcon: InkWell(
              onTap: () {
                searchController.clear();
                setState(() {
                  isSearchEmpty = true;
                });
              },
              child: Padding(
                padding: EdgeInsets.all(
                  SizeHelper.moderateScale(15),
                ),
                child: SvgPicture.asset(
                  isSearchEmpty ? crossIcon : activeCrossIcon,
                ),
              ),
            ),
            bottomMargin: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: placeLists.length,
              itemBuilder: (context, index) {
                final state = getCountryAndState(
                  placeLists[index]['structured_formatting']
                              ['secondary_text'] !=
                          null
                      ? placeLists[index]['structured_formatting']
                              ['secondary_text']
                          .toString()
                      : '',
                );
                final description = placeLists[index]['description'].toString();
                return SearchCard(
                  isLoading: isLoading && selectedLoadingIndex == index,
                  onTap: () async {
                    setState(() {
                      isLoading = true;
                      selectedLoadingIndex = index;
                    });
                    await userAddress(
                      userSelectedAddress:
                          placeLists[index]['place_id'].toString(),
                    );
                  },
                  text: description,
                  state: state,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
