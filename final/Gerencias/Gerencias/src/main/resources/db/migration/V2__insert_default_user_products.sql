-- Inserir Usuário
INSERT INTO USERS (id, name, password, email)
VALUES
    ('11111111-1111-1111-1111-111111111111', 'João Vitor', 'senha_criptografada', 'joaovitor@email.com');

-- Inserir Geladeiras
INSERT INTO REFRIGERATORS (id, name, description, user_id)
VALUES
    ('22222222-2222-2222-2222-222222222222', 'Geladeira 1', 'Geladeira principal da casa', '11111111-1111-1111-1111-111111111111'),
    ('33333333-3333-3333-3333-333333333333', 'Geladeira 2', 'Geladeira reserva', '11111111-1111-1111-1111-111111111111');

-- Inserir Produtos
INSERT INTO PRODUCTS (id, name, expiration_date, refrigerator_id)
VALUES
    ('44444444-4444-4444-4444-444444444444', 'Banana', '2024-12-20', '22222222-2222-2222-2222-222222222222'),
    ('55555555-5555-5555-5555-555555555555', 'Maçã', '2024-12-18', '22222222-2222-2222-2222-222222222222'),
    ('66666666-6666-6666-6666-666666666666', 'Laranja', '2024-12-25', '33333333-3333-3333-3333-333333333333');
