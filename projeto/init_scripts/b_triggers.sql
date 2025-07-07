CREATE OR REPLACE FUNCTION bloquear_insercao_direta()
RETURNS trigger AS $$
BEGIN
  IF pg_trigger_depth() = 0 THEN
    RAISE EXCEPTION 'Inserções diretas não são permitidas nesta tabela. Use a função apropriada.';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION criar_inventario_automatico()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO INVENTARIO (id_personagem)
    VALUES (NEW.id_personagem);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_criar_inventario
AFTER INSERT ON PERSONAGEM
FOR EACH ROW
EXECUTE FUNCTION criar_inventario_automatico();

CREATE TRIGGER trg_bloquear_insert_capacete
BEFORE INSERT ON CAPACETE
FOR EACH ROW
EXECUTE FUNCTION bloquear_insercao_direta();

CREATE TRIGGER trg_bloquer_insert_acessorio
BEFORE INSERT ON ACESSORIO
FOR EACH ROW
EXECUTE FUNCTION bloquear_insercao_direta();

CREATE TRIGGER trg_bloquear_insert_peitoral
BEFORE INSERT ON PEITORAL
FOR EACH ROW
EXECUTE FUNCTION bloquear_insercao_direta();