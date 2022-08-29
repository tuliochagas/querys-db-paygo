/*Verifica as tentativas de pagamento*/
SELECT 
  pc.id as 'payment_customer_id', 
  pc.cip_card_function_type as 'Card func', 
  pc.cip_paymen_scheme_company_name as 'Scheme', 
  pc.total_amount, 
  pr.id as 'Response ID', 
  pr.status as 'Response status', 
  pr.response_timestamp as 'Response timestamp', 
  p.id as 'Bank batch', 
  p.settlement_provider as 'Provider', 
  p.status as 'Bank batch status', 
  p.created_date, 
  p.total_amount as 'Bank batch total' 
FROM 
  settlement.payment_customer as pc 
  LEFT JOIN settlement.payment_response as pr ON pr.payment_customer_id = pc.id 
  JOIN settlement.payment_paying_institution as ppi ON pc.payment_paying_institution_id = ppi.id 
  LEFT JOIN settlement.payment as p ON p.id = ppi.payment_id 
WHERE 
  pc.id IN (
    SELECT 
      payment_customer_id 
    FROM 
      settlement.payment_customer_schedule 
    WHERE 
      schedule_id IN ('id', 'id', 'id')
  ) 
order by 
  response_timestamp;