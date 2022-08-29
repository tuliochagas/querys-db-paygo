-- Soma os valores e da um total que tem a receber
select 
  distinct(s.customer_document_number), 
  sum(s.amount_projection) as value 
from 
  settlement.schedule as s 
where 
  s.schedule_status in (
    'PAYMENT_REPROVED', 'PAYMENT_PENDING', 
    'SENT_TO_PAYMENT'
  ) 
  and s.projection_type = 'RECEIVABLE' 
  and s.customer_document_number = '34885938000158' 
union 
select 
  distinct(p.customer_document_number) as Document, 
  sum(p.amount) as value 
from 
  projection.projection as p 
where 
  p.projection_status in ('PROCESSED') 
  and p.projection_type = 'RECEIVABLE' 
  and p.customer_document_number = '34885938000158';