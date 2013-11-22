require "liftmaster_myq/version"
require "liftmaster_myq/system"
require "liftmaster_myq/device"

module LiftmasterMyq
  APP_ID = "Vj8pQggXLhLy0WHahglCD4N1nAkkXQtGYpq2HrHD7H1nvmbT55KqtN6RSF4ILB%2Fi"
  LOCALE = "en"

  HOST_URI = "myqexternal.myqdevice.com"
  LOGIN_ENDPOINT = "Membership/ValidateUserWithCulture"
  DEVICE_LIST_ENDPOINT = "api/UserDeviceDetails"
  DEVICE_SET_ENDPOINT = "Device/setDeviceAttribute"
  DEVICE_STATUS_ENDPOINT = "/Device/getDeviceAttribute"
end
