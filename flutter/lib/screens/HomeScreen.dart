
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _price = "";
  String? _areaType = "";
  String? _location = "";
  String _availability = "";
  bool _avail = false;

  final TextEditingController _bathController = TextEditingController();
  final TextEditingController _balController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _bhkController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    _locations.sort((a,b) => a.compareTo(b));
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset("images/app_bar_logo.png"),
        ),
        title: const Text('Worth'),
          actions: (MediaQuery.of(context).size.width > 500)? <Widget>[
            (kIsWeb)?TextButton(onPressed: () {
              _linkLaunch('https://firebasestorage.googleapis.com/v0/b/worth-all.appspot.com/o/worth.apk?alt=media&token=8daaf2b4-e86a-46b2-a797-de40a37d554c');
            }, child: Row(
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.android, color: Colors.white,),
                ),
                Text(
                  'DOWNLOAD APK',
                  style: TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold),
                )
              ],)
            ) :  Container(),
            TextButton(onPressed: () {
              FirebaseAuth.instance.signOut();
              }, child: Row(
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.logout,  color: Colors.white,),
                ),
                Text(
                  'SIGN OUT',
                  style: TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold),
                )
              ],)
            )
          ] : <Widget>[
            (kIsWeb)? IconButton(onPressed: () {
              _linkLaunch('https://firebasestorage.googleapis.com/v0/b/worth-all.appspot.com/o/worth.apk?alt=media&token=8daaf2b4-e86a-46b2-a797-de40a37d554c');
              }, icon: const Icon(Icons.android)) : Container(),
            IconButton(onPressed: () {FirebaseAuth.instance.signOut();}, icon: const Icon(Icons.logout)),
          ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 54.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(24.0),),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16.0),
                constraints: const BoxConstraints(minWidth: 100, maxWidth: 640),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _bathController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                          decoration: const InputDecoration(
                          icon: Icon(Icons.bathroom),
                          hintText: 'Enter total number of bathrooms',
                          labelText: 'Bathroom',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(2.0)),
                          )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _balController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        decoration: const InputDecoration(
                            icon: Icon(Icons.balcony),
                            hintText: 'Enter total number of balcony',
                            labelText: 'Balcony',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(2.0)),
                            )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _bhkController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        decoration: const InputDecoration(
                            icon: Icon(Icons.bed),
                            hintText: 'Enter BHK (Bedroom, Hall, and Kitchen) number',
                            labelText: 'BHK',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(2.0)),
                            )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _sizeController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                        ],
                        decoration: const InputDecoration(
                            icon: Icon(Icons.square_foot),
                            hintText: 'Enter total area in square foot',
                            labelText: 'Area (in Square Foot)',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(2.0)),
                            )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _priceController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                        ],
                        decoration: const InputDecoration(
                            icon: Icon(Icons.attach_money),
                            hintText: 'Enter estimated price per square foot',
                            labelText: 'Price Per Square Foot',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(2.0)),
                            )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: Text('Area Type', style: TextStyle(color: Colors.grey),),
                          ),
                          DropdownSearch<String>(
                            mode: Mode.MENU,
                            showSearchBox: false,
                            items: _areaTypes,
                            onChanged: (value) => {
                              _areaType = value
                            },
                          )
                        ],
                      )
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text('Location', style: TextStyle(color: Colors.grey),),
                            ),
                            DropdownSearch<String>(
                              mode: Mode.BOTTOM_SHEET,
                              showSearchBox: true,
                              items: _locations,
                              onChanged: (value) => {
                                _location = value
                              },
                            )
                          ],
                        )
                    ),
                    CheckboxListTile(
                      title: const Text("Ready to Move", style: TextStyle(color: Colors.grey),),
                      value: _avail,
                      onChanged: (value) {
                        if(value == true){
                          _availability = "Ready To Move";
                          setState(() {
                            _avail = true;
                          });
                        } else {
                          _availability = "";
                          setState(() {
                            _avail = false;
                          });
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 24.0, bottom: 16.0),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(24.0),),
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          color: Colors.greenAccent,
                          child: Text('Predicted Price: $_price', style: const TextStyle(fontWeight: FontWeight.bold),),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => checkAndPredict(),
        child: const Icon(Icons.search_rounded),
      ),
    );
  }

  void _linkLaunch(String s) async {
    if (await canLaunchUrlString(s)) {
    await launchUrlString(s);
    }
  }

  void _ts(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
    );
  }

  final List<String> _locations = [
    'Mahadevpura',
    'Tumkur Road',
    'Horamavu Banaswadi',
    'Domlur',
    'BTM 2nd Stage',
    'Hebbal Kempapura',
    'Hosur Road',
    'Vidyaranyapura',
    'Horamavu Agara',
    'Kalena Agrahara',
    'Subramanyapura',
    'Bhoganhalli',
    'Doddathoguru',
    'Kengeri Satellite Town',
    'Jalahalli',
    'CV Raman Nagar',
    'Kudlu',
    'Anekal',
    'Ananth Nagar',
    'TC Palaya',
    '5th Phase JP Nagar',
    'Nagarbhavi',
    'Lakshminarayana Pura',
    'Devanahalli',
    'Dodda Nekkundi',
    'Attibele',
    'Kanakapura',
    'Frazer Town',
    'Yelahanka New Town',
    'Jigani',
    'Ambedkar Nagar',
    'Kadugodi',
    'Talaghattapura',
    'Thigalarapalya',
    'Mysore Road',
    'Kudlu Gate',
    'Old Madras Road',
    'Panathur',
    'Rachenahalli',
    'Bommasandra',
    'Green Glen Layout',
    'Balagere',
    'Vijayanagar',
    'Hosa Road',
    'Kengeri',
    'Brookefield',
    'Sahakara Nagar',
    'Old Airport Road',
    'Indira Nagar',
    'Vittasandra',
    'Bisuvanahalli',
    'Channasandra',
    'JP Nagar',
    '8th Phase JP Nagar',
    'Gottigere',
    'Yeshwanthpur',
    'Hegde Nagar',
    'Malleshwaram',
    'Hoodi',
    'Hulimavu',
    'Budigere',
    'Ramagondanahalli',
    'Kundalahalli',
    'Kaggadasapura',
    'Koramangala',
    'Chandapura',
    'Ramamurthy Nagar',
    'Hennur',
    'HSR Layout',
    'Varthur',
    'Jakkur',
    'Electronics City Phase 1',
    'Akshaya Nagar',
    'Harlur',
    'Hormavu',
    'Kothanur',
    'Banashankari',
    'Begur Road',
    'Kasavanhalli',
    'Bellandur',
    'Rajaji Nagar',
    'Sarjapur',
    'KR Puram',
    'Kanakpura Road',
    '7th Phase JP Nagar',
    'Yelahanka',
    'Hebbal',
    'Electronic City Phase II',
    'Thanisandra',
    'Uttarahalli',
    'Bannerghatta Road',
    'Hennur Road',
    'Haralur Road',
    'Raja Rajeshwari Nagar',
    'Marathahalli',
    'Electronic City',
    'Sarjapur  Road',
    'Whitefield'
  ];

  final List<String> _areaTypes = [
    'Super built-up Area',
    'Built-up Area',
    'Plot Area'
  ];

  void checkAndPredict() async {
    if(_areaType != null){
      if(_location != null){
        String bal = _balController.text;
        String bath = _bathController.text;
        String bhk = _bhkController.text;
        String size = _sizeController.text;
        String price = _priceController.text;
        String areaType = _areaType!;
        String location = _location!;

        if(bal.isEmpty || bath.isEmpty || bhk.isEmpty || size.isEmpty || price.isEmpty || areaType.isEmpty || location.isEmpty){
          _ts('Please enter the complete details.');
        } else {
          final queryParameters = {
            'bathrooms': bath,
            'balcony': bal,
            'total_sqft_int': size,
            'bhk': bhk,
            'price_per_sqft': price,
            'area_type': areaType,
            'availability': _availability,
            'location': location
          };
          final uri = Uri.https('my-sweet.herokuapp.com', '/predict', queryParameters);
          final response = await http.post(uri, headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded"
          },encoding: Encoding.getByName("utf-8"));
          if(response.statusCode == 200){
            String p = jsonDecode(response.body)['price'].toString();
            if(p.contains('.') && p.indexOf('.') + 2 < p.length){
              p = p.substring(0, p.indexOf('.') + 2);
            }
            setState(() {
              _price = "$p L";
            });
          }
        }
      } else {
        _ts('Please select the Location first.');
      }
    } else {
      _ts('Please select the Area Type first.');
    }
  }

}