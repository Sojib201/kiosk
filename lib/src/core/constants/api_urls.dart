

class ApiUrls {
  dmpath(String cid) => "https://e01.yeapps.com/dmpath/dinebase/base-url?cid=DINEBASE";
  // login(String baseurl) => '${baseurl}login';
  login(String baseurl) => '${baseurl}login';
  bookTableUrl(String baseurl) => '${baseurl}table-manage';
  getTableStatusUrl(String baseurl) => '${baseurl}table-list';
  //getTableOrderUrl(String baseurl, orderID) => '${baseurl}order-details?order_no=$orderID&branch_id=$branchId';
  allSettings(String baseurl) => '${baseurl}get-all-settings';
  submitOrderUrl(String baseurl) => '${baseurl}order-manage';
  totalGuestCountUrl(String baseurl) => '${baseurl}booking-list';
  unpaidOrderListUrl(String baseurl) => '${baseurl}unpaid-order-list';
  paymentCollection(String baseurl) => '${baseurl}collection-payment';
  deviceSetup(String baseurl) => '${baseurl}device-registration';
  updateOrderStatus(String baseurl) => "${baseurl}update-order-status";
  branchUserList(String baseurl, String cid, String branchId) => "${baseurl}branch-user-list?cid=$cid&branch_id=$branchId";
}
