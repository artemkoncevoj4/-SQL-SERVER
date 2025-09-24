USE [Интернет_провайдер];

CREATE SYMMETRIC KEY CreditCardSymKey
WITH ALGORITHM = AES_256
ENCRYPTION BY PASSWORD = 'artemkoncevoj4';
GO
