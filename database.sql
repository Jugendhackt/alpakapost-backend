-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.1.36-MariaDB - MariaDB Server
-- Server OS:                    Linux
-- HeidiSQL Version:             9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for alpakapost
CREATE DATABASE IF NOT EXISTS `alpakapost` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `alpakapost`;

-- Dumping structure for table alpakapost.goods
CREATE TABLE IF NOT EXISTS `goods` (
  `good_id` int(11) NOT NULL AUTO_INCREMENT,
  `dimension_x` decimal(5,2) NOT NULL DEFAULT '0.00',
  `dimension_y` decimal(5,2) NOT NULL DEFAULT '0.00',
  `dimension_z` decimal(5,2) NOT NULL DEFAULT '0.00',
  `start_location_id` int(11) NOT NULL DEFAULT '0',
  `destination_location_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`good_id`),
  KEY `FK_goods_hackerspaces` (`start_location_id`),
  KEY `FK_goods_hackerspaces_2` (`destination_location_id`),
  CONSTRAINT `FK_goods_hackerspaces` FOREIGN KEY (`start_location_id`) REFERENCES `hackerspaces` (`hackerspace_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_goods_hackerspaces_2` FOREIGN KEY (`destination_location_id`) REFERENCES `hackerspaces` (`hackerspace_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alpakapost.goods: ~0 rows (approximately)
/*!40000 ALTER TABLE `goods` DISABLE KEYS */;
/*!40000 ALTER TABLE `goods` ENABLE KEYS */;

-- Dumping structure for table alpakapost.hackerspaces
CREATE TABLE IF NOT EXISTS `hackerspaces` (
  `hackerspace_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo_url` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` decimal(10,7) DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL,
  PRIMARY KEY (`hackerspace_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=136 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alpakapost.hackerspaces: ~133 rows (approximately)
/*!40000 ALTER TABLE `hackerspaces` DISABLE KEYS */;
INSERT IGNORE INTO `hackerspaces` (`hackerspace_id`, `name`, `logo_url`, `latitude`, `longitude`) VALUES
	(1, '/dev/tal', 'http://devtal.de/logo.png', 51.2670186, 7.1453920),
	(2, 'AFRA', 'https://afra-berlin.de/dokuwiki/lib/exe/fetch.php?', 52.5082224, 13.4961541),
	(3, 'Mainframe', 'http://status.mainframe.io/assets/static/logo.png', 53.1440200, 8.2198800),
	(4, '57North Hacklab', 'https://57north.org.uk/wiki_logo.png', 57.1472950, -2.1062290),
	(5, 'Breizh-Entropy', 'http://wiki.breizh-entropy.org/glider.png', 48.1060000, -1.6510000),
	(6, 'Binary Kitchen', 'https://www.binary-kitchen.de/wiki/lib/exe/fetch.p', 49.0098529, 12.1189821),
	(7, 'Bytespeicher', 'https://pbs.twimg.com/profile_images/3788000007695', 50.9827100, 11.0396500),
	(8, 'ACKspace', 'https://ackspace.nl/w/images/3/3b/Wiki_logo.png', 50.8924622, 5.9712601),
	(9, 'Bitlair', 'https://bitlair.nl/state/logo.png', 52.1773230, 5.4147820),
	(10, 'CCCHH', 'https://wiki.hamburg.ccc.de/images/7/7f/Ccc-hambur', 53.5583600, 9.9445900),
	(11, 'CCC Mannheim', 'https://www.ccc-mannheim.de/spaceapi/logo.png', 49.4636900, 8.4886200),
	(12, 'C3D2', 'https://www.c3d2.de/images/ck.png', 51.0810791, 13.7286123),
	(13, 'ChaosStuff', 'http://wiki.c3l.lu/lib/exe/fetch.php?media=organiz', 49.6207090, 6.1225810),
	(14, 'CCC Cologne', 'https://koeln.ccc.de/images/C4-logo_transparent_bl', 50.9504142, 6.9129647),
	(15, 'Chaosdorf', 'https://wiki.chaosdorf.de/images/1/1d/ChaosdorfLog', 51.2165600, 6.7834700),
	(16, 'Chaostreff Flensburg e.V.', '', 54.8045000, 9.4234100),
	(17, 'Chaos Computer Club Zürich', 'https://www.ccczh.ch/theme/images/chaosknoten_cccz', 8.5248260, 47.3930600),
	(18, 'Chaos Computer Club Basel', 'https://wiki.chaostreff.ch/skins/Ccc2.png', 47.5323266, 7.6342312),
	(19, 'Chaostreff Bern', 'https://www.chaostreffbern.ch/images/logo_v1.0.png', 46.9477000, 7.4157000),
	(20, 'DevLoL', 'http://devlol.org/static_wiki/DevLoL.png', 48.3057300, 14.2838300),
	(21, 'coredump', 'https://www.coredump.ch/wp-content/uploads/2016/11', 47.2359607, 8.8410057),
	(22, 'Salzburg', 'https://wiki.sbg.chaostreff.at/_media/logo.png', 47.7942740, 13.0558340),
	(23, 'Arch Reactor', 'https://archreactor.org/sites/default/files/bwarni', NULL, NULL),
	(24, 'Chaostreff Chemnitz', 'http://chaoschemnitz.de/chch_logo.png', 50.8306590, 12.9395370),
	(25, 'Eigenbaukombinat Halle e.V.', 'http://eigenbaukombinat.de/wp-content/uploads/2013', 51.4799600, 11.9922100),
	(26, 'Entropia', 'https://entropia.de/wiki/images/e/ed/Teebeutel1_no', 49.0067000, 8.4074380),
	(27, 'FAU FabLab', 'https://fablab.fau.de/spaceapi/static/logo_transpa', 49.5740000, 11.0300000),
	(28, 'Frack', 'https://frack.nl/w/Frack-logo.png', 53.1997015, 5.8005792),
	(29, 'FabLab Nürnberg', 'http://files.fablab-nuernberg.de/Pressekit/logo_hd', 49.4604503, 11.0292046),
	(30, 'Forschung und Technik e.V.', 'https://spaceapi.futev.de/logo.png', 52.4859360, 7.3330120),
	(31, 'FIXME', 'https://fixme.ch/sites/default/files/Logo5_v3-mini', 46.5323720, 6.5912920),
	(32, 'GeekLabs', 'http://www.geeklabs.dk/lib/exe/fetch.php?t=1463955', 55.4646900, 8.4596080),
	(33, 'Freies Labor', 'https://blog.freieslabor.org/images/logo.svg', 52.1686250, 9.9472320),
	(34, 'Hack42', 'https://hack42.nl/mediawiki/logos/logo_try2.png', 52.0374600, 5.9026000),
	(35, 'Hackeriet', 'https://hackeriet.no/comotion-sjn-transparent-1.2.', 59.9192930, 10.7534750),
	(36, 'Hackerspace Bielefeld e.V.', 'https://hackerspace-bielefeld.de/spacestatus/hacke', 52.0382240, 8.5330560),
	(37, 'HTU Graz - E-Lab', 'http://edv-support.htu.tugraz.at/doorothy/static/e', 47.0583400, 15.4592880),
	(38, 'HTU Graz - Basisgruppe Informatik', 'http://edv-support.htu.tugraz.at/doorothy/static/l', 47.0588700, 15.4592880),
	(39, 'HTU Graz - Basisgruppe Telematik', 'http://edv-support.htu.tugraz.at/doorothy/static/i', 47.0588170, 15.4594730),
	(40, 'H.A.C.K.', 'https://hsbp.org/img/hack.gif', 47.4891670, 19.0594440),
	(41, 'CCCHB', 'https://ccchb.de/logo/CCCHB-logo_256x256_bw.png', 53.0815000, 8.8154000),
	(42, 'Hackspace Manchester', 'http://spaceapi.hacman.org.uk/img/hackspace-black.', 53.4841670, -2.2361600),
	(43, 'Hacklab', 'http://hacklab.kiev.ua/wp-content/uploads/2014/02/', 30.4917790, 50.4784800),
	(44, 'Hacklabor', 'http://hacklabor.de/assets/img/logo/Logo_Large_bla', 53.6011000, 11.4183000),
	(45, 'HacDC', 'http://www.hacdc.org/wp-content/themes/hacdc/image', 38.9335500, -77.0358540),
	(46, 'IT-Syndikat', 'http://it-syndikat.org/api/images/its_l.png', 47.2578000, 11.3961000),
	(47, 'K4CG', 'https://k4cg.org/images/thumb/b/b9/Logo_leiter.png', 49.4480000, 11.0820000),
	(48, 'LeineLab', 'https://leinelab.org/logo.png', 52.3714840, 9.7198910),
	(49, 'Le Loop', 'https://wiki.leloop.org/images/thumb/1/17/LeLoop-b', 48.8485850, 2.3856770),
	(50, 'LAG', 'http://laglab.org/logo.png', 52.3540600, 4.8542300),
	(51, 'Laboratoire Ouvert Grenoblois', 'https://www.logre.eu/logo-color-big.png', 45.1849500, 5.7112900),
	(52, 'Maakplek', 'http://www.maakplek.nl/maakplek.jpg', 53.2097200, 6.5674410),
	(53, 'Krautspace', 'https://status.krautspace.de/images/krautspace_pix', 50.9292000, 11.5826000),
	(54, 'Lambdaspace', 'https://www.lambdaspace.gr/dist/favicons/apple-tou', 22.9394253, 40.6373204),
	(56, 'London Hackspace', 'https://london.hackspace.org.uk/images/london.png', 51.5538700, -0.2900200),
	(57, 'Laboratorio Hacker de Campinas', 'http://lhc.net.br//w/images/lhc.png', -22.9081486, -47.0771249),
	(58, 'Makerspace Erfurt', 'https://pbs.twimg.com/profile_images/8601197132544', 50.9732510, 11.0368850),
	(59, 'MakeSpace Madrid', 'http://makespacemadrid.org/spaceapi/logo.png', 40.3995250, -3.7024460),
	(60, 'Maschinendeck', 'http://maschinendeck.org/images/blacktocat.png', 49.7580970, 6.6560690),
	(61, 'Do It Yourself Werkstatt Wilhelmshaven', 'http://www.diyww.de/wp-content/uploads/2017/03/diy', 53.5172670, 8.0939900),
	(62, 'HSBNE', 'https://hsbne.org/assets/img/headerlogo.png', -27.4432052, 153.0770233),
	(63, 'i3Detroit', 'https://www.i3detroit.org/blog/wp-content/uploads/', NULL, NULL),
	(64, 'Hackerspace KRK', 'http://hackerspace-krk.pl/wp-content/themes/hskrk/', 50.0660850, 19.9433590),
	(65, 'Munich Maker Lab', 'https://wiki.munichmakerlab.de/w/images/mumalab.pn', 48.1587520, 11.5482333),
	(66, 'MuCCC', 'http://muc.ccc.de/lib/tpl/muc3/images/muc3_klein.g', 48.1536700, 11.5607800),
	(67, 'MidsouthMakers', 'http://www.midsouthmakers.org/images/MM-SpaceAPI-L', 35.2022460, -89.8676330),
	(68, 'Motionlab Berlin', 'http://motionlab.berlin/wp-content/uploads/2017/11', 52.4937883, 13.4482159),
	(69, 'NURDSpace', 'http://nurdspace.nl/spaceapi/logo.png', 51.9732730, 5.6696810),
	(70, 'Netz39', 'http://www.netz39.de/wiki/_media/resources:public_', 52.1195610, 11.6293980),
	(71, 'Milwaukee Makerspace', 'http://apps.2xlnetworks.net/milwaukeemakerspace/im', 42.9980850, -87.8984840),
	(72, 'Netzladen', 'http://netzladen.org/api/netzladen_logo.jpg', 50.7396374, 7.0965597),
	(73, 'Open Space Aarhus', 'http://osaa.dk/wp-uploads/wiki_logo.png', 56.1732918, 10.1872507),
	(74, 'P\'yŏngyang Hackerspace', 'http://status.pyongyanghackerspace.org/rogo.png', 39.0580560, 125.7683330),
	(75, 'Neotopia', 'http://cccgoe.de/w/images/thumb/8/8e/NOK.png/100px', 51.5453300, 9.9452600),
	(76, 'Pangloss Labs #1', 'http://panglosslabs.org/logo.png', 46.2594700, 6.1077250),
	(77, 'Nova Labs', 'http://nova-labs.org/images/nova-labs_icon_160x160', 38.9545500, -77.3387690),
	(78, 'Pixelbar', 'https://www.pixelbar.nl/public/logo.png', 51.9101110, 4.4339880),
	(79, 'Post Tenebras Lab', 'https://www.posttenebraslab.ch/images/logo_ptl_m.p', 46.1871350, 6.1336595),
	(80, 'Polytechnischer Werkraum Zittau', 'https://werkraum.freiraumzittau.de/wiki/_media/log', 50.8974715, 14.8043893),
	(81, 'RevSpace', 'https://revspace.nl/mediawiki/RevspaceLogoOnGreen.', 52.0777306, 4.3901992),
	(82, 'Swansea Hackspace', 'http://swansea.hackspace.org.uk/logo.png', 51.6193000, -3.9397000),
	(83, 'Stratum 0', 'https://stratum0.org/mediawiki/images/thumb/c/c6/S', 52.2785658, 10.5211247),
	(84, 'Quelab', 'http://quelab.net/wordpress/wp-content/uploads/201', 35.1030000, -106.6530000),
	(85, 'Tarlab', 'http://tarlab.fi/images/tarlab-oulu_logo.png', 25.4831393, 65.0254440),
	(86, 'Technologia Incognita', 'http://techinc.nl/space/logo.png', 52.3455580, 4.8264660),
	(87, 'TDVenlo', 'http://www.tdvenlo.nl/logo.jpg', 51.3707860, 6.1712700),
	(88, 'Terminal.21 Basislager', 'http://download.terminal21.de/terminal21/logo/logo', 51.4799600, 11.9922100),
	(89, 'Toolbox Bodensee e.V.', 'https://toolbox-bodensee.de/images/logo.svg', 47.7120000, 9.3990000),
	(90, 'Umeå Hackerspace', 'http://umeahackerspace.se/wp-content/uploads/2014/', 63.8232600, 20.2820800),
	(91, 'VoidWarranties', 'http://wiki.voidwarranties.be/images/5/59/Voidwarr', 51.2086830, 4.4534350),
	(92, 'Tangleball', 'http://upload.wikimedia.org/wikipedia/commons/thum', 174.7552140, -36.8600940),
	(93, 'The Bodgery', '', -89.3101386, 43.0918570),
	(94, 'TkkrLab', 'https://tkkrlab.nl/images/TkkrLab.png', 52.2223880, 6.8724350),
	(95, '[hsmr] Hackspace Marburg', 'https://hsmr.cc/logo.svg', 50.8075289, 8.7677467),
	(96, 'c-base', 'http://www.c-base.org/C-logo_claim_blue.png', 52.5123630, 13.4197520),
	(97, 'UrLab', 'https://urlab.be/static/img/space-invaders.png', 50.8129150, 4.3843960),
	(98, 'flipdot', 'https://flipdot.org/wiki/logo?action=AttachFile&do', 51.3182536, 9.4848149),
	(99, 'nbsp', 'http://nobreakspace.org/status/images/logo.png', 53.8688000, 10.6712000),
	(100, 'mag.lab', 'https://state.maglab.space/logo.png', 50.5588677, 9.6775469),
	(101, 'realraum', 'https://realraum.at/logo-red_250x250.png', 47.0655540, 15.4504350),
	(102, 'hackzogtum', 'https://spaceapi.hackzogtum-coburg.de/logo.png', 50.2685090, 10.9506830),
	(103, 'Warsaw Hackerspace', 'https://static.hackerspace.pl/img/syrenka-black.pn', 52.2416000, 20.9848500),
	(104, 'see-base', 'https://bodensee.space/images/logos/see-base.gif', 47.7725200, 9.1999700),
	(105, 'init Lab', 'https://fauna.initlab.org/assets/initlab-logo-73ee', 42.7078925, 23.3252709),
	(106, 'backspace', 'https://www.hackerspace-bamberg.de/skins/kiwi/imag', 49.9019270, 10.8927390),
	(107, 'shackspace - stuttgart hackerspace', 'https://rescue.shackspace.de/images/logo_shack_bri', 48.7770000, 9.2360000),
	(108, 'vspace.one', 'https://vspace.one/pic/logo_vspaceone.svg', 48.0650020, 8.4564950),
	(109, 'Attraktor Makerspace', 'https://spaceapi.attraktor.org/logo.png', 53.5498443, 9.9466610),
	(110, 'Level2', 'https://files.level2.lu/logos/level2.png', 49.6162900, 6.0705700),
	(111, 'verschwoerhaus', 'https://verschwoerhaus.de/wp-content/uploads/2016/', 48.3964563, 9.9904232),
	(112, 'xHain', 'https://x-hain.de/images/global/xhain_logo.svg', 13.4493919, 52.5128150),
	(113, 'bytewerk', 'http://bytewerk.org/images/d/d0/Sw_logo.png', 48.7708200, 11.3818200),
	(114, 'BinarySpace', 'http://www.binaryspace.co.za/logo_small.png', 27.8330000, -26.7090000),
	(115, 'Bastli', 'https://people.ee.ethz.ch/~bastli/wiki/images/3/30', 47.3786100, 8.5492400),
	(116, 'Chaostreff Dortmund', 'https://www.chaostreff-dortmund.de/presse/logo/log', 51.5276110, 7.4649449),
	(117, 'Chaosconsulting', 'http://chaos-consulting.de/gfx/cc_header.png', 51.3743500, 7.6980300),
	(118, 'Hackerspace.gr', 'https://www.hackerspace.gr/images/Hackerspace.png', 38.0169500, 23.7312400),
	(119, 'chaospott', 'http://chaospott.de/images/logo.png', 51.4384760, 7.0249910),
	(120, 'Chaostreff Recklinghausen c3RE', 'http://wiki.c3re.de/images/4/49/Logo_weiss_rund_sc', 51.6243559, 7.1690102),
	(121, 'Hacksaar', 'https://www.hacksaar.de/logo.png', 49.2404310, 6.9738170),
	(122, 'OpenLab Augsburg', 'https://api.openlab-augsburg.de/static/logo_400px.', 48.3577100, 10.8867970),
	(123, 'Edinburgh Hacklab', 'http://edinburghhacklab.com/spaceapi/logo.png', 55.9397970, -3.1816200),
	(124, 'Reaktor 23', 'http://spaceapi.reaktor23.org/reaktor23-logo.png', 47.6293420, 8.2628610),
	(126, 'DAI Makerspace', 'https://www.i-share-economy.org/kos/picture-cache/', 49.4079200, 8.6939000),
	(127, 'CCCFr', 'https://cccfr.de/status/icons/logo_cccfr_hnp.png', 47.9931940, 7.8405020),
	(128, 'turmlabor', 'https://www.turmlabor.de/images/status_logo.svg', 51.0270900, 13.7235800),
	(129, 'nordlab e. V.', 'http://nordlab-ev.de/img/null.png', 54.7916140, 9.4423670),
	(130, 'TechTonik Labs', 'https://lh3.googleusercontent.com/-eUiLFGZtE4o/AAA', 34.4323700, -119.8484200),
	(131, 'Wolfplex Hackerspace', 'http://www.wolfplex.be/img/logo496.png', 50.4060300, 4.4688400),
	(132, 'Ko-Lab', 'https://ko-lab.space/wp-content/uploads/2018/04/Lo', 51.0221080, 4.4827800),
	(133, 'Minsk Hackerspace', 'https://hackerspace.by/images/default.png', 53.9428700, 27.5974900),
	(134, 'Nottinghack', 'https://lspace.nottinghack.org.uk/status/logo.png', 52.9557000, -1.1350000),
	(135, 'Perth Artifactory', 'http://artifactory.org.au/branding/artifactory-log', -31.9018460, 115.8101360);
/*!40000 ALTER TABLE `hackerspaces` ENABLE KEYS */;

-- Dumping structure for table alpakapost.user
CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int(10) unsigned NOT NULL,
  `user_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bio` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telegram` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mastodon` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `twitter` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobile` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table alpakapost.user: ~0 rows (approximately)
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
