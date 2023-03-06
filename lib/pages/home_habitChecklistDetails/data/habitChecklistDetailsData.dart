import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HabitChecklistDetailsData {
  Map checklistParamData = {
    'fardhu': {
      'title': 'Shalat Berjama\'ah di Masjid',
      'hadits':
          '"Barang siapa pergi ke masjid pada awal dan akhir siang, maka Allah akan menyiapkan baginya tempat dan hidangan di surga setiap kali dia pergi." (HR Bukhari dan Muslim)',
      'list': [
        {
          'title': 'Shalat Shubuh',
          'subTitle': 'Shalat Shubuh Berjama\'ah di masjid',
        },
        {
          'title': 'Shalat Dhuhur',
          'subTitle': 'Shalat Dhuhur Berjama\'ah di masjid',
        },
        {
          'title': 'Shalat Ashar',
          'subTitle': 'Shalat Ashar Berjama\'ah di masjid',
        },
        {
          'title': 'Shalat Maghrib',
          'subTitle': 'Shalat Maghrib Berjama\'ah di masjid',
        },
        {
          'title': 'Shalat Isya',
          'subTitle': 'Shalat Isya Berjama\'ah di masjid',
        }
      ],
    },
    'tahajud': {
      'hadits': '',
      'title': 'Shalat Tahajud',
      'subTitle': 'Shalat Tahajud di sepertiga malam terakhir',
    },
    'dhuha': {
      'hadits': '',
      'title': 'Shalat Dhuha',
      'subTitle': 'Shalat Dhuha di waktu pagi',
    },
    'rawatib': {
      'hadits': '',
      'title': 'Shalat Rawatib',
      'subTitle': 'Shalat Rawatib sesuai sunnah',
    },
    'tilawah': {
      'hadits': '',
      'title': 'Tilawah Al-Qur\'an',
      'subTitle': 'Membaca Al-Qur\'an harian sesuai kemampuan',
    },
    'shaum': {
      'hadits': '',
      'title': 'Shaum Sunnah',
      'subTitle': 'Shaum sunnah sesuai tuntunan',
    },
    'sedekah': {
      'hadits': '',
      'title': 'Sedekah / Infaq',
      'subTitle': 'Sedekah / Infaq harian rutin',
    },
    'dzikir': {
      'title': 'Dzikir Pagi & Petang',
      'hadits': '',
      'list': [
        {
          'title': 'Dzikir Pagi',
          'subTitle': 'Dzikir Pagi sesuai tuntunan',
        },
        {
          'title': 'Dzikir Petang',
          'subTitle': 'Dzikir Petang sesuai tuntunan',
        },
      ]
    },
    'taklim': {
      'hadits': '',
      'title': 'Taklim Mandiri / Halaqah',
      'subTitle': 'Menimba ilmu setiap hari',
    },
    'istighfar': {
      'hadits': '',
      'title': 'Istighfar',
      'subTitle': 'Istighfar Harian',
    },
    'shalawat': {
      'hadits': '',
      'title': 'Shalawat',
      'subTitle':
          'Shalawat tanda cinta kepada Rasullullah Alaihi Shalatu wa Sallam',
    }
  };
}
