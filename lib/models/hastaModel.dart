import 'dart:ffi';

class HastaModel {
  final String? hastaId;
  final String? ad;
  final String? soyad;
  final String? TC;
  final String? hastane;
  final String? telefon;
  final String? sehir;
  final int? yas;
  final bool? cinsiyet;
  final String? sifre;

  HastaModel(
      {
        this.hastaId,this.ad, this.soyad, this.TC, this.hastane,
        this.telefon,this.sehir,this.yas,this.cinsiyet,this.sifre
      });

  Map<String, dynamic> toMap() {
    return {
      'hastaId': hastaId,
      'ad': ad,
      'soyad': soyad,
      'TC': TC,
      'hastane': hastane,
      'telefon': telefon,
      'sehir': sehir,
      'yas': yas,
      'cinsiyet': cinsiyet,
      'sifre': sifre,
    };
  }

  HastaModel.fromFirestore(Map<String, dynamic> firestore)
      : hastaId = firestore['hastaId'],
        ad = firestore['ad'],
        soyad = firestore['soyad'],
        TC = firestore['TC'],
        hastane = firestore['hastane'],
        telefon = firestore['telefon'],
        sehir = firestore['sehir'],
        yas = firestore['yas'],
        cinsiyet = firestore['cinsiyet'],
        sifre = firestore['sifre'];
}
