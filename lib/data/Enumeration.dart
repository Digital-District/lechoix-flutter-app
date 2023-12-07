enum Method { POST, GET, PUT, DELETE, PATCH, postFormData }

enum OTPMood { Auth, ForgetPassword }

enum ProfileOTPMood { Phone, Email }

enum FiltrationType { categories, designers, clothingSize, colors, priceRange }

///////////////////// PaymentMethod //////////////
enum PaymentMethod { cashOnDelivery, cardOnDelivery, onlinePayment, non }

extension PaymentMethodExtension on PaymentMethod {
// 1 => cash on delivery
// 2 => card on delivery
// 3 => onlinePayment
  PaymentMethod getType(int value) {
    switch (value) {
      case 1:
        {
          return PaymentMethod.cashOnDelivery;
        }
      case 2:
        {
          return PaymentMethod.cardOnDelivery;
        }
      case 3:
        {
          return PaymentMethod.onlinePayment;
        }
    }
    return PaymentMethod.cashOnDelivery;
  }

  String getName(int value) {
    switch (value) {
      case 1:
        {
          return "Cash on Delivery";
        }
      case 2:
        {
          return "Card on Delivery";
        }
      case 3:
        {
          return "Online Payment";
        }
    }
    return "Cash on Delivery";
  }

  int? getValue(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.cashOnDelivery:
        {
          return 1;
        }
      case PaymentMethod.cardOnDelivery:
        {
          return 2;
        }
      case PaymentMethod.onlinePayment:
        {
          return 3;
        }
      case PaymentMethod.non:
        {
          return null;
        }
    }
    return 1;
  }
}

///////////////////// Order Status //////////////

enum OrderStatus { preparing, shipped, delivered }
