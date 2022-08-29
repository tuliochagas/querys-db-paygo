/*
Verifica se o cliente tem débito
Verifica se o customer esta em DEBIT BALANCE
DEBIT BALANCE PARA ARRANJO [BANDEIRA] [CREDITO/DEBITO]
*/
select 
  customer_document_number, 
  card_function_type, 
  ps.company_name, 
  customer_acquirer_branch_name, 
  settlement_type, 
  cast(
    sum(amount_projection) as decimal(12, 2)
  ) as 'DEBIT BALANCE' 
from 
  settlement.schedule as s 
  join settlement.payment_scheme as ps on (s.payment_scheme_id = ps.id) 
where 
  (
    schedule_status = 'SENT_TO_PAYMENT' 
    or schedule_status = 'PAYMENT_REPROVED'
  ) 
  and customer_document_number in ('43759023000197') 
group by 
  customer_document_number, 
  card_function_type, 
  ps.company_name, 
  customer_acquirer_branch_name, 
  settlement_type;