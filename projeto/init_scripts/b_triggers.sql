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

CREATE OR REPLACE FUNCTION incrementar_slots_usados()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'INSERT' THEN
    IF NEW.id_inventario IS NOT NULL THEN
      PERFORM 1
        FROM INVENTARIO
        WHERE id_inventario = NEW.id_inventario AND slots_usados >= capacidade_slots;
      IF FOUND THEN
        RAISE EXCEPTION 'Inventário % sem espaço disponível', NEW.id_inventario;
      END IF;
      UPDATE INVENTARIO
        SET slots_usados = slots_usados + 1
      WHERE id_inventario = NEW.id_inventario;
    END IF;
  ELSIF TG_OP = 'DELETE' THEN
    IF OLD.id_inventario IS NOT NULL THEN
      UPDATE INVENTARIO
        SET slots_usados = slots_usados - 1
      WHERE id_inventario = OLD.id_inventario;
    END IF;
  ELSIF TG_OP = 'UPDATE' THEN
    IF OLD.id_inventario IS NOT NULL
      AND (NEW.id_inventario IS NULL
        OR NEW.id_inventario <> OLD.id_inventario) THEN
      UPDATE INVENTARIO
        SET slots_usados = slots_usados - 1
      WHERE id_inventario = OLD.id_inventario;
    END IF;
  
    IF NEW.id_inventario IS NOT NULL
      AND (OLD.id_inventario IS NULL
        OR NEW.id_inventario <> OLD.id_inventario) THEN
      UPDATE INVENTARIO
        SET slots_usados = slots_usados + 1
      WHERE id_inventario = NEW.id_inventario;
    END IF;
  END IF;

  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_add_slots_inventario
AFTER INSERT ON INSTANCIA_ITEM
FOR EACH ROW EXECUTE FUNCTION incrementar_slots_usados();

CREATE TRIGGER trg_del_slots_inventario
AFTER DELETE ON INSTANCIA_ITEM
FOR EACH ROW EXECUTE FUNCTION incrementar_slots_usados();

CREATE TRIGGER trg_updt_slots_inventario
AFTER UPDATE ON INSTANCIA_ITEM
FOR EACH ROW EXECUTE FUNCTION incrementar_slots_usados();