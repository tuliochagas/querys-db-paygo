/*Verifica se as transações foram barradas em risco*/
SELECT 
  p.external_id, 
  p.forecast_payment_date, 
  b.company_name, 
  installment_number, 
  r.rule_action, 
  settlement_schedule_days 
FROM 
  resiko_transaction_analysis.transaction p 
  INNER JOIN purchase.payment_scheme b on p.payment_scheme_id = b.id 
  LEFT JOIN (
    select 
      id, 
      rule_action 
    from 
      resiko_transaction_analysis.risk_evaluation
  ) r ON p.risk_evaluation_id = r.id 
WHERE 
  external_id IN ('');