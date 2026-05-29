Feature: Demoblaze Contact modal persistence and bug reporting
  As a user
  I want to test the Contact modal behavior
  So that I can identify data persistence bugs and report issues

Background:
  Given I browse to Demoblaze page

@smoke_test_contact_bug_report
Scenario: Contact modal persists data after close/x and allows bug reporting
  # ============================================
  # PARTE 1: Abrir Contact y escribir nombre
  # ============================================
  When I click on "Contact" option
  Then the contact modal should be displayed
  
  When I fill in the contact name with "QA Tester Ariel"
  When I click the "Close" button in the contact modal
  
  # ============================================
  # PARTE 2: Verificar que el nombre persiste (BUG)
  # ============================================
  When I click on "Contact" option
  Then the contact name field should contain "QA Tester Ariel"
  
  # ============================================
  # PARTE 3: Agregar email y cerrar con X
  # ============================================
  When I fill in the contact email with "ariel@test.com"
  When I click the "X" button in the contact modal
  
  # ============================================
  # PARTE 4: Verificar que nombre y email persisten (BUG)
  # ============================================
  When I click on "Contact" option
  Then the contact name field should contain "QA Tester Ariel"
  Then the contact email field should contain "ariel@test.com"
  
# ============================================
# PARTE 5: Agregar mensaje y enviar
# ============================================
When I fill in the contact message with "Tienen un bug: se puede hacer una orden con el carrito vacío"
When I click the "Send message" button in the contact modal
Then the alert message should be "Thanks for the message!!"
