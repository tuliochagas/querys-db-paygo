/*Schedules negativas (do merchant) objetivo é pegar os source_nsu*/
SELECT 
  truncate(amount_projection, 2) as formatted_amount, 
  settlement.schedule.* 
FROM 
  settlement.schedule 
WHERE 
  transaction_type = 'CONTRACT_EFFECT' 
  AND customer_document_number = 'CNPJ SEM FORMATAÇÃO';

/*
Schedules negativas (do merchant) e positivas (da IF) "agrupadas"
(na ordenação) por source_nsu (protocolo do efeito de contrato).
 Objetivo é dar uma visão de par da positiva e negativa por efeito.
*/
SELECT 
  truncate(amount_projection, 2) as formatted_amount, 
  settlement.schedule.* 
FROM 
  settlement.schedule 
WHERE 
  source_nsu IN (
    "LISTA DE SOURCE_NSUs SEPARADOS POR VIRGULA E
DENTRO DE ASPAS"
  ) 
ORDER BY 
  source_nsu;

/*Outra query para a verificação*/
  SELECT 
  s.id, 
  s.customer_document_number, 
  truncate(amount_projection, 2) as formatted_amount, 
  s.schedule_status, 
  s.transaction_date,
  s.source_nsu
FROM 
  settlement.schedule s 
WHERE 
  schedule_status != 'CANCELED' 
  AND amount_projection > 0 
  AND source_nsu IN (
    SELECT 
      source_nsu 
    FROM 
      settlement.schedule 
    WHERE 
      transaction_type = 'CONTRACT_EFFECT' 
      AND source_nsu in ( "SOURCE_NSU")
  ) 
ORDER BY 
  id;