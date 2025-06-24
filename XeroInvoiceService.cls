public with sharing class XeroInvoiceService {
    @future(callout=true)
    public static void sendInvoiceToXeroAsync(Id invoiceId) {
        sendInvoiceToXero(invoiceId);
    }
    ...
}