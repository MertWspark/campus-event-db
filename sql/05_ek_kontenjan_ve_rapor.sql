-- EK: Ders teslim edildikten sonra eklendi.
--
-- Projenin etkinlik çizeneğinde "Mekan kapasitesi dolu mu?" kontrolü
-- vardı ama ders kapsamında veritabanına uygulanmamıştı. Bu dosya o
-- kuralı veritabanı seviyesinde ekliyor ve bir doluluk raporu sunuyor.
USE kampus_etkinlik;

-- 1) Doluluk raporu: her etkinliğin kayıt sayısı ve doluluk oranı.
--    LEFT JOIN kullanılıyor ki hiç kaydı olmayan etkinlikler de görünsün.
SELECT
  E.Ad                                     AS Etkinlik,
  M.Mekan_Adi                              AS Mekan,
  M.Kapasite,
  COUNT(X.Kayit_ID)                        AS Kayit_Sayisi,
  ROUND(COUNT(X.Kayit_ID) / M.Kapasite * 100, 1) AS Doluluk_Yuzde
FROM Etkinlik E
JOIN Mekan M      ON E.Mekan_Mekan_ID = M.Mekan_ID
LEFT JOIN Kayit X ON X.Etkinlik_Etkinlik_ID = E.Etkinlik_ID
GROUP BY E.Etkinlik_ID, E.Ad, M.Mekan_Adi, M.Kapasite
ORDER BY Doluluk_Yuzde DESC;

-- 2) Kontenjan kontrolü: mekan doluysa yeni kayıt kabul edilmez.
--    Kontrolü uygulamaya bırakmak yerine trigger ile veritabanında
--    yapıyoruz; hangi arayüzden kayıt gelirse gelsin kural geçerli olur.
DELIMITER $$

CREATE TRIGGER trg_kayit_kontenjan
BEFORE INSERT ON Kayit
FOR EACH ROW
BEGIN
  DECLARE v_kayitli  INT;
  DECLARE v_kapasite INT;

  SELECT COUNT(*) INTO v_kayitli
  FROM Kayit
  WHERE Etkinlik_Etkinlik_ID = NEW.Etkinlik_Etkinlik_ID;

  SELECT M.Kapasite INTO v_kapasite
  FROM Etkinlik E
  JOIN Mekan M ON E.Mekan_Mekan_ID = M.Mekan_ID
  WHERE E.Etkinlik_ID = NEW.Etkinlik_Etkinlik_ID;

  IF v_kayitli >= v_kapasite THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Hata: Kontenjan dolu';
  END IF;
END$$

DELIMITER ;
