CREATE TRIGGER [dbo].[Продление_услуги_при_оплате]
ON [dbo].[Платежи]
AFTER INSERT
AS
BEGIN
    UPDATE u
    SET u.[Дата окончания] = DATEADD(MONTH, 1, u.[Дата окончания])
    FROM [Услуги по договору] u
    INNER JOIN inserted i ON u.[id договора] = i.[id договора]
    WHERE u.[Активна] = 1;
END;