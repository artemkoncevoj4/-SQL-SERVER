CREATE TRIGGER [dbo].[���������_������_���_������]
ON [dbo].[�������]
AFTER INSERT
AS
BEGIN
    UPDATE u
    SET u.[���� ���������] = DATEADD(MONTH, 1, u.[���� ���������])
    FROM [������ �� ��������] u
    INNER JOIN inserted i ON u.[id ��������] = i.[id ��������]
    WHERE u.[�������] = 1;
END;