# 🔁 Xero-Salesforce Invoice Integration

This project demonstrates how to integrate Salesforce with Xero using OAuth 2.0 and Apex. It allows you to sync custom `Invoice__c` records from Salesforce to Xero Accounting once the status is marked as **"Synced"**.
Click on the above documentation to see full steps.

---

## 📌 Features

- OAuth 2.0 Integration with Xero
- Salesforce Named Credentials + External Credentials
- Custom Metadata for dynamic Tenant ID storage
- Apex Callout via `@future` method
- Error logging and validation
- Trigger-based automation on `Invoice__c`

---

## ⚙️ Technologies

- Salesforce (Custom Objects, Apex, Triggers, Named Credentials)
- Xero Accounting API
- OAuth 2.0 (Authorization Code Flow)

---

## 🔑 Authentication Setup (Every 30 mins)

> Xero tokens expire every 30 minutes. Manual re-authentication is required unless automated with refresh tokens.

1. **Auth Provider**  
   Use OAuth 2.0 with Xero credentials.

2. **External Credential**  
   Use Browser Flow with scope:  
   `openid profile email accounting.transactions`

3. **Named Credential**  
   - URL: `https://api.xero.com`  
   - Allow headers and formulas

4. **Permission Set**  
   Add Named Principal access.

5. **Authenticate**  
   Authenticate your Named Principal and capture `tenantId`.

6. **Custom Metadata Type**  
   Store your `Tenant_ID__c` for dynamic Apex referencing.

---

## 🧾 Salesforce Objects

### Invoice__c Fields
| Field Label      | API Name              | Notes                     |
|------------------|------------------------|----------------------------|
| X Status         | `X_Status__c`         | Picklist: "Synced", "Error" |
| Xero Invoice ID  | `Xero_Invoice_ID__c`  | Stores Xero ID            |
| Xero Status      | `Xero_Status__c`      | Returned status           |
| Xero Response    | `Xero_Response__c`    | Full API response         |

### Invoice_Line__c Fields
| Field Label    | API Name             | Required |
|----------------|----------------------|----------|
| X Description  | `X_Description__c`   | ✅        |
| Quantity       | `Quantity__c`        | ✅        |
| Unit Amount    | `X_Unit_Amount__c`   | ✅        |
| Account Code   | Hardcoded: `200`     | ✅        |
| Tax Type       | Hardcoded: `NONE`    | ✅        |

---

## 🧪 Testing

1. Authenticate Named Credential
2. Insert `Invoice__c` record with:
   - Status = `"Synced"`
   - Valid related `Invoice_Line__c` records
3. Verify:
   - `Xero_Status__c`
   - `Xero_Response__c`
   - Xero Portal for created invoice

---

## 🧯 Common Errors & Fixes

| Error Message                       | Fix                                                                 |
|------------------------------------|----------------------------------------------------------------------|
| `ValidationError: AccountCode...`  | Hardcode AccountCode/TaxType or ensure they’re set in Apex          |
| `No Invoice Line Items found`      | Add at least 1 valid child record                                   |
| `Callout not supported from trigger`| Use `@future(callout=true)` method                                  |
| `Unexpected character '<'`         | Add `Accept: application/json` header                               |
| `Invalid Picklist Value: Synced`   | Add `"Synced"` to picklist values in `X_Status__c` field            |

---

## 📷 Screenshots

| Connecting Screen | Salesforce | Xero |
|------------------------|-----------|---------------------|
| ![auth](./Screenshots/auth_provider.png) | ![named](./Screenshots/named_credential.png) | ![xero](./Screenshots/xero_successful_invoice.png) |

---

## 📄 Documentation

Full config steps and code are available in [`Xero-Salesforce-Integration-Full-Config.docx`](Xero-Salesforce-Integration-Full-Config.docx)



---

## 🙌 Credits

Developed by Logesh Aravindh, Salesforce Developer.

---

