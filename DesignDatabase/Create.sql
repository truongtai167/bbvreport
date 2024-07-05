
CREATE TABLE Setting (
    id INT PRIMARY KEY,
    setting_type VARCHAR(255),
    setting_name VARCHAR(255),
    setting_value INT
);
CREATE TABLE Jobtitle (
   id INT NOT NULL PRIMARY KEY,
   name VARCHAR(255)
);

CREATE TABLE Location (
   id INT NOT NULL PRIMARY KEY,
   name VARCHAR(255)
);

CREATE TABLE SourceType (
   id INT NOT NULL PRIMARY KEY,
   name VARCHAR(255)
);


CREATE TABLE Userr (
   id INT NOT NULL PRIMARY KEY,
   name VARCHAR(255),
   location_id INT,
   jobtitle_id INT,
   role_id INT,
   createAt DATETIME,
   age INT,
   gender VARCHAR(10),
   FOREIGN KEY (jobtitle_id) REFERENCES Jobtitle(id),
   FOREIGN KEY (location_id) REFERENCES Location(id),
   FOREIGN KEY (role_id) REFERENCES Setting(id)
);

CREATE TABLE Category (
    id INT PRIMARY KEY,
    category_name VARCHAR(255)
);

CREATE TABLE Program (
   id INT NOT NULL PRIMARY KEY,
   name VARCHAR(255),
   category_id INT,
   description VARCHAR(255),
   price INT,
   status VARCHAR(50),
   mentor_id INT,
   image VARCHAR(255),
   FOREIGN KEY (mentor_id) REFERENCES Userr(id),
   FOREIGN KEY (category_id) REFERENCES Category(id)
);

CREATE TABLE Challenge (
   id INT NOT NULL PRIMARY KEY,
   name VARCHAR(255),
   category_id INT,
   description VARCHAR(255),
   mentor_id INT,
   image VARCHAR(255),
   FOREIGN KEY (mentor_id) REFERENCES Userr(id),
   FOREIGN KEY (category_id) REFERENCES Category(id)
);

CREATE TABLE Course (
   id INT NOT NULL PRIMARY KEY,
   name VARCHAR(255),
   category INT,
   description VARCHAR(255),
   price DECIMAL(5,2),
   status VARCHAR(50),
   mentor_id INT,
   image VARCHAR(255),
   FOREIGN KEY (mentor_id) REFERENCES Userr(id)
);

CREATE TABLE FollowUser (
   id INT NOT NULL PRIMARY KEY,
   follower_id INT,
   followee_id INT,
   datefollow DATETIME,
   FOREIGN KEY (follower_id) REFERENCES Userr(id),
   FOREIGN KEY (followee_id) REFERENCES Userr(id)
);

CREATE TABLE SourceTemplate (
   id INT NOT NULL PRIMARY KEY,
   template_id INT,
   source_id INT,
   sourcetype_id INT,
   FOREIGN KEY (sourcetype_id) REFERENCES Setting(id)
);

CREATE TABLE CredentialIssued (
   id INT NOT NULL PRIMARY KEY,
   sourcetemplate_id INT,
   user_id INT,
   credentialcode VARCHAR(50),
   certified_at DATETIME,
   FOREIGN KEY (sourcetemplate_id) REFERENCES SourceTemplate(id),
   FOREIGN KEY (user_id) REFERENCES Userr(id)
);

CREATE TABLE Company (
    id INT NOT NULL PRIMARY KEY,
    name VARCHAR(255),
    img VARCHAR(255)
);

CREATE TABLE Experience (
    id INT NOT NULL PRIMARY KEY,
    jobtitle_id INT,
    company_id INT,
    type VARCHAR(255),
    user_id INT,
    isworking BIT,
    FOREIGN KEY (company_id) REFERENCES Company(id),
    FOREIGN KEY (user_id) REFERENCES Userr(id),
    FOREIGN KEY (jobtitle_id) REFERENCES Jobtitle(id)
);

CREATE TABLE University (
    id INT NOT NULL PRIMARY KEY,
    name VARCHAR(255),
    img VARCHAR(255)
);

CREATE TABLE Education (
    id INT NOT NULL PRIMARY KEY,
    degree VARCHAR(255),
    university_id INT,
    user_id INT,
    FOREIGN KEY (university_id) REFERENCES University(id),
    FOREIGN KEY (user_id) REFERENCES Userr(id)
);

CREATE TABLE ProgramUser (
    id INT NOT NULL PRIMARY KEY,
    user_id INT,
    program_id INT,
    progresspercent INT,
    status VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES Userr(id),
    FOREIGN KEY (program_id) REFERENCES Program(id)
);

CREATE TABLE Post (
    id INT NOT NULL PRIMARY KEY,
    title VARCHAR(255),
    user_id INT,
    views INT,
    FOREIGN KEY (user_id) REFERENCES Userr(id)
);

CREATE TABLE Skill (
    id INT NOT NULL PRIMARY KEY,
    name VARCHAR(255)
);

CREATE TABLE UserSkill (
    id INT NOT NULL PRIMARY KEY,
    user_id INT,
    skill_id INT,
    FOREIGN KEY (user_id) REFERENCES Userr(id),
    FOREIGN KEY (skill_id) REFERENCES Skill(id)
);

CREATE TABLE Event (
    id INT NOT NULL PRIMARY KEY,
    title VARCHAR(255),
    user_id INT,
    views INT,
    FOREIGN KEY (user_id) REFERENCES Userr(id)
);

CREATE TABLE Review (
    id INT NOT NULL PRIMARY KEY,
    receiver_id INT,
    sender_id INT,
    rating INT,
    content VARCHAR(255),
    sourcetype_id INT,
    FOREIGN KEY (sender_id) REFERENCES Userr(id),
    FOREIGN KEY (sourcetype_id) REFERENCES Setting(id)
);
CREATE TABLE AdsProgram (
    program_id INT FOREIGN KEY (program_id) REFERENCES program(id),
    startAt DATETIME,
    endAt DATETIME 
);
