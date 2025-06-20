SELECT CONCAT(pizzaA.topping_name,',', pizzaB.topping_name, ',', pizzaC.topping_name) AS pizza,
  pizzaA.ingredient_cost + pizzaB.ingredient_cost + pizzaC.ingredient_cost AS total_cost
FROM pizza_toppings as pizzaA,pizza_toppings as pizzaB , pizza_toppings as pizzaC 
WHERE pizzaA.topping_name < pizzaB.topping_name 
  AND pizzaB.topping_name <pizzaC.topping_name
ORDER BY total_cost DESC, pizza