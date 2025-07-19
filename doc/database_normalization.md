There are three main normal forms
# First Normal Norm
Goal: Ensure the table has no repeating groups, and all attributes are atomic (indivisible).

1. Does the combination of all columns make a unique row every single time?
2. What field can be used to uniquely identify the row?

# Second Normal Norm
Goal: Remove partial dependencies, where a non-key attribute depends on only part of a composite primary key.
1. Fulfil the requirements of first normal form
2. Each non-key attribute must be functionally dependent on the primary key

# 3NF
Goal: Remove transitive dependencies, where a non-key attribute depends on another non-key attribute.
1. Fulfil 2NF
2. No transitive dependencies: This rule is key. In a 3NF table, any non-primary-key column must depend solely on the primary key, not indirectly through another non-key column.