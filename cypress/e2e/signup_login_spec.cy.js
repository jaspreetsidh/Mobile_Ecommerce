describe('Sign-Up/Login Tests', () => {
  it('should successfully sign up a new user', () => {
    cy.visit('/users/sign_up');
    cy.get('input[name="user[email]"]').type('newuser3@example.com');
    cy.get('input[name="user[password]"]').type('password123');
    cy.get('input[name="user[password_confirmation]"]').type('password123');
    cy.get('input[name="user[street]"]').type('123 Main St');
    cy.get('select[name="user[province]"]').select('ON');
    cy.get('input[name="user[postal_code]"]').type('12345');
    cy.get('input[type="submit"]').click();

    cy.url().should('include', '/products');
  });
   successfully log in an existing user', () => {
    cy.visit('/users/sign_in');
    cy.get('input[name="user[email]"]').type('newuser3@example.com');
    cy.get('input[name="user[password]"]').type('password123');
    cy.get('input[type="submit"]').click();

    cy.url().should('include', '/products');
  });

  it('should fail to log in with incorrect password', () => {
    cy.visit('/users/sign_in');
    cy.get('input[name="user[email]"]').type('newuser3@example.com');
    cy.get('input[name="user[password]"]').type('wrongpassword');
    cy.get('input[type="submit"]').click();

    cy.url().should('not.include', '/products');
  });
});
