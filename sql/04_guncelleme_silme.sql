-- Güncelleme ve silme işlemleri
USE kampus_etkinlik;

-- Unity atölyesinin saati ve mekanı değişti.
UPDATE Etkinlik
SET Saat = '21:00', Mekan_Mekan_ID = 1
WHERE Etkinlik_ID = 2;

SELECT * FROM Etkinlik;

-- Bir kullanıcı kaydını iptal etti.
DELETE FROM Kayit
WHERE Kayit_ID = 4;

SELECT * FROM Kayit;
