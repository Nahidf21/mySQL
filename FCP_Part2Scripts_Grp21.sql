FCP: European Football League
Group 21
Ron Budnar, Nahid Ferdous, Misikir Tesfaye, Amanda Williams
ISQS 6338
Summer 2023


----------- CLEAR EXISTING DATA ------------

DROP TABLE IF EXISTS `team_fixture`;
DROP TABLE IF EXISTS `fixture`;
DROP TABLE IF EXISTS `team_season_division`;
DROP TABLE IF EXISTS `division`;
DROP TABLE IF EXISTS `league`;
DROP TABLE IF EXISTS `League`;
DROP TABLE IF EXISTS `team`;
DROP TABLE IF EXISTS `season`;
DROP TABLE IF EXISTS `referee`;

----------- CREATE TABLES ------------

CREATE TABLE G21.season (
  seasonID INT PRIMARY KEY AUTO_INCREMENT,
  seasonName VARCHAR(255)
);

CREATE TABLE G21.team (
    teamID INT PRIMARY KEY AUTO_INCREMENT,
    teamName VARCHAR(100)
);

CREATE TABLE G21.league (
  leagueID INT PRIMARY KEY AUTO_INCREMENT,
  leagueName VARCHAR(255)
);

CREATE TABLE G21.division (
  divisionID INT PRIMARY KEY AUTO_INCREMENT,
  divisionName VARCHAR(255),
  leagueID INT,
  FOREIGN KEY (leagueID) REFERENCES G21.league(leagueID)
);

CREATE TABLE G21.referee (
  refID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(50)
);

CREATE TABLE G21.fixture (
  fixtureID INT PRIMARY KEY AUTO_INCREMENT,
  seasonID INT,
  refID INT,
  Date DATE,
  Time TIME,
  htr CHAR(1),
  ftr CHAR(1),
  FOREIGN KEY (refID) REFERENCES G21.referee(refID),
  FOREIGN KEY (seasonID) REFERENCES G21.season(seasonID)
);

CREATE TABLE G21.team_fixture (
  teamId INT,
  fixtureId INT,
  isHome bool,
  shots SMALLINT,
  shotsTarget SMALLINT,
  corners SMALLINT,
  fouls SMALLINT,
  yellowCards SMALLINT,
  redCards SMALLINT,
  goalsHT SMALLINT,
  goalsFT SMALLINT,
  PRIMARY KEY (teamId, fixtureId),
  FOREIGN KEY (teamId) REFERENCES G21.team(teamID),
  FOREIGN KEY (fixtureId) REFERENCES G21.fixture(fixtureID)
);

CREATE TABLE G21.team_season_division (
  teamID INT,
  seasonID INT,
  divisionID INT,
  PRIMARY KEY (teamID, seasonID),
  FOREIGN KEY (seasonID) REFERENCES G21.season(seasonID),
  FOREIGN KEY (divisionID) REFERENCES G21.division(divisionID),
  FOREIGN KEY (teamID) REFERENCES G21.team(teamID)
);


----------- INSERT DATA ------------

INSERT INTO G21.league (leagueName)
    SELECT DISTINCT league AS leagueName
    FROM fcp_2023.results_csv;

INSERT INTO G21.division (divisionName, leagueID)
    SELECT DISTINCT `div` AS divisionID, l.leagueId
    FROM fcp_2023.results_csv r
    JOIN G21.league l on r.league = l.leagueName;

INSERT INTO G21.season (seasonName)
    SELECT DISTINCT season AS seasonName
    FROM fcp_2023.results_csv;

INSERT INTO G21.team(teamName) 
    SELECT DISTINCT homeTeam 
        FROM fcp_2023.results_csv
    UNION 
        SELECT DISTINCT awayTeam 
        FROM fcp_2023.results_csv;

INSERT INTO G21.referee(Name) 
    SELECT DISTINCT referee
    FROM fcp_2023.results_csv results
    where TRIM(referee) <> '';

INSERT INTO G21.fixture (seasonID,refID,Date,Time,htr,ftr)
    SELECT 
        seasonId,
        refId,
        date,
        time,
        htr,
        ftr
    FROM fcp_2023.results_csv results
    JOIN G21.season s on results.season = s.seasonName
    LEFT JOIN G21.referee refs on results.referee = refs.Name;

INSERT INTO G21.team_fixture(teamId,fixtureId,isHome,shots,shotsTarget,corners,fouls,yellowCards,redCards,goalsHT,goalsFT)
SELECT 
    t.teamId,
    fixtureID,
    1 isHome,
    hs shots,
    hst shotsTarget,
    hc corners,
    hf fouls,
    hy yellowCards,
    hr redCards,
    hthg goalsHT,
    fthg goalsFT
FROM fcp_2023.results_csv r
join G21.team t on t.teamName = r.homeTeam
join G21.fixture f on f.date = r.date and f.time = r.time and f.ftr = r.ftr and f.htr = r.htr;

INSERT INTO G21.team_fixture(teamId,fixtureId,isHome,shots,shotsTarget,corners,fouls,yellowCards,redCards,goalsHT,goalsFT)
    SELECT 
        t.teamId,
        fixtureID,
        0 isHome,
        `as` shots,
        ast shotsTarget,
        ac corners,
        af fouls,
        ay yellowCards,
        ar redCards,
        htag goalsHT,
        ftag goalsFT
    FROM fcp_2023.results_csv r
    join G21.team t on t.teamName = r.awayTeam
    join G21.fixture f on f.date = r.date and f.time = r.time and f.ftr = r.ftr and f.htr = r.htr;

INSERT INTO G21.team_season_division (teamId, seasonId, divisionID)
    SELECT DISTINCT teamId, seasonId, divisionID 
    FROM fcp_2023.results_csv r
    JOIN G21.team t on t.teamName = r.homeTeam
    JOIN G21.season s on s.seasonName = r.season
    JOIN G21.division d on d.divisionName = r.`div`
    UNION
    SELECT DISTINCT teamId, seasonId, divisionID 
    FROM fcp_2023.results_csv r
    JOIN G21.team t on t.teamName = r.awayTeam
    JOIN G21.season s on s.seasonName = r.season
    JOIN G21.division d on d.divisionName = r.`div`;

----------- CHECK DATA MATCHES ORIGINAL SOURCE ------------

SELECT
    l.leagueName league,
    s.seasonName season,
    d.divisionName `div`,
    m.date,
    m.time,
    homeTeamName.teamName homeTeam,
    awayTeamName.teamName awayTeam,
    homeTeam.goalsFT fthg,
    awayTeam.goalsFT ftag,
    m.ftr,
    homeTeam.goalsHT hthg,
    awayTeam.goalsHT htag,
    m.htr,
    r.name referee,
    homeTeam.shots hs,
    awayTeam.shots `as`,
    homeTeam.shotsTarget hst,
    awayTeam.shotsTarget ast,
    homeTeam.fouls hf,
    awayTeam.fouls af,
    homeTeam.corners hc,
    awayTeam.corners ac,
    homeTeam.yellowCards hy,
    awayTeam.yellowCards ay,
    homeTeam.redCards hr,
    awayTeam.redCards ar
FROM fixture m
    JOIN season s on m.seasonID = s.seasonId
    JOIN team_fixture homeTeam on m.fixtureID = homeTeam.fixtureID and homeTeam.isHome = 1
    JOIN team homeTeamName on homeTeamName.teamId = homeTeam.teamId
        JOIN team_season_division tsd on tsd.seasonId = m.seasonId and homeTeam.teamId = tsd.teamId
        JOIN division d on tsd.divisionId = d.divisionID
        JOIN league l on l.leagueID = d.leagueId
    JOIN team_fixture awayTeam on m.fixtureID = awayTeam.fixtureID and awayTeam.isHome = 0
    JOIN team awayTeamName on awayTeamName.teamId = awayTeam.teamId
    LEFT JOIN referee r on m.refID = r.refID