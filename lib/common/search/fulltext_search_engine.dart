import 'package:corp_devices/common/extensions/extensions.dart';

class FullTextSearchEngine {
  /// Search string based on multiple params in string which are delimeted by
  /// a space
  ///
  /// Param: [query] String which is typically typed to search field
  /// Param: [searchableString] String which is searched
  static bool search({
    required String query,
    required String searchableString,
  }) {
    if (query.isEmpty) return true;

    final queryParts = query.split(" ");
    final preparedString = searchableString.normalize().toLowerCase();
    for (final part in queryParts) {
      if (!preparedString.contains(part.normalize().toLowerCase())) {
        return false;
      }
    }
    return true;
  }
}
