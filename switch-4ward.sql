/*Verifica o status da transação, se foi para a 4ward (Switch)*/
SELECT 
  external_id 
FROM 
  switch.`transaction` t 
WHERE 
  t.customer_document_number = '34637543000136' 
  AND t.external_id IN (
    '821092362', '821107612', '821110362'
  );