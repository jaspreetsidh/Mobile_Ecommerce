describe('Cart/Checkout Tests', () => {
  it('should add a product to the cart', () => {
    cy.visit('/products');
    cy.get('button.add-to-cart').first().click();

    // Verify product is added to the cart
    cy.get('a[href="/cart"]').click();
    cy.contains('Your Cart');
    cy.contains('Product Name');
  });

  it('should modify the cart', () => {
    cy.visit('/cart');
    cy.get('button.increase-quantity').click();

    // Verify quantity is updated
    cy.get('input.quantity-input').should('have.value', '2');
  });

  it('should successfully check out', () => {
    cy.visit('/cart');
    cy.get('button.checkout').click();

    // Fill out checkout form
    cy.get('input[name="order[street]"]').type('123 Main St');
    cy.get('input[name="order[city]"]').type('New York');
    cy.get('select[name="order[province]"]').select('NY');
    cy.get('input[name="order[postal_code]"]').type('10001');
    cy.get('input[name="order[credit_card_number]"]').type('4242424242424242');
    cy.get('input[name="order[expiration_date]"]').type('12/23');
    cy.get('input[name="order[cvc]"]').type('123');
    cy.get('input[type="submit"]').click();

    // Verify order is placed
    cy.url().should('include', '/orders/success');
    cy.contains('Order successfully placed');
  });

  it('should show error message for invalid checkout', () => {
    cy.visit('/cart');
    cy.get('button.checkout').click();

    // Fill out checkout form with invalid data
    cy.get('input[name="order[credit_card_number]"]').type('1111111111111111');
    cy.get('input[type="submit"]').click();

    // Verify error message is shown
    cy.contains('Credit card number is invalid');
  });
});
