
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
CREATE TABLE [User] (
   id INT PRIMARY KEY,
   name VARCHAR(255),
   location_id INT,
   jobtitle_id INT,
   role_id INT,
   createAt DATETIME,
   age INT,
   gender VARCHAR(10),
   FOREIGN KEY (jobtitle_id) REFERENCES Jobtitle(id),
   FOREIGN KEY (location_id) REFERENCES Location(id),
);

CREATE TABLE Category (
  id INT PRIMARY KEY IDENTITY(1,1),
  name VARCHAR(255)
);

CREATE TABLE Program (
    id INT PRIMARY KEY,
    user_id INT FOREIGN KEY REFERENCES [user](id),
    program_name VARCHAR(255),
    description VARCHAR(255),
    price FLOAT,
    category_id INT FOREIGN KEY REFERENCES category(id),
    asset_id INT
);

CREATE TABLE ProgramUser (
    program_id INT FOREIGN KEY REFERENCES program(id),
    user_id INT FOREIGN KEY REFERENCES [user](id),
    progress_percent FLOAT,
    status VARCHAR(50),
    startAt DATE,
    PRIMARY KEY (program_id, user_id)
);

CREATE TABLE ProgramSource (
    program_id INT FOREIGN KEY REFERENCES program(id),
    source_id INT,
    source_type_id INT,
    source_order INT,
    PRIMARY KEY (program_id, source_id, source_type_id)
);

CREATE TABLE ProgramMentor (
    program_id INT FOREIGN KEY REFERENCES program(id),
    user_id INT FOREIGN KEY REFERENCES [user](id),
    PRIMARY KEY (program_id, user_id)
);

CREATE TABLE Challenge (
    id INT PRIMARY KEY,
	user_id INT FOREIGN KEY REFERENCES [user](id),
    category_id INT FOREIGN KEY REFERENCES category(id),
    challenge_name VARCHAR(255),
    description VARCHAR(255),
    location VARCHAR(255),
    phase VARCHAR(255),
    start_date DATETIME
);

CREATE TABLE ChallengeUser (
    challenge_id INT FOREIGN KEY REFERENCES challenge(id),
    user_id INT FOREIGN KEY REFERENCES [user](id),
    score FLOAT,
    status VARCHAR(255),
    date_submission DATETIME
);

CREATE TABLE SourceImage (
    id INT PRIMARY KEY IDENTITY(1,1),
    asset_id INT,
    source_id INT,
    source_type_id INT
);

CREATE TABLE Course (
  id INT PRIMARY KEY IDENTITY(1,1),
  name NVARCHAR(255),
  category_id INT,
  price DECIMAL(10, 2),
  description TEXT,
  created_at DATETIME,
  [user_id] INT,
  pass_condition INT,
  thumbnail_id INT,
  FOREIGN KEY (category_id) REFERENCES Category(id),
  FOREIGN KEY ([user_id]) REFERENCES [User](id),
  FOREIGN KEY (thumbnail_id) REFERENCES SourceImage(id)
);

CREATE TABLE Review (
    id INT PRIMARY KEY,
    source_id INT,
    user_id INT FOREIGN KEY REFERENCES [user](id),
    source_type_id INT,
    rating_star INT,
    content VARCHAR(255)
);

CREATE TABLE EventLog (
    id INT PRIMARY KEY,
    user_id INT FOREIGN KEY REFERENCES [user](id),
    source_id INT,
    source_type_id INT,
    event_time DATETIME
);

CREATE TABLE PaymentMethod (
    id INT PRIMARY KEY,
    method VARCHAR(255)
);

CREATE TABLE Voucher (
    id INT PRIMARY KEY,
    code VARCHAR(255),
    source_id INT,
    source_type_id INT,
    discount FLOAT,
    quantity INT,
    expire_date DATETIME
);

CREATE TABLE UserPayment (
    id INT PRIMARY KEY,
    user_id INT FOREIGN KEY REFERENCES [user](id),
    card_name VARCHAR(255),
    card_number VARCHAR(255),
    expire_date DATETIME,
    PaymentMethod_id INT FOREIGN KEY REFERENCES PaymentMethod(id)
);

CREATE TABLE [Order] (
    id INT PRIMARY KEY,
    user_id INT FOREIGN KEY REFERENCES [user](id),
    user_payment_id INT FOREIGN KEY REFERENCES UserPayment(id),
    status VARCHAR(255),
    created_at DATETIME
);

CREATE TABLE OrderDetails (
    id INT PRIMARY KEY,
    order_id INT FOREIGN KEY REFERENCES [order](id),
    source_id INT,
    source_type_id INT
);

CREATE TABLE CartItem (
    id INT PRIMARY KEY,
    user_id INT FOREIGN KEY REFERENCES [user](id),
    source_id INT,
    source_type_id INT
);



CREATE TABLE Tag (
    id INT PRIMARY KEY,
    tag_name VARCHAR(255)
);

CREATE TABLE SourceTag (
    source_id INT,
    source_type_id INT,
    tag_id INT,
    PRIMARY KEY (source_id, source_type_id, tag_id)
);

CREATE TABLE AdsProgram (
    program_id INT FOREIGN KEY (program_id) REFERENCES program(id),
    startAt DATETIME,
    endAt DATETIME 
);

CREATE TABLE UserOnline (
    user_id INT FOREIGN KEY REFERENCES [user](id),
    online_date DATETIME,
    online_time VARCHAR(255)
);

CREATE TABLE FollowUser (
   id INT NOT NULL PRIMARY KEY,
   follower_id INT,
   followee_id INT,
   datefollow DATETIME,
   FOREIGN KEY (follower_id) REFERENCES [User](id),
   FOREIGN KEY (followee_id) REFERENCES [User](id)
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
   FOREIGN KEY (user_id) REFERENCES [User](id)
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
    FOREIGN KEY (user_id) REFERENCES [User](id),
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
    FOREIGN KEY (user_id) REFERENCES [User](id)
);

CREATE TABLE Skill (
    id INT NOT NULL PRIMARY KEY,
    name VARCHAR(255)
);

CREATE TABLE UserSkill (
    id INT NOT NULL PRIMARY KEY,
    user_id INT,
    skill_id INT,
    FOREIGN KEY (user_id) REFERENCES [User](id),
    FOREIGN KEY (skill_id) REFERENCES Skill(id)
);

CREATE TABLE Event (
    id INT NOT NULL PRIMARY KEY,
    title VARCHAR(255),
    user_id INT,
    views INT,
    createAt DATETIME
    FOREIGN KEY (user_id) REFERENCES [User](id)
);
CREATE TABLE EventUser (
    id INT PRIMARY KEY,
    event_id INT,
    user_id INT,
    FOREIGN KEY (event_id) REFERENCES Event(id),
    FOREIGN KEY (user_id) REFERENCES [User](id),
);
