class ApiConstants {
  static String signup = "user/signup";
  static String login = "user/login";
  static String getprofile = "user-profile";
  static String editprofile = "user/profile";
  static String uploadFile = "attachment/upload";
  static String language = "language";
  static String forgetPassword = "user/forget-password";
  static String changePassword = "user/change-password";
  static String logout = "user/logout";

  static String companion = "companion";
  static String companionId = "companion-id";
  static String events = "events";
  static String event_slots = "events-slots";
  static String event_calendar = "events-calander";
  static String singleEvent = "events/id";
  static String event_reschedule = "events/reschedule";
  static String event_cancel = "events-cancel";
  static String notification = "notification";

  //reception api endpoints
  static String mobile_dashboard = "mobile-dashboard";

  // shops api
  static String productList = "product-list";
  static String productDetail = "product-details";
  static String productCategoryList = "category-list";
  static String wishList = "wish-list";
  static String postWishList = "wish-list";

  // self study seminars api endpoint
  static String courses_topic = "course/getTopic";
  static String courses_chapters = "course/getChapters";
  static String video_update_timeStamp = "course/timestamp";
  static String giveReview = "course/giveReview";
  static String getReview = "course/getReviews";
  static String comments = "course/comment";
  static String post_comment = "course/comment";

  static String get_cart_product = "cart-product";
  static String cart_product = "cart-product";
  static String delete_cart_product = "cart-product";

  // order api
  static String shopOrderList = "order";
  static String shopOrderDetail = "order-id";
  static String completedMeetings = "completed-meetings";

  static const int paymentStatusCreated = 0;
  static const int paymentStatusAuthorized = 1;
  static const int paymentStatusCaptured = 2;
  static const int paymentStatusRefunded = 3;
  static const int paymentStatusFailed = 4;
  static const int paymentStatusPending = 5;
  static const int paymentStatusSuccess = 6;

  static const int paymentInAppPurchaseSuccess = 1;
  static const int paymentInAppPurchaseFailed = 0;
}
