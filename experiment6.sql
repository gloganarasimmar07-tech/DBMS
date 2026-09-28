-- Sample table: customer(sid, sname, stotal)

-- TRIGGER ON UPDATE
CREATE OR REPLACE TRIGGER up_classd
BEFORE UPDATE ON customer
FOR EACH ROW
DECLARE
BEGIN
   IF UPDATING THEN
      DBMS_OUTPUT.PUT_LINE('new value is ' || :NEW.stotal);
      DBMS_OUTPUT.PUT_LINE('old value is ' || :OLD.stotal);
   END IF;
END;
/
-- Test: UPDATE customer SET salary=500 WHERE sid=3;

-- TRIGGER ON DELETE
CREATE OR REPLACE TRIGGER del_classb
BEFORE DELETE ON customer
FOR EACH ROW
DECLARE
BEGIN
   IF DELETING THEN
      DBMS_OUTPUT.PUT_LINE('row deleted');
   END IF;
END;
/
-- Test: DELETE FROM customer WHERE id=1;

-- TRIGGER ON INSERT (with validation, table: classb(sid, sname, sdept, stotal, grade))
CREATE OR REPLACE TRIGGER ins_classb
BEFORE INSERT ON classb
FOR EACH ROW
DECLARE
   InvTot EXCEPTION;
BEGIN
   IF INSERTING THEN
      IF :NEW.stotal > 1000 THEN
         RAISE InvTot;
      END IF;
   END IF;
EXCEPTION
   WHEN InvTot THEN
      RAISE_APPLICATION_ERROR(-20000, 'Total not valid');
END;
/
-- Test: INSERT INTO classb VALUES('6','jana','it','20000','a');
-- Raises: ORA-20000: Total not valid