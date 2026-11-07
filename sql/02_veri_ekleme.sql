-- Örnek veriler. Kişi adları ve e-postalar kurgusaldır.
USE kampus_etkinlik;

INSERT INTO Mekan (Mekan_Adi, Kapasite) VALUES
  ('Atatürk Konferans Salonu', 250),
  ('Fen Fakültesi Amfisi', 150),
  ('Kampüs Spor Salonu', 500),
  ('Mühendislik Seminer Odası', 60),
  ('Kütüphane Toplantı Odası', 30);

INSERT INTO Kullanici (Ad, Soyad, Eposta) VALUES
  ('Ali', 'Kaplan', 'ali.kaplan@example.com'),
  ('Elif', 'Aydın', 'elif.aydin@example.com'),
  ('Can', 'Özdemir', 'can.ozdemir@example.com'),
  ('Ayşe', 'Yılmaz', 'ayse.yilmaz@example.com'),
  ('Deniz', 'Kaya', 'deniz.kaya@example.com');

INSERT INTO Etkinlik (Ad, Tarih, Saat, Mekan_Mekan_ID) VALUES
  ('AI ve Gelecek Konferansı',       '2026-06-15', '14:00', 1),
  ('Unity Oyun Geliştirme Atölyesi', '2026-06-20', '10:00', 4),
  ('Kampüs Bahar Konseri',           '2026-05-30', '20:00', 3),
  ('Veri Bilimi Semineri',           '2026-06-05', '13:00', 2),
  ('Girişimcilik Zirvesi',           '2026-06-25', '11:00', 1);

INSERT INTO Kayit (Kayit_Tarihi, Kullanici_Kullanici_ID, Etkinlik_Etkinlik_ID) VALUES
  ('2026-05-15', 1, 2),  -- Ali, Unity atölyesine
  ('2026-05-15', 2, 1),  -- Elif, AI konferansına
  ('2026-05-16', 3, 3),  -- Can, bahar konserine
  ('2026-05-16', 4, 1),  -- Ayşe, AI konferansına
  ('2026-05-17', 5, 5);  -- Deniz, girişimcilik zirvesine
