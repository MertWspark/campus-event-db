-- Kampüs Etkinlik Sistemi — tablo yapısı (MySQL 8)
-- Model MySQL Workbench'te tasarlanıp "Forward Engineer" ile üretildi;
-- burada okunabilir hale getirildi.

CREATE DATABASE IF NOT EXISTS kampus_etkinlik
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_turkish_ci;

USE kampus_etkinlik;

-- Etkinliğe kayıt olan öğrenci veya personel.
CREATE TABLE Kullanici (
  Kullanici_ID INT          NOT NULL AUTO_INCREMENT,
  Ad           VARCHAR(45)  NOT NULL,
  Soyad        VARCHAR(45)  NOT NULL,
  Eposta       VARCHAR(100) NOT NULL,
  PRIMARY KEY (Kullanici_ID),
  UNIQUE KEY uq_kullanici_eposta (Eposta)
) ENGINE = InnoDB;

-- Etkinliklerin yapıldığı yer. Kapasite mekana ait bir bilgi olduğu için
-- etkinlik tablosunda değil burada tutuluyor (2NF).
CREATE TABLE Mekan (
  Mekan_ID   INT         NOT NULL AUTO_INCREMENT,
  Mekan_Adi  VARCHAR(45) NOT NULL,
  Kapasite   INT         NOT NULL,
  PRIMARY KEY (Mekan_ID),
  CONSTRAINT chk_kapasite CHECK (Kapasite > 0)
) ENGINE = InnoDB;

-- Her etkinlik bir mekanda yapılır (Mekan 1 - N Etkinlik).
CREATE TABLE Etkinlik (
  Etkinlik_ID     INT         NOT NULL AUTO_INCREMENT,
  Ad              VARCHAR(45) NOT NULL,
  Tarih           DATE        NOT NULL,
  Saat            TIME        NOT NULL,
  Mekan_Mekan_ID  INT         NOT NULL,
  PRIMARY KEY (Etkinlik_ID),
  INDEX fk_Etkinlik_Mekan_idx (Mekan_Mekan_ID),
  CONSTRAINT fk_Etkinlik_Mekan
    FOREIGN KEY (Mekan_Mekan_ID) REFERENCES Mekan (Mekan_ID)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Kullanıcı ile etkinlik arasındaki çoka-çok ilişkiyi çözen ara tablo.
-- Bir kullanıcı birçok etkinliğe, bir etkinliğe birçok kullanıcı kayıt olabilir.
CREATE TABLE Kayit (
  Kayit_ID                INT  NOT NULL AUTO_INCREMENT,
  Kayit_Tarihi            DATE NOT NULL,
  Kullanici_Kullanici_ID  INT  NOT NULL,
  Etkinlik_Etkinlik_ID    INT  NOT NULL,
  PRIMARY KEY (Kayit_ID),
  -- Aynı kişi aynı etkinliğe iki kez kayıt olamaz.
  UNIQUE KEY uq_kayit_kullanici_etkinlik (Kullanici_Kullanici_ID, Etkinlik_Etkinlik_ID),
  INDEX fk_Kayit_Etkinlik_idx (Etkinlik_Etkinlik_ID),
  CONSTRAINT fk_Kayit_Kullanici
    FOREIGN KEY (Kullanici_Kullanici_ID) REFERENCES Kullanici (Kullanici_ID)
    ON DELETE CASCADE,
  CONSTRAINT fk_Kayit_Etkinlik
    FOREIGN KEY (Etkinlik_Etkinlik_ID) REFERENCES Etkinlik (Etkinlik_ID)
    ON DELETE CASCADE
) ENGINE = InnoDB;
