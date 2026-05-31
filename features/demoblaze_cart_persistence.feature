Feature: Demoblaze cart persistence and management
              As a user
              I want to add multiple products to the cart
  So that I can verify they persist after page reload and can be managed

        Background:
            Given I browse to Demoblaze page
              And I am logged in with a registered user

        @smoke_test_cart_persistence
        Scenario: Cart persistence after reload and product removal
  # ============================================
  # PARTE 1: Agregar productos de la página 1 (Phones)
  # ============================================
             When I add the product "Samsung galaxy s6" to the cart
             When I add the product "Nokia lumia 1520" to the cart
             When I add the product "Nexus 6" to the cart
  
  # ============================================
  # PARTE 2: Cambiar a Laptops y agregar MacBook air
  # ============================================
             When I change to the "Laptops" category
             When I add the product "MacBook air" to the cart
  
  # ============================================
  # PARTE 3: Volver a cambiar a Laptops y agregar Dell i7 8gb
  # ============================================
             When I change to the "Laptops" category
             When I add the product "Dell i7 8gb" to the cart
  
  # ============================================
  # PARTE 4: Verificar productos en carrito
  # ============================================
             When I click on "Cart" option
             Then the cart should contain the following products:
                  | Samsung galaxy s6 |
                  | Nokia lumia 1520  |
                  | Nexus 6           |
                  | MacBook air       |
                  | Dell i7 8gb       |
  
  # ============================================
  # PARTE 5: Verificar total calculado
  # ============================================
             Then the cart total should be "3230"
  
  # ============================================
  # PARTE 6: Recargar página y verificar persistencia
  # ============================================
             When I reload the page
             Then the cart should still contain 5 products
              And the cart total should still be "3230"
  
  # ============================================
  # PARTE 7: Eliminar 2 productos
  # ============================================
             When I delete the product "Nexus 6" from the cart
             When I delete the product "Dell i7 8gb" from the cart
  
  # ============================================
  # PARTE 8: Verificar productos restantes
  # ============================================
             Then the cart should contain the following products:
                  | Samsung galaxy s6 |
                  | Nokia lumia 1520  |
                  | MacBook air       |
  
  # ============================================
  # PARTE 9: Verificar total actualizado
  # ============================================
             Then the cart total should be "1880"