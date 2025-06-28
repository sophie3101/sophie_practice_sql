/*
You're a consultant for a major pizza chain preparing for a promotion where all
3-topping pizzas will be sold for a fixed price. To help with pricing and planning,
you need to analyze all possible 3-topping combinations and calculate their total ingredient costs.

Your task:
- Write a query that outputs all valid 3-topping pizza combinations and the total cost of the ingredients.
- Sort the results by:
  1. Highest total cost (descending)
  2. Alphabetical order of the toppings (ascending)
     - Break ties using the first ingredient, then second, then third.
- Display toppings in a single string separated by commas (e.g., 'Chicken,Pepperoni,Sausage').

Constraints:
- Each topping in a combination must be **unique** (no repeated toppings).
- Ingredients must be listed in **alphabetical order** within each combination.
  For example: 'Chicken,Onions,Sausage' is valid, but 'Onions,Sausage,Chicken' is not.
- Be mindful of spacing: do **not** include spaces after commas in the output.

Table: pizza_toppings

Columns:
- topping_name (varchar): The name of the topping
- ingredient_cost (decimal): The cost of that topping

Example Input:
topping_name     | ingredient_cost
-----------------|----------------
Pepperoni        | 0.50
Sausage          | 0.70
Chicke
*/
SELECT CONCAT(pizzaA.topping_name,',', pizzaB.topping_name, ',', pizzaC.topping_name) AS pizza,
  pizzaA.ingredient_cost + pizzaB.ingredient_cost + pizzaC.ingredient_cost AS total_cost
FROM pizza_toppings as pizzaA,pizza_toppings as pizzaB , pizza_toppings as pizzaC 
WHERE pizzaA.topping_name < pizzaB.topping_name 
  AND pizzaB.topping_name <pizzaC.topping_name
ORDER BY total_cost DESC, pizza

--other solution usingg recursive