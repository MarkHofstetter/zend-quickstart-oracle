-- drop user gb cascade;
create user gb identified by gb;
grant resource, connect to gb;

connect gb/gb
create sequence gb_seq
/
CREATE TABLE guestbook
    (id                             NUMBER(38,0) NOT NULL,
    email                          VARCHAR2(32) NOT NULL,
    comments                       VARCHAR2(1000),
    created                        DATE NOT NULL)
/

-- Constraints for GUESTBOOK

ALTER TABLE guestbook
ADD PRIMARY KEY (id)
/

-- Triggers for GUESTBOOK

CREATE OR REPLACE TRIGGER gb_insert_trg
 BEFORE
  INSERT
 ON guestbook
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
begin
  :new.id      := gb_seq.nextval;
  :new.created := sysdate;
end;
/


INSERT INTO guestbook (email, comments) VALUES 
    ('ralph.schindler@zend.com', 
    'Hello! Hope you enjoy this sample zf application!');
INSERT INTO guestbook (email, comments) VALUES 
    ('foo@bar.com', 
    'Baz baz baz, baz baz Baz baz baz - baz baz baz.');
commit;


