OPEN SYMMETRIC KEY CreditCardSymKey
    DECRYPTION BY PASSWORD = 'artemkoncevoj4';

SELECT 
    ID,
    ���,
    �������,
    ��������,
    CAST(DECRYPTBYKEY([������� ����]) AS BIGINT) AS ��������������_�������_����,
    [����� ��������],
    [����������� �����],
    [���� ����������� �������]
FROM �������;

CLOSE SYMMETRIC KEY CreditCardSymKey;