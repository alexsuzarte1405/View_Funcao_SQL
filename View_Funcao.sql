-- DDL: Criação da tabela
CREATE table if not EXISTS users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    active BOOLEAN
);
-- DML: Dados (Exemplos)
INSERT INTO users (name, email, active) VALUES 
('Alexsandro', 'alex@email.com', true),
('Jefte', 'jefte@email.com', false),
('Unex', 'unex@email.com', true);
CREATE OR REPLACE VIEW active_users_view AS
SELECT id, name, email
FROM users
WHERE active = true;
-- Teste:
SELECT * FROM active_users_view;
CREATE OR REPLACE FUNCTION check_user_status(p_id INT) 
RETURNS TEXT AS $$
DECLARE
    v_active BOOLEAN;
    v_exists BOOLEAN;
BEGIN
    -- Verifica se o usuário existe e captura o status
    SELECT active INTO v_active 
    FROM users 
    WHERE id = p_id;

    IF NOT FOUND THEN
        RETURN 'Usuário não encontrado';
    ELSIF v_active = true THEN
        RETURN 'Usuário ativo';
    ELSE
        RETURN 'Usuário inativo';
    END IF;
END;
$$ LANGUAGE plpgsql;
-- Teste:
SELECT check_user_status(1); -- 'Usuário ativo'