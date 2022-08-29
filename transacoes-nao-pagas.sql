/*Verificar quais transações não foram pagas de um cliente*/
SELECT
    s.customer_document_number,
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
AND
    s.customer_document_number = '{{CNPJ}}'
AND
    s.schedule_status != 'PAYMENT_APPROVED';