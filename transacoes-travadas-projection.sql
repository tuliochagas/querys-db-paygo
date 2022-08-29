-- Verifica projections do cliente
SELECT 
  p.external_id, 
  p.source_nsu, 
  p.amount, 
  p.is_splitted, 
  p.installment_number, 
  p.installment_total, 
  p.transaction_date, 
  p.settlement_schedule_days, 
  p.forecast_payment_date, 
  p.projection_status 
FROM 
  projection.projection p 
WHERE 
  projection_type IN ('RECEIVABLE', 'REFUND') 
  and p.transaction_date >= '2022-06-07' 
  AND customer_document_number = '32027015000130' 
ORDER BY 
  transaction_date, 
  external_id, 
  installment_number;

-- Verifica transações que estão paradas na projection
  select 
  p.id, 
  p.customer_document_number, 
  p.amount, 
  p.forecast_payment_date, 
  p.settlement_schedule_days, 
  p.installment_number, 
  p.is_splitted, 
  p.projection_type, 
  p.source_nsu, 
  p.transaction_date, 
  p.transaction_type, 
  p.projection_status 
from 
  projection.projection as p 
where 
  customer_document_number = '32027015000130' 
  and not exists (
    select 
      * 
    from 
      settlement.schedule as s 
    where 
      p.source_nsu = s.source_nsu 
      and p.customer_document_number = s.customer_document_number 
      and p.installment_number = s.installment_number
  ) 
  and transaction_date between '2021-01-01' 
  and '2022-06-02' 
  and forecast_payment_date <= curdate();
