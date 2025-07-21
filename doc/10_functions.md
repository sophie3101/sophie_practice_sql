CREATE [OR REPLACE] FUNCTION function_name (
    parameter_name [IN | OUT | INOUT] parameter_type [DEFAULT value],
    ...
)
RETURNS return_type
LANGUAGE plpgsql
AS $$
DECLARE
    variable_name variable_type;
    ...
BEGIN
    -- Function logic here
    [RETURN value | RETURN QUERY ...];
END;
$$;


CREATE OR REPLACE FUNCTION get_manga_from_price(price FLOAT)
RETURNS VARCHAR
AS $$
	DECLARE
		"manga" VARCHAR;
	BEGIN
		SELECT INTO "manga"
		"m"."title"
		FROM "mangas" "m"
		LEFT JOIN "volumes" "v" ON "v"."manga_id" = "m"."id"
		WHERE "v"."price" >= $1;
	RETURN
		"manga";
	END;
$$ LANGUAGE plpgsql;

or using PREPARE for simple statement: PREPARE get_user_by_id (int) AS
    SELECT * FROM users WHERE id = $1;
