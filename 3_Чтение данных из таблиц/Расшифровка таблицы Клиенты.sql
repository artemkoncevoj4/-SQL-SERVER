OPEN SYMMETRIC KEY CreditCardSymKey
    DECRYPTION BY PASSWORD = 'artemkoncevoj4';

SELECT 
    ID,
    Имя,
    Фамилия,
    Отчество,
    CAST(DECRYPTBYKEY([Лицевой счет]) AS BIGINT) AS Расшифрованный_лицевой_счет,
    [Номер телефона],
    [Электронная почта],
    [Дата регистрации клиента]
FROM Клиенты;

CLOSE SYMMETRIC KEY CreditCardSymKey;