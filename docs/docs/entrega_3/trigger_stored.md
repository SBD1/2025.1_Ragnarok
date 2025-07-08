# Triggers e Stored Procedures
## O que são?

Triggers e Stored Procedures são mecanismos utilizados em bancos de dados para automatizar e controlar operações de forma eficiente.
As Triggers (gatilhos) são procedimentos que são executados automaticamente em resposta a eventos específicos — como inserções, atualizações ou exclusões de registros — sendo ativadas diretamente por essas ações.
Já as Stored Procedures (procedimentos armazenados) consistem em blocos de comandos SQL armazenados no próprio banco, que podem ser executados sob demanda para realizar tarefas mais complexas, como garantir a integridade em estruturas com generalizações e especializações.
Quando usados em conjunto, esses recursos fortalecem a lógica do sistema e tornam o banco de dados mais robusto, seguro e confiável.

#### Todos podem ser encontrados no arquivo:
1. [**TRIGGER**](../../../projeto/init_scripts/b_triggers.sql)

2. [**PROCEDURES**](../../../projeto/init_scripts/c_procedures.sql)

### Atualiza automaticamente o contador de slots do inventário ao inserir, remover ou mover itens, impedindo que ultrapasse a capacidade:

```sql
--- Atualiza automaticamente o contador slots_usados do inventário toda vez que um item é inserido,
--- removido ou movido na tabela INSTANCIA_ITEM, impedindo que o total 
--- ultrapasse a capacidade e lançando exceção se não houver espaço.

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
```

## Histórico de Versão

|  Versão  |     Data     | Descrição | Autor(es) | Revisor(es) |
| :------: | :----------: | :-----------: | :---------: | :---------: |
| `1.0` | 06/07/2025 | Criação do documento | [Cauã Araujo](https://github.com/caua08) | [Danilo Naves](https://github.com/DaniloNavesS) |