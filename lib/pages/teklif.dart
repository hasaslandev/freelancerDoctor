import 'package:flutter/material.dart';
import 'package:randevu/api/CityApi.dart';
import 'package:uuid/uuid.dart';
import '../models/telifModel.dart';
import 'dart:convert';
import '../services/teklifmodel/firestore_teklifmodel_servis.dart';

import 'package:http/http.dart' as http;


class Teklif extends StatefulWidget {
  @override
  _TeklifState createState() => _TeklifState();
}

class _TeklifState extends State<Teklif> {
  final FirestoreTeklifmodelService _firestoreService =
  FirestoreTeklifmodelService();
  String? _selectedCity;


  List<String> _listOfCities = [];

  @override
  void initState() {
    super.initState();
    getCitiesFromAPI();
  }
  Future<Map<String,dynamic>> fetchHastaneler() async {
    Map<String, List<String>> hastaneler = {};

    try {
      http.Response response = await http.get(Uri.parse('https://data.ibb.gov.tr/tr/api/3/action/datastore_search_sql?sql=SELECT "ILCE_UAVT", "ILCE_ADI", "ADI" FROM "f2154883-68e3-41dc-b2be-a6c2eb721c9e" WHERE "ILCE_ADI" = \'$_selectedCity\''));

      if (response.statusCode == 200) {
        print(response.body);
      } else {
        throw Exception('API isteği başarısız oldu. Hata kodu: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('API isteği başarısız oldu. Hata: $error');
    }

    return hastaneler;
  }

  void getCitiesFromAPI() async {
    try {
      List<String> cities = await fetchIlceAdlari();

      // Convert city names to UTF-8 encoding
      List<String> utf8Cities = cities.map((city) => utf8.decode(city.runes.toList())).toList();

      setState(() {
        _listOfCities = utf8Cities;
      });
    } catch (error) {
      print('API isteği başarısız oldu. Hata: $error');
    }
  }

  final List<String> _listOfHospital = [
    "Hastane 1",
    "Hastane 2",
    "Hastane 3",
    "Hastane 4",
    "Hastane 5",
  ];

  final List<String> _listOfDiseases = [
    "Hastalık 1",
    "Hastalık 2",
    "Hastalık 3",
    "Hastalık 4",
    "Hastalık 5",
  ];

  String? _selectedHospital;
  String? _selectedDisease;
  bool _isMale = true;

  TextEditingController _adSoyadController = TextEditingController();
  TextEditingController _iletisimController = TextEditingController();
  TextEditingController _fiyatController = TextEditingController();
  TextEditingController _hastalikController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _adSoyadController.dispose();
    _iletisimController.dispose();
    _fiyatController.dispose();
    _hastalikController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teklif Formu"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            Text(
              "Kişisel Bilgiler",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              controller: _adSoyadController,
              decoration: InputDecoration(
                labelText: "Ad Soyad",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Lütfen ad soyad girin.";
                }
                return null;
              },
            ),
            SizedBox(height: 8.0),
            TextFormField(
              controller: _iletisimController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Telefon",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Lütfen telefon girin.";
                }
                return null;
              },
            ),
            SizedBox(height: 8.0),
            TextFormField(
              controller: _fiyatController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Fiyat",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Lütfen Fiyat girin.";
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            Text(
              "Şehir",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 8.0),
            //...

            DropdownButtonFormField<String>(
              value: _selectedCity,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCity = newValue;
                });
                fetchHastaneler();
              },
              items: _listOfCities.map((String city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: Text(city),
                );
              }).toList(),
              //...
            ),

//...


            SizedBox(height: 16.0),
            Text(
              "Hastane",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 8.0),
            DropdownButtonFormField<String>(
              value: _selectedHospital,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedHospital = newValue;
                });
              },
              items: _listOfHospital.map((String hospital) {
                return DropdownMenuItem<String>(
                  value: hospital,
                  child: Text(hospital),
                );
              }).toList(),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Lütfen hastane seçin.";
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            Text(
              "Hastalık",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 8.0),
            DropdownButtonFormField<String>(
              value: _selectedDisease,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedDisease = newValue;
                });
              },
              items: _listOfDiseases.map((String disease) {
                return DropdownMenuItem<String>(
                  value: disease,
                  child: Text(disease),
                );
              }).toList(),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Lütfen hastalık seçin.";
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            Text(
              "Cinsiyet",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    title: Text("Erkek"),
                    value: true,
                    groupValue: _isMale,
                    onChanged: (bool? value) {
                      setState(() {
                        _isMale = value!;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title: Text("Kadın"),
                    value: false,
                    groupValue: _isMale,
                    onChanged: (bool? value) {
                      setState(() {
                        _isMale = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _saveTeklifModel();
              },
              child: Text("Gönder"),
            ),
          ],
        ),
      ),
    );
  }

  void _saveTeklifModel() async {
    if (_selectedCity != null && _selectedHospital != null) {
      String phoneNumber = _iletisimController.text;

      if (phoneNumber.length != 11) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Hata'),
              content: Text('Telefon numarası 11 haneli olmalıdır.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Tamam'),
                ),
              ],
            );
          },
        );
        return;
      }

      // Check if the phone number already exists in the database
      bool phoneNumberExists = await _firestoreService.checkPhoneNumberExists(phoneNumber);
      if (phoneNumberExists) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Hata'),
              content: Text('Bu telefon numarasıyla daha önce bir teklif eklenmiştir.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Tamam'),
                ),
              ],
            );
          },
        );
        return;
      }

      // Generate a unique ID for the teklifModel
      String teklifId = Uuid().v4();

      // Create a new instance of TeklifModel
      TeklifModel teklifModel = TeklifModel(
        teklifId: teklifId,
        adSoyad: _adSoyadController.text,
        hastane: _selectedHospital!,
        iletisim: phoneNumber,
        sehir: _selectedCity!,
        hastalik: _hastalikController.text,
        fiyat: int.parse(_fiyatController.text),
        isErkek: true,
      );

      // Save the teklifModel using FirestoreTeklifmodelService
      _firestoreService.saveTeklifModel(teklifModel).then((_) {
        // Successful save operation
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Başarılı'),
              content: Text('Teklif başarıyla eklendi.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Tamam'),
                ),
              ],
            );
          },
        );
      }).catchError((error) {
        // Error occurred during save operation
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Hata'),
              content: Text('Teklif eklenirken bir hata oluştu: $error'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Tamam'),
                ),
              ],
            );
          },
        );
      });
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: Teklif(),
  ));
}
