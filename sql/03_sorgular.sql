-- Sorgular
USE kampus_etkinlik;

-- 1) Basit sorgu: Mayıs 2026'daki etkinlikler (tarih aralığına göre listeleme).
SELECT *
FROM Etkinlik
WHERE Tarih BETWEEN '2026-05-01' AND '2026-05-31';

-- 2) JOIN: hangi öğrenci hangi etkinliğe, nerede ve ne zaman kayıt olmuş.
--    Dört tablo birleştiriliyor: Kayit ara tablosu üzerinden Kullanici ve
--    Etkinlik'e, Etkinlik üzerinden de Mekan'a gidiliyor.
SELECT
  E.Ad          AS `Etkinlik Adı`,
  M.Mekan_Adi   AS `Mekan`,
  K.Ad          AS `Öğrenci Adı`,
  K.Soyad       AS `Soyadı`,
  K.Eposta      AS `E-Posta Adresi`,
  X.Kayit_Tarihi AS `Kayıt Tarihi`
FROM Kayit X
JOIN Kullanici K ON X.Kullanici_Kullanici_ID = K.Kullanici_ID
JOIN Etkinlik  E ON X.Etkinlik_Etkinlik_ID   = E.Etkinlik_ID
JOIN Mekan     M ON E.Mekan_Mekan_ID         = M.Mekan_ID
ORDER BY X.Kayit_Tarihi, E.Ad;

-- 3) Raporlama (yönetici senaryosu): bir etkinliğe kayıtlı öğrencilerin listesi.
SELECT K.Ad, K.Soyad, K.Eposta, X.Kayit_Tarihi
FROM Kayit X
JOIN Kullanici K ON X.Kullanici_Kullanici_ID = K.Kullanici_ID
WHERE X.Etkinlik_Etkinlik_ID = 1
ORDER BY K.Soyad;
