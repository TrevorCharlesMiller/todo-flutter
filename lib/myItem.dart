class MyItem {
  bool selected;
  String title;

  MyItem(bool selected, String title) {
    this.selected = selected;
    this.title = title;
  }

  String toString() {
    return this.title;
  }
}

class TodoList {
  static List<MyItem> items = [];
}