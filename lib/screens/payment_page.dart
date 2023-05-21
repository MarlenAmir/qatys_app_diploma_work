/*import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';


class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  Token _paymentToken;
  String _error;

  @override
  void initState() {
    super.initState();
    StripePayment.setOptions(
      StripeOptions(
        publishableKey: "YOUR_PUBLISHABLE_KEY",
        merchantId: "YOUR_MERCHANT_ID",
        androidPayMode: 'test', // или 'production' для реальных платежей
      ),
    );
  }

  Future<void> _startPayment() async {
    try {
      var paymentMethod = PaymentMethodRequest(
        card: CreditCard(
          number: '4242424242424242',
          expMonth: 12,
          expYear: 25,
        ),
      );

      final PaymentMethod result = await StripePayment.createPaymentMethod(paymentMethod);
      setState(() {
        _paymentToken = result.token;
        _error = null;
      });
      // Отправьте токен платежа (payment token) на ваш сервер для обработки платежа
    } catch (error) {
      setState(() {
        _error = error.toString();
        _paymentToken = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Оплата'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Начать оплату'),
              onPressed: _startPayment,
            ),
            if (_paymentToken != null)
              Text('Токен платежа: ${_paymentToken.tokenId}'),
            if (_error != null)
              Text('Ошибка при проведении платежа: $_error'),
          ],
        ),
      ),
    );
  }
}*/

