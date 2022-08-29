/*Verifica se as trasações foram aprovadas no caso dos efeitos de contrato*/
SELECT
  source_nsu
FROM
  settlement.schedule
WHERE
  schedule_status = 'PAYMENT_APPROVED'
  AND schedule_status != 'CANCELED'
  AND amount_projection > 0
  AND source_nsu IN (
    SELECT
      source_nsu
    FROM
      settlement.schedule
    WHERE
      transaction_type = 'CONTRACT_EFFECT'
      AND customer_document_number = '01459183000170'
  )
ORDER BY id;

/*Query com mais informações*/
SELECT
  s.source_nsu,
  s.amount_projection,
  s.schedule_status,
  s.customer_document_number  
FROM
  settlement.schedule s
WHERE
  schedule_status = 'PAYMENT_APPROVED'
  AND schedule_status != 'CANCELED'
  AND amount_projection > 0
  AND source_nsu IN (
    SELECT
      source_nsu
    FROM
      settlement.schedule
    WHERE
      transaction_type = 'CONTRACT_EFFECT'
      AND customer_document_number = '03611266000169'
  )
ORDER BY id;

/*Valores que já foram pagos a IF*/
SELECT 
  truncate(amount_projection, 2) as formatted_amount, 
  settlement.schedule.* 
FROM 
  settlement.schedule 
WHERE 
  customer_document_number <> '03611266000169' 
  AND schedule_status in ('PAYMENT_APPROVED') 
  AND source_nsu IN (
    SELECT 
      source_nsu 
    FROM 
      settlement.schedule 
    WHERE 
      transaction_type = 'CONTRACT_EFFECT' 
      AND customer_document_number = '03611266000169'
  );

/*Motivos de transações não aprovadas*/
SELECT
  * 
FROM 
  settlement.bank_occurrence 
WHERE 
  id in (
    SELECT 
      bank_occurrence_id 
    FROM 
      settlement.payment_response_bank_occurrence 
    WHERE 
      payment_response_id in (
        SELECT 
          id 
        FROM 
          settlement.payment_response 
        WHERE 
          id in (
            SELECT 
              payment_response_id 
            FROM 
              settlement.payment_response_schedule 
            WHERE 
              schedule_id IN (175354291)
          )
      )
  );



