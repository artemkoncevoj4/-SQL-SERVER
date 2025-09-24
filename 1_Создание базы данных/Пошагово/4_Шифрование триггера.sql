-- ������� ������� (����� ��� ��������)
EXEC sp_helptext '[dbo].[����������_��������_�����]';

-- ������������� �������
EXEC('
ALTER TRIGGER [dbo].[����������_��������_�����]
ON [dbo].[�������]
WITH ENCRYPTION
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        OPEN SYMMETRIC KEY CreditCardSymKey
            DECRYPTION BY PASSWORD = ''artemkoncevoj4'';

        INSERT INTO ������� (���, �������, ��������, [������� ����], [����� ��������], 
                           [����������� �����], [���� ����������� �������], [����� ����������� �������])
        SELECT 
            ���, 
            �������, 
            ��������,
            ENCRYPTBYKEY(KEY_GUID(''CreditCardSymKey''), CAST([������� ����] AS varbinary(128))),
            [����� ��������],
            [����������� �����],
            COALESCE([���� ����������� �������], GETDATE()),
            COALESCE([����� ����������� �������], CAST(GETDATE() AS TIME))
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