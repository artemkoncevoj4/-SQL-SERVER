-- Шифруем триггер (после его создания)
EXEC sp_helptext '[dbo].[Шифрование_Лицевого_Счета]';

-- Зашифровываем триггер
EXEC('
ALTER TRIGGER [dbo].[Шифрование_Лицевого_Счета]
ON [dbo].[Клиенты]
WITH ENCRYPTION
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        OPEN SYMMETRIC KEY CreditCardSymKey
            DECRYPTION BY PASSWORD = ''artemkoncevoj4'';

        INSERT INTO Клиенты (Имя, Фамилия, Отчество, [Лицевой счет], [Номер телефона], 
                           [Электронная почта], [Дата регистрации клиента], [Время регистрации клиента])
        SELECT 
            Имя, 
            Фамилия, 
            Отчество,
            ENCRYPTBYKEY(KEY_GUID(''CreditCardSymKey''), CAST([Лицевой счет] AS varbinary(128))),
            [Номер телефона],
            [Электронная почта],
            COALESCE([Дата регистрации клиента], GETDATE()),
            COALESCE([Время регистрации клиента], CAST(GETDATE() AS TIME))
        FROM inserted;

        CLOSE SYMMETRIC KEY CreditCardSymKey;
    END TRY
    BEGIN CATCH
        IF EXISTS (SELECT 1 FROM sys.openkeys WHERE key_name = ''CreditCardSymKey'')
            CLOSE SYMMETRIC KEY CreditCardSymKey;
        
        THROW;
    END CATCH
END;
');
GO