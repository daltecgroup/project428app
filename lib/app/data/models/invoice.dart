class InvoiceItem {
  final String name;
  final int quantity;
  final double price;

  InvoiceItem({
    required this.name,
    required this.quantity,
    required this.price,
  });

  double get total => quantity * price;
}

class Invoice {
  final String invoiceNumber;
  final DateTime date;
  final String customerName;
  final List<InvoiceItem> items;
  final double taxRate; // e.g., 0.10 for 10%

  Invoice({
    required this.invoiceNumber,
    required this.date,
    required this.customerName,
    required this.items,
    this.taxRate = 0.0,
  });

  double get subtotal => items.fold(0.0, (sum, item) => sum + item.total);
  double get taxAmount => subtotal * taxRate;
  double get grandTotal => subtotal + taxAmount;

  // Static method to create a dummy invoice for testing
  static Invoice dummyInvoice() {
    return Invoice(
      invoiceNumber: 'INV-2025-06-001',
      date: DateTime.now(),
      customerName: 'Budi Santoso',
      items: [
        InvoiceItem(name: 'Nasi Goreng', quantity: 1, price: 25000),
        InvoiceItem(name: 'Es Teh Manis', quantity: 2, price: 8000),
        InvoiceItem(name: 'Kerupuk', quantity: 3, price: 2000),
      ],
      taxRate: 0.10, // Example 10% VAT
    );
  }
}
