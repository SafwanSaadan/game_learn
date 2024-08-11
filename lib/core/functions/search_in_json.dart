import 'dart:convert';

import 'package:flutter/services.dart';

List<dynamic> _searchResults = [];
late List<dynamic> _jsonData; // Store loaded JSON data
bool _isLoading = true; // Added loading indicator

Future<void> _loadJson() async {
  String jsonString = await rootBundle.loadString('assets/data.json');
  _jsonData = json.decode(jsonString);
  // setState(() {
  _isLoading = false; // Set loading to false after data is loaded
  // });
}

// دالة لتطبيع الحروف العربية
String normalizeArabic(String text) {
  Map<String, String> arabicMap = {
    'أ': 'ا',
    'إ': 'ا',
    'آ': 'ا',
    'ة': 'ه',
    'ى': 'ي',
    'ئ': 'ي',
    'ؤ': 'و',
  };
  arabicMap.forEach((key, value) {
    text = text.replaceAll(key, value);
  });
  return text;
}

// دالة للحصول على الكلمة الموحدة بناءً على المرادفات
String getSynonym(String word) {
  Map<String, List<String>> synonyms = {
    'منزل': ['بيت', 'المنزل', 'البيت'],
    'سيارة': ['عربة', 'مركبة', 'العربة', 'المركبة'],
    // أضف المزيد من المرادفات هنا
  };

  for (var entry in synonyms.entries) {
    if (entry.value.contains(word)) {
      return entry.key;
    }
  }
  return word;
}

// التعامل مع الأخطاء الإملائية
int levenshteinDistance(String s, String t) {
  if (s == t) return 0;
  if (s.isEmpty) return t.length;
  if (t.isEmpty) return s.length;

  List<List<int>> matrix = List.generate(s.length + 1, (i) => List<int>.filled(t.length + 1, 0));

  for (int i = 0; i <= s.length; i++) matrix[i][0] = i;
  for (int j = 0; j <= t.length; j++) matrix[0][j] = j;

  for (int i = 1; i <= s.length; i++) {
    for (int j = 1; j <= t.length; j++) {
      int cost = s[i - 1] == t[j - 1] ? 0 : 1;
      matrix[i][j] = [
        matrix[i - 1][j] + 1,
        matrix[i][j - 1] + 1,
        matrix[i - 1][j - 1] + cost
      ].reduce((a, b) => a < b ? a : b);
    }
  }

  return matrix[s.length][t.length];
}

void _search(String query) {
  String normalizedQuery = normalizeArabic(query.toLowerCase());
  String unifiedQuery = getSynonym(normalizedQuery);

  List<dynamic> results = _jsonData.where((item) {
    String title = item['title'].toString().toLowerCase();
    String normalizedTitle = normalizeArabic(title);
    String unifiedTitle = getSynonym(normalizedTitle);

    return levenshteinDistance(unifiedQuery, unifiedTitle) <= 2;
  }).toList();

  // setState(() {
    _searchResults = results;
  // });
}






// void _search(String query) {
//   String normalizedQuery = normalizeArabic(query.toLowerCase());
//   String unifiedQuery = getSynonym(normalizedQuery);

//   List<dynamic> results = _jsonData.where((item) {
//     String title = item['title'].toString().toLowerCase();
//     String normalizedTitle = normalizeArabic(title);
//     String unifiedTitle = getSynonym(normalizedTitle);
//     return unifiedTitle.contains(unifiedQuery);
//   }).toList();

//   // setState(() {
//     _searchResults = results;
//   // });
// }


// void _search(String query) {
//   // 1. تطبيع الحروف العربية في استعلام البحث
//   String normalizedQuery = _normalizeArabic(query.toLowerCase());

//   // 2. الحصول على الكلمة الموحدة بناءً على المرادفات
//   String unifiedQuery = _getSynonym(normalizedQuery);

//   // 3. البحث في البيانات
//   List<dynamic> results = _jsonData.where((item) {
//     String normalizedTitle =
//         _normalizeArabic(item['title'].toString().toLowerCase());
//     return normalizedTitle.contains(unifiedQuery);
//   }).toList();

//   // setState(() {
//   _searchResults = results;
//   // });
// }












// import 'package:fuzzywuzzy/fuzzywuzzy.dart';

// void _search(String query) {
//   List<dynamic> results = _jsonData.where((item) {
//     String title = item['title'].toString().toLowerCase();
//     return ratio(query.toLowerCase(), title) > 80;  // ضبط العتبة بناءً على الحاجة
//   }).toList();

//   setState(() {
//     _searchResults = results;
//   });
// }

// import 'package:levenshtein/levenshtein.dart';

// void _search(String query) {
//   final lev = Levenshtein();

//   List<dynamic> results = _jsonData.where((item) {
//     String title = item['title'].toString().toLowerCase();
//     return lev.distance(query.toLowerCase(), title) < 3;  // ضبط العتبة بناءً على الحاجة
//   }).toList();

//   setState(() {
//     _searchResults = results;
//   });
// }

// import 'package:algolia/algolia.dart';

// final Algolia algolia = Algolia.init(
//   applicationId: 'YourApplicationID',
//   apiKey: 'YourSearchOnlyAPIKey',
// );

// Future<void> _search(String query) async {
//   AlgoliaQuery algoliaQuery = algolia.instance.index('your_index_name').search(query);

//   AlgoliaQuerySnapshot snap = await algoliaQuery.getObjects();
//   List<AlgoliaObjectSnapshot> results = snap.hits;

//   setState(() {
//     _searchResults = results.map((item) => item.data).toList();
//   });
// }
