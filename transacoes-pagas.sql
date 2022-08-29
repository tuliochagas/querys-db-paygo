select 
  id, 
  amount_projection, 
  customer_name, 
  customer_document_number, 
  projection_type, 
  source_nsu, 
  transaction_date, 
  schedule_status 
from 
  settlement.schedule 
where 
  customer_document_number = '07965304000647' 
  and transaction_date between '2022-01-01' 
  and '2022-06-10';

-- Outra query, mesmo propósito
  SELECT 
  s.external_id, 
  s.source_nsu, 
  s.amount_projection, 
  s.installment_number, 
  s.schedule_status, 
  s.transaction_date, 
  s.forecast_payment_date, 
  s.payment_send_date, 
  s.provider_expected_payment_date 
FROM 
  settlement.schedule s 
WHERE 
  projection_type = 'RECEIVABLE' 
  AND s.customer_document_number = '07965304000647' 
  AND s.transaction_date = '2022-02-17' 
  AND s.schedule_status IN (
    'SENT_TO_PAYMENT', 'PAYMENT_APPROVED'
  );