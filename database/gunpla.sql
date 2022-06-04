# 권한 설정
# 필요 없으면 Skip!
grant all privileges on  *.* to 'root'@'%' identified by 'mysql1234';
delete from mysql.user where host="localhost" and user="root";
flush privileges;
select host,user,plugin,authentication_string from mysql.user;

#####
DROP DATABASE IF EXISTS `gunpladb` ;

CREATE DATABASE IF NOT EXISTS `gunpladb` 
  DEFAULT CHARACTER SET utf8 
  DEFAULT COLLATE utf8_general_ci;

USE `gunpladb` ;

CREATE TABLE `mechanic` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `model` VARCHAR(100) NOT NULL,
  `manufacturer` VARCHAR(255) NULL,
  `armor` VARCHAR(255) NULL,
  `height` DECIMAL(7,2) NULL,
  `weight` DECIMAL(7,2) NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARACTER SET utf8 
  DEFAULT COLLATE utf8_general_ci;

CREATE TABLE `gunpla` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `mechanic_id` INT NOT NULL,
  `grade` VARCHAR(45) NOT NULL,
  `date` DATE NULL,
  `price` INT(11) NULL,
  `title` VARCHAR(255) NULL,
  `boxart` VARCHAR(2083) NULL,
  PRIMARY KEY (`id`),
  INDEX (`mechanic_id`),
  FOREIGN KEY (`mechanic_id`) REFERENCES `mechanic` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARACTER SET utf8 
  DEFAULT COLLATE utf8_general_ci;

CREATE TABLE `image` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `gunpla_id` INT NOT NULL,
  `filename` VARCHAR(255) NOT NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX (`gunpla_id`),
  FOREIGN KEY (`gunpla_id`) REFERENCES `gunpla` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARACTER SET utf8 
  DEFAULT COLLATE utf8_general_ci;

CREATE TABLE `armament` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL,
  `description` TEXT NULL,
  `image` VARCHAR(2083) NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARACTER SET utf8 
  DEFAULT COLLATE utf8_general_ci;

CREATE TABLE `equipment` (
  `mechanic_id` INT NOT NULL,
  `armaments_id` INT NOT NULL,
  PRIMARY KEY (`mechanic_id`, `armaments_id`),
  INDEX (`armaments_id`),
  FOREIGN KEY (`mechanic_id`) REFERENCES `mechanic` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`armaments_id`) REFERENCES `armament` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARACTER SET utf8 
  DEFAULT COLLATE utf8_general_ci;

CREATE TABLE `pilot` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `alias` VARCHAR(255) NULL,
  `type` VARCHAR(100) NULL,
  `nationality` VARCHAR(100) NULL,
  `image` VARCHAR(2083) NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARACTER SET utf8 
  DEFAULT COLLATE utf8_general_ci;

CREATE TABLE `boarding` (
  `mechanic_id` INT NOT NULL,
  `pilot_id` INT NOT NULL,
  PRIMARY KEY (`mechanic_id`, `pilot_id`),
  INDEX (`pilot_id`),
  FOREIGN KEY (`mechanic_id`) REFERENCES `mechanic` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`pilot_id`) REFERENCES `pilot` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARACTER SET utf8 
  DEFAULT COLLATE utf8_general_ci;


###############################################

INSERT INTO mechanic (id, name, model, manufacturer, armor, height, weight) VALUES
  (1, '건담', 'RX-78-2', 'Earth Federation', 'Luna Titanium', 18.0, 43.4),
  (2, '건캐논', 'RX-77-2', 'Earth Federation', 'Luna Titanium', 17.5, 51.0),
  (3, '건탱크', 'RX-75', 'Earth Federation', 'Luna Titanium', 15.0, 56.0),
  (4, '짐', 'RGM-79', 'Earth Federation Forces', 'Titanium Alloy', 18.0, 41.2),
  (5, '자쿠 II', 'MS-06F', 'Zeonic Company', 'Super Hard Steel Alloy', 17.5, 58.1),
  (6, '샤아 전용 자쿠 II', 'MS-06S', 'Zeonic Company', 'Super Hard Steel Alloy', 17.5, 56.5),
  (7, '돔', 'MS-09B', 'Zimmad Company', 'Super Hard Steel Alloy', 18.6, 62.6),
  (8, '릭 돔', 'MS-09R', 'Zimmad Company', 'Super Hard Steel Alloy', 18.6, 43.8),
  (9, '즈고크 E', 'MSM-07E', 'MIP Company', 'Titanium Alloy Ceramic Composite', 18.4, 69.5),
  (10, '씨그', 'ZGMF-515', 'Zodiac Alliance of Freedom Treaty', null, 21.43, 80.22),
  (11, '거너 자쿠 워리어', 'ZGMF-1000/A1', 'Integrated Design Bureau', null, 20.50, 91.11),
  (12, '건담 5호기', 'RX-78-5', 'Earth Federation', 'Luna Titanium', 18.0, 42.9),
  (13, '건담 Mk-II', 'RX-178', 'Titans', 'Titanium Alloy Ceramic Composite', 18.5, 33.4),
  (14, '겔구그', 'MS-14A/C', 'Zeonic Company', 'Super Hard Steel Alloy', 19.2, 42.1),
  (15, '겔구그 예거', 'MS-14Jg', 'Zeonic Company', 'Titanium Alloy Ceramic Composite', 19.2, 40.5),
  (16, '고그', 'MSM-03', 'Zimmad Company', 'Super High Tensile Steel', 18.3, 82.4),
  (17, '네모', 'MSA-003', 'Anaheim Electronics', 'Gundarium α Alloy', 18.5, 36.2),
  (18, '뉴건담', 'RX-93', 'Anaheim Electronics', 'Gundarium α Alloy', 18.5, 36.2),
  (19, '레전드 건담', 'ZGMF-X666S', 'Zodiac Alliance of Freedom Treaty', 'Variable Phase Shift armor', 18.66, 86.02),
  (20, '릭디아스', 'RMS-099', 'Anaheim Electronics', 'Gundarium γ Alloy', 18.0, 32.2),
  (21, '마라사이', 'RMS-108', 'Anaheim Electronics', 'Gundarium Alloy', 17.5, 33.1),
  (22, '베르데 버스터 건담', 'GAT-X103AP', 'Actaeon Industries', 'Variable Phase Shift Armor', 18.46, 99.36),
  (23, '블레이즈 자쿠 팬텀', 'ZGMF-1001/M', 'Integrated Design Bureau', null, 20.4, 91.2),
  (24, '스트라이크 건담', 'GAT-X105', 'Earth Alliance', 'Phase Shift Armor', 17.72, 64.8),
  (25, '건담 아스트레이 레드 프레임', 'MBF-P02', 'Morgenroete, Inc.', 'Foaming metal', 17.53, 49.8),
  (26, '알렉스', 'RX-78NT-1', 'Earth Federation', 'Luna Titanium', 18.0, 40.0),
  (27, '주다', 'EMS-10', 'Zimmad Company', 'Hardened Steel', 17.3, 61.0),
  (28, '캠퍼', 'MS-18E', 'Zeonic Company', 'Titanium Alloy Ceramic Composite', 17.7, 43.5),
  (29, '파워드 짐', 'RGM-79', 'Earth Federation', 'Titanium Ceramic Composite', 18.0, 46.6),
  (30, '프리덤 건담', 'ZGMF-X10A', 'Integrated Design Bureau', 'Phase Shift Armor', 18.03, 71.5);
  
INSERT INTO gunpla (id, mechanic_id, grade, date, price, title, boxart) VALUES
  (1, 1, 'MG', '2005-03-01', 3200, 'RX-78-2 Gundam ver. O.Y.W 0079 (PS2 soft)', 'http://ipsumimage.appspot.com/200x150,dfdfdf?s=24&l=RX-78-2%20Gundam%7Cver.%20O.Y.W%200079%7C(PS2%20soft)'),
  (2, 2, 'SD', '2001-11-01', 500, 'Gun Cannon', 'http://ipsumimage.appspot.com/200x150,ffff3f?s=24&l=Gun%20Cannon'),
  (3, 3, 'SD', '2001-08-01', 500, 'Gun Tank', 'http://ipsumimage.appspot.com/200x150,ffff72?s=24&l=Gun%20Tank'),
  (4, 4, 'SD', '2001-04-01', 700, 'GM', 'http://ipsumimage.appspot.com/200x150,ffffd7?s=24&l=GM'),
  (5, 5, 'MG', '2002-09-01', 3000, 'MS-06F2	Zaku II F2 : EFSF 연방군형', 'http://ipsumimage.appspot.com/200x150,3fef3f?s=24&l=%7CMS-06F2%7CZaku%20II%20F2%7CEFSF%20%EC%97%B0%EB%B0%A9%EA%B5%B0%ED%98%95'),
  (6, 6, 'RG', '2010-11-01', 2500, "MS-06S Char's Zaku II", 'http://ipsumimage.appspot.com/200x150,7f7fff?s=24&l=MS-06S%7CChar%27s%20Zaku%20II'),
  (7, 7, 'HGUC', '2006-01-01', 1700, 'MS-09/MS-09R Dom/Rick-Dom', 'http://ipsumimage.appspot.com/200x150,9f7fd2?s=24&l=MS-09%7CMS-09R%20Dom%7CRick-Dom'),
  (8, 8, 'MG', '1999-10-01', 4000, 'MS-09R Rick-Dom', 'http://ipsumimage.appspot.com/200x150,ff7fd2?s=24&l=MS-09R%7CRick-Dom'),
  (9, 9, 'HGUC', '2003-08-01', 1200, "MSM-07E Z'gok Experiment", 'http://ipsumimage.appspot.com/200x150,6f7fff?s=24&l=MSM-07E%7CZ%27gok%20Experiment'),
  (10, 10, 'SEED HG', '2004-04-01', 1200, 'ZGMF-515 Mobile Cgue', 'http://ipsumimage.appspot.com/200x150,afafaf?s=24&l=ZGMF-515%7CMobile%20Cgue'),   
  (11, 11, 'SEED 1/100', '2005-03-01', 2300, 'ZGMF-1000/A1 Gunner Zaku Warrior - 루나마리아 전용', 'http://ipsumimage.appspot.com/200x150,ff4f4f?s=24&l=ZGMF-1000/A1%7CGunner%20Zaku%7CWarrior%7C%EB%A3%A8%EB%82%98%EB%A7%88%EB%A6%AC%EC%95%84%7C%EC%A0%84%EC%9A%A9'),   
  (12, 12, 'MG', '2003-08-01', 2800, 'RX-78-5 Gundam 5호기', 'http://ipsumimage.appspot.com/200x150,ffff4f?s=24&l=RX-78-5%7CGundam%205%ED%98%B8%EA%B8%B0'),  
  (13, 13, 'MG', '2005-10-01', 4000, 'RX-178 Gundam Mk-II v2.0', 'http://ipsumimage.appspot.com/200x150,8f8fff?s=24&l=RX-178%7CGundam%20Mk-II%7Cv2.0'),  
  (14, 14, 'HGUC', '2007-03-01', 1600, 'MS-14A/C Gelgoog/Gelgoog Cannon', 'http://ipsumimage.appspot.com/200x150,8f8f2f?s=24&l=MS-14A/C%7CGelgoog/%7CGelgoog%20Cannon'),  
  (15, 15, 'HGUC', '2004-04-01', 1200, 'MS-14JG	Gelgoog J', 'http://ipsumimage.appspot.com/200x150,ff8f2f?s=24&l=MS-14JG%7CGelgoog%20J'),
  (16, 16, 'SD', '2000-02-01', 500, 'Gogg/Acguy/Zock', 'http://ipsumimage.appspot.com/200x150,8f7fff?s=24&l=Gogg%7CAcguy%7CZock'),
  (17, 17, 'MG', '2006-02-01', 2800, 'MSA-003 Nemo', 'http://ipsumimage.appspot.com/200x150,7fff8f?s=24&l=MSA-003%20Nemo'),
  (18, 18, 'SD', '2000-08-01', 500, 'Nu Gundam', 'http://ipsumimage.appspot.com/200x150,ffffaf?s=24&l=Nu%20Gundam'),
  (19, 19, 'SEED 1/100', '2006-06-01', 2600, 'ZGMF-X666S Legend Gundam', 'http://ipsumimage.appspot.com/200x150,dfdfef?s=24&l=ZGMF-X666S%7CLegend%20Gundam'),
  (20, 20, 'HGUC', '2002-08-01', 1200, 'RMS-099 Rick Dias - 샤아전용', 'http://ipsumimage.appspot.com/200x150,df2f3f?s=24&l=RMS-099%7CRick%20Dias%20%EC%83%A4%EC%95%84%EC%A0%84%EC%9A%A9'),
  (21, 21, 'HGUC', '2005-01-01', 1400, 'RMS-108 Marasai', 'http://ipsumimage.appspot.com/200x150,ff5f5f?s=24&l=RMS-108%7CMarasai'),
  (22, 22, 'SEED HG', '2006-08-01', 1600, 'GAT-X103AP Verde Buster Gundam', 'http://ipsumimage.appspot.com/200x150,7fffaf?s=24&l=GAT-X103AP%7CVerde%20Buster%7CGundam'),
  (23, 23, 'SEED 1/100', '2005-06-01', 2600, 'ZGMF-1001/M Blaze Zaku Phantom - 하이네 전용기', 'http://ipsumimage.appspot.com/200x150,dfdf3f?s=24&l=%7CZGMF-1001/M%7CBlaze%20Zaku%7CPhantom%7C%ED%95%98%EC%9D%B4%EB%84%A4%20%EC%A0%84%EC%9A%A9%EA%B8%B0'),
  (24, 24, 'SD', '2003-02-01', 500, 'Strike Gundam', 'http://ipsumimage.appspot.com/200x150,dfdfdf?s=24&l=Strike%20Gundam'),
  (25, 25, 'SD', '2003-04-01', 500, 'Gundam Astray - Red Frame', 'http://ipsumimage.appspot.com/200x150,df6f4f?s=24&l=Gundam%20Astray%7CRed%20Frame'),
  (26, 26, 'SD', '2004-11-01', 500, 'Gundam NT-1', 'http://ipsumimage.appspot.com/200x150,4f4fdf?s=24&l=Gundam%20NT-1'),
  (27, 27, 'HGUC', '2006-06-01', 1400, 'EMS-10 Zudah', 'http://ipsumimage.appspot.com/200x150,bfbfef?s=24&l=EMS-10%7CZudah'),
  (28, 28, 'MG', '2001-01-01', 4000, 'MS-18E Kämpfer', 'http://ipsumimage.appspot.com/200x150,3f3fef?s=24&l=EMS-18E%7CK%C3%A4mpfer'),
  (29, 29, 'HGUC', '2006-08-01', 1200, 'RGM-79 Powered GM', 'http://ipsumimage.appspot.com/200x150,ff8f4f?s=24&l=RGM-79%7CPowered%20GM'),
  (30, 30, 'SD', '2003-11-01', 500, 'Freedom Gundam', 'http://ipsumimage.appspot.com/200x150,dfdfff?s=24&l=Freedom%20Gundam'),
  
  (31, 1, 'SD', '1999-10-01', 500, 'RX-78 Gundam', 'http://ipsumimage.appspot.com/200x150,dfdfdf?s=24&l=RX-78%7CGundam'),
  (32, 5, 'HGUC', '2003-09-01', 1000, 'MS-06 Zaku II - 양산형', 'http://ipsumimage.appspot.com/200x150,3fef3f?s=24&l=%7CMS-06%7CZaku%20II%7C%EC%96%91%EC%82%B0%ED%98%95g'),
  (33, 5, 'SD', '2001-07-01', 500, 'MS-06F Zaku II', 'http://ipsumimage.appspot.com/200x150,2fff2f?s=24&l=MS-06F%7CZaku%20II'),
  (34, 6, 'SD', '2002-03-01', 500, 'MS-06S Zaku II 샤아전용', 'http://ipsumimage.appspot.com/200x150,ff2f2f?s=24&l=%7CMS-06S%7CZaku%20II%7C%EC%83%A4%EC%95%84%EC%A0%84%EC%9A%A9'),
  (35, 7, 'SD', '2000-05-01', 400, 'Dom', 'http://ipsumimage.appspot.com/200x150,3f3f3f?s=24&l=Dom'),
  (36, 11, 'SD', '2005-07-01', 600, 'Gunner Zaku Warrior', 'http://ipsumimage.appspot.com/200x150,ff3f3f?s=24&l=Gunner%20Zaku%7CWarrior'),
  (37, 13, 'SD', '2001-06-01', 500, 'Gundam Mk-II Titans', 'http://ipsumimage.appspot.com/200x150,3f3fff?s=24&l=Gundam%20Mk-II%7CTitans'),
  (38, 18, 'HGUC', '2008-03-01', 2500, 'RX-93 υ Gundam', 'http://ipsumimage.appspot.com/200x150,dfdf33?s=24&l=RX-93%7C%CF%85%20Gundam'),
  (39, 22, 'SD', '2007-04-01', 600, 'Verde Buster Gundam', 'http://ipsumimage.appspot.com/200x150,7fff6f?s=24&l=Verde%20Buster%7CGundam'),
  (40, 23, 'SD', '2007-07-01', 600, 'Blaze Zaku Phantom (Heine Custom)', 'http://ipsumimage.appspot.com/200x150,ffff2f?s=24&l=Blaze%20Zaku%7CPhantom%7C(Heine%20Custom)'),
  (41, 25, 'SEED HG', '2003-11-01', 1200, 'MBF-P02 Gundam Astray Red Frame', 'http://ipsumimage.appspot.com/200x150,ff4f2f?s=24&l=MBF-P02%7CGundam%20Astray%7CRed%20Frame');
  
  
INSERT INTO image (id, gunpla_id, filename, description) VALUES
  (null, 1, 'gundam.png', '세로로 긴 이미지'),
  (null, 31, '건담.jpg', '귀여운 SD'),
  (null, 1, '건담mg.jpg', '파스텔 톤 좋아'),
  (null, 1, '건담mg2.jpg', '옆 모습도 멋지군'),
  (null, 1, '건담mg3.jpg', '멋있는 MG'),
  (null, 1, '건담mg4.jpg', 'mg3 파일을 세로로 길게 crop'),
  (null, 2, '건캐논.jpg', 'SD의 위용'),
  (null, 2, '건캐논2.jpg', '앙증맞은 SD'),
  (null, 3, '건탱크.jpg', 'SD에 투명 파츠까지'),
  (null, 3, '건탱크2.jpg', 'SD 위화감이 없어'),
  (null, 4, '짐mini.jpg', '어 이거 SD 아닌데'),
  (null, 5, '자쿠IImg.jpg', '육중한 위압감'),
  (null, 5, '자쿠IImg2.jpg', '구 버전이라도 멋지다'),
  (null, 5, '자쿠IImg3.jpg', '역시 모노아이'),
  (null, 32, '자쿠II.jpg', 'HGUC 자쿠II'),
  (null, 33, '자쿠IIsd.jpg', 'SD지만 육중함은 그대로'),
  (null, 6, '자쿠II샤아전용.jpg', '3배 빠른 자쿠'),
  (null, 34, '자쿠II샤아전용sd.jpg', '귀엽고 3배 빠른 자쿠'),
  (null, 7, '돔.jpg', '튼튼한 돔'),
  (null, 35, '릭돔sd.jpg', '이거 릭돔이 아니고 돔이었구나'),
  (null, 8, '릭돔.jpg', '릭돔은 볼륨감이 좋아서 전체 샷이 멋진데'),
  (null, 9, '즈고크E.jpg', '카리스마 짱'),
  (null, 9, '즈고크E.jpg', '숨겨진 보물같은 킷'),
  (null, 10, '모빌씨그.jpg', '전설의 야수와 같은 모습'),
  (null, 11, '건너자쿠워리어.jpg', '독일군 헬멧'),
  (null, 36, '건너자쿠워리어sd.jpg', 'SD가 더 근엄한 듯'),
  (null, 36, '건너자쿠워리어sd2.jpg', 'SD지만 전투력이 높을 듯'),
  (null, 36, '건너자쿠워리어sd3.jpg', '의기 양양'),
  (null, 12, '건담5호기.jpg', '알록달록 이쁘다'),
  (null, 12, '건담5호기2.jpg', '기대하지 않았는데 만족도가 높았던 킷'),
  (null, 12, '건담5호기3.jpg', '얼굴도 알록달록'),
  (null, 12, '건담5호기4.jpg', '너무 멋져~'),
  (null, 13, '건담Mk-II에우고.jpg', '강렬한 눈빛'),
  (null, 13, '건담Mk-II에우고2.jpg', '헤드폰 착용샷'),
  (null, 37, '건담Mk-II티탄즈.jpg', 'SD에서 박력이 느껴져'),
  (null, 37, '건담Mk-II티탄즈2.jpg', '흔치 않은 컬러'),
  (null, 37, '건담Mk-II티탄즈미니.jpg', '이건 SD 아닌데'),
  (null, 14, '겔구그.jpg', '멧돼지'),
  (null, 15, '겔구그예거.jpg', '울퉁불퉁 멋진 킷'),
  (null, 15, '겔구그예거2.jpg', '전투력 높을 것 같아'),
  (null, 16, '고그.jpg', '해산물 3종 세트 중 하나. 너무 귀여워'),
  (null, 17, '네모.jpg', '만족도 엄청 높았던 킷. 또 하나의 숨겨진 보물'),
  (null, 18, '뉴건담sd.jpg', '인기 높은 뉴건담. 뉴건담이야 누 건담이야'),
  (null, 18, '뉴건담sd2.jpg', '체구에 비해 큰 백팩'),
  (null, 38, '뉴건담.jpg', '먹선을 너무 흐리게 넣었나'),
  (null, 19, '레전드건담.jpg', '무등급이지만 박력있는 백팩'),
  (null, 20, '릭디아스샤아전용.jpg', '사진빨 안받네'),
  (null, 21, '마라사이.jpg', '이 킷도 좋았음'),
  (null, 22, '베르데버스터건담.jpg', '그저 그런'),
  (null, 39, '베르데버스터건담sd.jpg', 'SD가 HGUC보다 박력있다'),
  (null, 23, '블레이즈자쿠팬텀.jpg', '무등급이지만 좋다'),
  (null, 40, '블레이즈자쿠팬텀sd.jpg', '먹선 안 넣어도 멋져'),
  (null, 40, '블레이즈자쿠팬텀sd2.jpg', '쌍도끼. 어쎄신 크리드 발할라 찍냐'),
  (null, 24, '스트라이크건담.jpg', '스트라이크 건담은 모든 등급이 다 잘 뽑힌듯'),
  (null, 24, '스트라이크건담2.jpg', '너무 가까워'),
  (null, 24, '스트라이크건담3.jpg', 'SD치고는 롱다리'),
  (null, 25, '아스트레이레드sd.jpg', 'SD 얼굴 귀여워'),
  (null, 41, '아스트레이레드.jpg', '독특한 근육 몸매. 가동률 좋음'),
  (null, 26, '알렉스.jpg', '주머니 속의 전쟁 주인공 기체'),
  (null, 26, '알렉스2.jpg', '개틀링 건도 장착 가능'),
  (null, 27, '주다.jpg', '개성 만점. 강추'),
  (null, 28, '캠퍼.jpg', '건담이 아닌 다른 애니메이션에 등장할 법한 특이한 외형이지만 좋다. 버니어 색분할 압권'),
  (null, 29, '파워드짐.jpg', '폭죽이라 놀리지 마라'),
  (null, 29, '파워드짐2.jpg', '심플한 매력'),
  (null, 30, '프리덤건담.jpg', '인기 많은 기체'),
  (null, 30, '프리덤건담2.jpg', 'MG의 화려함을 따라가기엔 부족'),
  (null, 30, '프리덤건담3.jpg', '인기 많은 기체 답게 뭐가 많이 달려있다');
  