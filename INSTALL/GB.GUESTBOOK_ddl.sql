-- Start of DDL Script for Table GB.GUESTBOOK
-- Generated 22-Nov-2009 21:51:09 from GB@ORCL

CREATE TABLE guestbook
    (id                             NUMBER(38,0) NOT NULL,
    email                          VARCHAR2(32) NOT NULL,
    comments                       VARCHAR2(1000),
    created                        DATE NOT NULL)
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  NOCACHE
  MONITORING
/





-- Constraints for GUESTBOOK

ALTER TABLE guestbook
ADD PRIMARY KEY (id)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
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


-- End of DDL Script for Table GB.GUESTBOOK

