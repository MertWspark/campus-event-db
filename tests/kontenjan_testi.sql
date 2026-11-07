-- Kontenjan kuralının testi (01-05 dosyaları çalıştırıldıktan sonra).
USE kampus_etkinlik;

-- AI konferansının mekanını test için 2 kişilik yapalım.
-- Etkinlik 1'de şu an 1 kayıt var (Elif).
UPDATE Mekan SET Kapasite = 2 WHERE Mekan_ID = 1;

-- 2. kişi: kabul edilir.
INSERT INTO Kayit (Kayit_Tarihi, Kullanici_Kullanici_ID, Etkinlik_Etkinlik_ID)
VALUES ('2026-05-18', 3, 1);

-- 3. kişi: reddedilmeli -> "Hata: Kontenjan dolu"
INSERT INTO Kayit (Kayit_Tarihi, Kullanici_Kullanici_ID, Etkinlik_Etkinlik_ID)
VALUES ('2026-05-18', 5, 1);
