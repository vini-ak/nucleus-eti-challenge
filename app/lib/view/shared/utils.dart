class Utils {
  static List<String> splitContactName(String name) {
    var handleName = name.trim();
    var index = handleName.indexOf(' ');

    return index == -1
        ? [handleName]
        : [
            handleName.substring(0, index).trim(),
            handleName.substring(index + 1).trim()
          ];
  }
}
