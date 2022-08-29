/*Verifica as informações bancárias do cliente*/
SELECT 
  * 
FROM 
  db_akreditasi.merchant 
  INNER JOIN db_akreditasi.acquirer_branch ON merchant.acquirer_branch_id = acquirer_branch.id 
  LEFT JOIN db_akreditasi.personal_merchant ON personal_merchant.id = merchant.id 
  LEFT JOIN db_akreditasi.business_merchant ON business_merchant.id = merchant.id 
  inner join db_akreditasi.bank_account ba on ba.MERCHANT_ID = merchant.id 
  inner join db_akreditasi.bank b on b.ID = ba.BANK_ID 
WHERE 
  merchant.is_active = 1 
  and coalesce (
    personal_merchant.CPF, business_merchant.CNPJ
  ) in ('26042488000375') 
order by 
  cpf, 
  b.CODE, 
  b.ID;