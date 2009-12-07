<?php
// application/models/GuestbookMapper.php


class Default_Model_GuestbookMapper
{
    protected $_dbTable;

    public function setDbTable($dbTable)
    {
        if (is_string($dbTable)) {
            $dbTable = new $dbTable();
        }
        if (!$dbTable instanceof Zend_Db_Table_Abstract) {
            throw new Exception('Invalid table data gateway provided');
        }
        $this->_dbTable = $dbTable;
        return $this;
    }

    public function getDbTable()
    {
        if (null === $this->_dbTable) {
            $this->setDbTable('Default_Model_DbTable_Guestbook');
        }
        return $this->_dbTable;
    }

    public function save(Default_Model_Guestbook $guestbook)
    {
        $data = array(
            'EMAIL'   => $guestbook->getEmail(),
            'COMMENTS' => $guestbook->getComment(),
            ## 'CREATED' => date('Y-m-d H:i:s') ,
        );

        if (null === ($id = $guestbook->getId())) {
            unset($data['id']);
            $this->getDbTable()->insert($data);
        } else {
            $this->getDbTable()->update($data, array('id = ?' => $id));
        }
    }

    public function find($id, Default_Model_Guestbook $guestbook)
    {
        $result = $this->getDbTable()->find($id);
        if (0 == count($result)) {
            return;
        }
        $row = $result->current();
        $guestbook->setId($row->ID)
                  ->setEmail($row->EMAIL)
                  ->setComment($row->COMMENTS)
                  ->setCreated($row->CREATED);
    }

    public function fetchAll()
    {
        $resultSet = $this->getDbTable()->fetchAll();
        $entries   = array();
        foreach ($resultSet as $row) {
            $entry = new Default_Model_Guestbook();
            $entry ->setId($row->ID)
                  ->setEmail($row->EMAIL)
                  ->setComment($row->COMMENTS)
                  ->setCreated($row->CREATED)
                  ->setMapper($this);
            $entries[] = $entry;
        }
        return $entries;
    }
}
