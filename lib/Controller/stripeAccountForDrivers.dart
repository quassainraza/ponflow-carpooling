import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


const String _stripeClientId = 'ca_MAWttb3CTXFNwTMRXcU6AH9wZ567fS6e';
class MyStripeConnect {
// Function to create a Stripe account for a driver
String? authcode;
String? tokenid;


void getAuthCode(String code){
  authcode = code;
}
void getToken(String token){
  tokenid = token;
}

// Create a bank token using Flutter Stripe
  Future<void> createBankToken(String accountNumber, String routingNumber) async {
    var bankAccountTokenParams = BankAccountTokenParams(
      country: 'US',
      currency: 'usd',
      accountNumber: accountNumber,
      routingNumber: routingNumber,
      accountHolderName: 'John Doe',
    );

    try {
      final token = await Stripe.instance.createToken(bankAccountTokenParams as CreateTokenParams);
      getToken(token.id);
    } catch (e) {
      // Handle the error
    }
  }


  Future<String> createStripeAccountForDriver(String driverId, String email, String routingNumber, String accountNumber) async {
    // Step 1: Create a connect account token for the driver
    final connectAccountTokenUrl = Uri.https(
        'connect.stripe.com', '/oauth/token');
    final response = await http.post(
      connectAccountTokenUrl,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'grant_type': 'authorization_code',
        'client_id': _stripeClientId,
        'code': authcode,
        'client_secret': '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',
      },
    );

    createBankToken(accountNumber, routingNumber);

    // Extract the connect account token from the response
    final connectAccountToken = json.decode(response.body)['stripe_user_id'];

    // Step 2: Create a Stripe account for the driver
    final createAccountUrl = Uri.https('api.stripe.com', '/v1/accounts');
    final createAccountResponse = await http.post(
      createAccountUrl,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer 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',
      },
      body: {
        'type': 'custom',
        'country': 'US',
        'email': email,
        'metadata[driver_id]': driverId,
        'external_account': tokenid,
        // Set the bank token as a default external account for the account
        'tos_acceptance[date]': '${DateTime
            .now()
            .millisecondsSinceEpoch ~/ 1000}',
        'tos_acceptance[ip]': '127.0.0.1',
        'account_token': connectAccountToken,
        // Set the connect account token for the account
      },
    );

    // Extract the Stripe account ID from the response
    final accountId = json.decode(createAccountResponse.body)['id'];

    // Step 3: Set the driver's bank account as a destination for transfers
    final addExternalAccountUrl = Uri.https(
        'api.stripe.com', '/v1/accounts/$accountId/external_accounts');
    final addExternalAccountResponse = await http.post(
      addExternalAccountUrl,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer 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',
      },
      body: {
        'external_account': tokenid,
        'default_for_currency': 'true',
      },
    );

    return accountId;
  }
}