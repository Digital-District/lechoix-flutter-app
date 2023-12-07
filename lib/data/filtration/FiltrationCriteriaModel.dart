class FiltrationCriteriaModel {
  String productsCount = "0";

  // Main
  int categoryId = -1;
  int brandId = -1;
  int count = 10;
  int page = 1;

  // Sort
  String sortBy = "best_sale";

  // Filter
  bool sale = false;
  List<int> categories = [];
  List<int> designers = [];
  List<int> clothingSize = [];
  List<int> colors = [];
  List<int> priceRange = [];

  // Search
  String keyword = "";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    map['page'] = page;
    map['sort_by'] = sortBy;
    if (sale) {
      map['in_sale'] = sale;
    }

    if (categoryId != -1) {
      map['category_id'] = categoryId;
    }
    if (brandId != -1) {
      map['brand_id'] = brandId;
    }
    if (categories.isNotEmpty) {
      map['categories[]'] = categories;
    }
    if (designers.isNotEmpty) {
      map['brands[]'] = designers;
    }
    if (clothingSize.isNotEmpty) {
      map['sizes[]'] = clothingSize;
    }
    if (colors.isNotEmpty) {
      map['colors[]'] = colors;
    }
    if (priceRange.isNotEmpty) {
      map['price_range[]'] = priceRange;
    }
    if (keyword.isNotEmpty) {
      map['keyword'] = keyword;
    }
    return map;
  }

  clear() {
    sale = false;
    categories = [];
    designers = [];
    clothingSize = [];
    colors = [];
    priceRange = [];
  }
}
