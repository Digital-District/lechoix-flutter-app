class Endpoints {
  static const baseUrl =
      "https://lechoix.com/api/v1/";
  static const stagingBaseUrl =
      "https://staging.theoniriq.com/api/v1/";

  // CONFIG
  static const getCountryCodes =  "country-codes";
  static const getLocations = "location";
  static const configurations = "configurations";
  static const onBoarding =  "on-boarding";

  // AUTH
  static const register = "auth/register";
  static const login = "auth/login";
  static const verifyPhone = "auth/verify-phone";
  static const resendCode = "auth/resend-code";
  static const HTMLPage = "pages/";

  // PASSWORD
  static const forgetPassword = "password/forget";
  static const passwordCheckCode = "password/check-code";
  static const resetPassword = "password/reset";

  // CATEGORY
  static const getCategories = "categories";

  // PRODUCTS
  static const getProducts = "products/";

  // FAVORITES
  static const favorites = "favorites/";

  // CART
  static const cart = "cart";
  static const checkDiscount = "cart/check-discount";

  // ADDRESSES
  static const addresses = "addresses";

  // Filtration
  static const brands = "brands";
  static const colors = "colors";
  static const sizes = "sizes";
  static const priceRanges = "price-ranges";

  // ORDERS
  static const orders = "orders";

  // profile
  static const profile = "profile/";
  static const changeAvatar = "profile/avatar/";
  static const changePassword = "profile/update-password/";
  static const requestChangeEmail = "profile/update-email/request/";
  static const changeEmail = "profile/update-email/";
  static const requestChangePhone = "profile/update-phone/request/";
  static const changePhone = "profile/update-phone/";
  static const deleteAccount = "profile/delete";

  // Notification
  static const updateNotificationToken = "notifications/update-token";
  static const deleteNotificationToken = "notifications/delete-tokens";


}
