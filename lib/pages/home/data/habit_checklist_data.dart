class HabitCheckListData {
  bool? isActive;
  HabitCheckListData({this.isActive});
  List<Map> listTileDataParameter() {
    List<Map> myListData = [
      {
        'title': 'Shalat Fardhu',
        'description': 'Shalat fardhu berjama\'ah di masjid.',
        'isActive': isActive,
        'category': 'isFardhu'
      },
      {
        'title': 'Shalat Tahajud',
        'description': 'Shalat tahajud di sepertiga malam terakhir.',
        'isActive': isActive,
        'category': 'isTahajud'
      },
      {
        'title': 'Shalat Dhuha',
        'description': 'Shalat Dhuha.',
        'isActive': isActive,
        'category': 'isDhuha'
      },
      {
        'title': 'Shalat Rawatib',
        'description': 'Shalat Rawatib.',
        'isActive': isActive,
        'category': 'isRawatib'
      },
      {
        'title': 'Tilawah',
        'description': 'Membaca Al-Qur\'an harian.',
        'isActive': isActive,
        'category': 'isTilawah'
      },
      {
        'title': 'Shaum Sunnah',
        'description': 'Shaum sunnah Senin - Kamis atau Ayyamul Bidh.',
        'isActive': isActive,
        'category': 'isShaum'
      },
      {
        'title': 'Sedekah / Infaq',
        'description': 'Sedekah harian, wakaf atau infaq.',
        'isActive': isActive,
        'category': 'isSedekah'
      },
      {
        'title': 'Dzikir Pagi & Petang',
        'description':
            'Melaksanakan dzikir pagi & petang atau satu di antaranya.',
        'isActive': isActive,
        'category': 'isDzikir'
      },
      {
        'title': 'Taklim Ilmu',
        'description':
            'Menghadiri kajian taklim harian atau melaksanakan taklim pribadi.',
        'isActive': isActive,
        'category': 'isTaklim'
      },
      {
        'title': 'Istighfar',
        'description': 'Istighfar harian 100 kali per hari atau semampunya.',
        'isActive': isActive,
        'category': 'isIstighfar'
      },
      {
        'title': 'Shalawat',
        'description': 'Shalawat harian di setiap kesempatan.',
        'isActive': isActive,
        'category': 'isShalawat'
      },
    ];
    return myListData;
  }
}
