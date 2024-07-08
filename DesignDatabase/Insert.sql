INSERT INTO Setting (id, setting_type, setting_name, setting_value) VALUES
(1, 'SourceType', 'course', 1),
(2, 'SourceType', 'challenge', 2),
(3, 'SourceType', 'program', 3),
(4, 'Role', 'Mentee', 1),
(5, 'Role', 'Mentor', 2),
(6, 'Role', 'Admin', 3);
INSERT INTO Jobtitle (id, name) VALUES
(1, 'UI/UX Designer'),
(2, 'Senior Software Engineer'),
(3, 'CEO'),
(4, 'Mentor'),
(5, 'Data Scientist');

INSERT INTO Location (id, name) VALUES
(1, 'Ho Chi Minh'),
(2, 'New York'),
(3, 'Ha Noi'),
(4, 'Chicago');

INSERT INTO SourceType (id, name) VALUES
(1, 'Course'),
(2, 'Challenge'),
(3, 'Program'),
(4, 'M-P'),
(5, 'M-C');

INSERT INTO Category (id, category_name) VALUES
(1, 'Information Technology'),
(2, 'UI/UX Design'),
(3, 'Marketing'),
(4, 'Lifestyle'),
(5, 'Photography'),
(6, 'Video');

INSERT INTO Userr (id, name, location_id, jobtitle_id, role_id, createAt, age, gender) VALUES
(1, 'Tai Dang', 1, 1, 5, '2024-06-24 12:00:00', 24, 'Male'),
(2, 'Tai Pham', 2, 2, 5, '2024-05-24 12:00:00', 28, 'Male'),
(3, 'Tai Nguyen', 1, 2, 5, '2024-04-24 12:00:00', 30, 'Female'),
(4, 'Tai Loc', 3, 3, 4, '2024-03-24 12:00:00', 20, 'Male'),
(5, 'Khoa Ngu', 1, 2, 4, '2024-06-24 12:00:00', 22, 'Female'),
(6, 'Dao Vo', 1, 4, 5, '2024-06-24 12:00:00', 30, 'Male');

INSERT INTO Program (id, name, category, description, price, status, mentor_id, image) VALUES
(1, 'Software', 6, 'Essential software', 33.99, 'Publish', 1, 'AS1'),
(2, 'Data Science', 5, 'Data analysis', 12.99, 'Publish', 2, 'AS2'),
(3, 'Web Development', 4, 'Interactive e-learning', 17.77, 'Publish', 2, 'AS3'),
(4, 'Mentoring Hub', 3, 'Interactive e-learning', 19.99, 'Publish', 1, 'AS4');

INSERT INTO Course (id, name, category, description, price, status, mentor_id, image) VALUES
(1, 'Grow Your Video Editing Skills', 6, 'Essential software', 39.00, 'Publish', 1, 'AS1'),
(2, 'Easy and Creative Food Photography', 5, 'Data analysis and reporting', 59.00, 'Publish', 2, 'AS2'),
(3, 'Create Your Own Sustainable Clothing Brand', 4, 'Interactive e-learning', 29.00, 'Publish', 2, 'AS3'),
(4, 'Grow Your Skills Faster', 3, 'Personalized professional development', 39.00, 'Publish', 1, 'AS4'),
(5, 'UI Design, a User-Centric Approach', 2, 'Comprehensive training', 49.00, 'Publish', 6, 'AS5');

INSERT INTO Challenge (id, name, category, description, mentor_id, image) VALUES
(1, 'Image Classification', 6, 'The challenge is to classify images accurately', 2, 'AS1'),
(2, 'Fraud Detection Kaggle Competition', 5, 'Participate in a Kaggle competition to detect fraud', 1, 'AS2'),
(3, 'Short Story Writing Contest', 4, 'Writing a compelling short story', 2, 'AS3'),
(4, 'Data Prediction Challenge', 3, 'Predicting data trends accurately', 1, 'AS4'),
(5, 'Recipe Development Contest', 2, 'Creating new and innovative recipes', 2, 'AS5');

INSERT INTO FollowUser (id, follower_id, followee_id, datefollow) VALUES
(1, 1, 2, '2022-06-01 10:00:00'),
(2, 4, 1, '2023-05-15 14:30:00'),
(3, 2, 1, GETDATE()),
(4, 3, 2, GETDATE());

INSERT INTO SourceTemplate (id, template_id, source_id, sourcetype_id) VALUES
(1, 1, 4, 1),
(2, 2, 3, 3),
(3, 3, 4, 3),
(4, 5, 1, 2),
(5, 4, 5, 1),
(6, 6, 5, 1),
(7, 7, 5, 2),
(8, 8, 4, 3),
(9, 9, 2, 3),
(10, 10, 2, 2),
(11, 11, 2, 2);

INSERT INTO CredentialIssued (id, sourcetemplate_id, user_id, credentialcode, certified_at) VALUES
(1, 2, 3, '123241', '2024-06-24 12:00:00'),
(2, 3, 3, '453232', '2024-06-24 12:00:00'),
(3, 9, 1, '214234', '2024-06-24 12:00:00'),
(4, 10, 4, '132411', '2024-06-24 12:00:00'),
(5, 4, 1, '234355', '2024-06-24 12:00:00'),
(6, 11, 1, '143452', '2024-06-24 12:00:00');

INSERT INTO Company (id, name, img) VALUES 
(1, 'bbv', 'link'),
(2, 'Microsoft', 'link'),
(3, 'FPT Software', 'link');

INSERT INTO Experience (id, jobtitle_id, company_id, type, user_id,isworking) VALUES 
(1, 1, 1, 'Fulltime', 1,1),
(2, 3, 2, 'Fulltime', 2,1);

INSERT INTO University (id, name, img) VALUES 
(1, 'HCMC University of Technology and Education', 'link'),
(2, 'Harvard University', 'link'),
(3, 'Boston University', 'link');

INSERT INTO Education (id, degree, university_id, user_id) VALUES 
(1, 'Bachelor degree', 1, 1),
(2, 'Master degree', 2, 2),
(3, 'Master of Science', 3, 3);

INSERT INTO Post (id, title, user_id, views) VALUES 
(1, 'Why Creatives Thinking Small', 1, 0),
(2, 'How to finish things and goals', 1, 0),
(3, 'Publication Day Has Arrived', 2, 0);

INSERT INTO Event (id, title, user_id, views, createAt) VALUES 
(1, 'Zero to Hero - UI/UX Designers', 1, 0, '2024-06-29 12:00:00'),
(2, 'Professional AI - Workshop', 1, 0, '2024-07-02 12:00:00'),
(3, 'Hero to zero - Web Developers', 2, 0, '2024-07-03 12:00:00');

INSERT INTO Skill (id, name) VALUES 
(1, 'Design Software'),
(2, 'Research'),
(3, 'User Experience'),
(4, 'User Interface Design');

INSERT INTO UserSkill (id, user_id, skill_id) VALUES 
(1, 1, 3),
(2, 1, 4),
(3, 2, 1);

INSERT INTO Review (id, receiver_id, sender_id, rating, content, sourcetype_id) VALUES
(1, 2, 3, 4.5, 'Excellent tool for tracking environment', 3),
(2, 2, 4, 4, 'Very helpful for managing patient reco', 3),
(3, 2, 5, 4.75, 'Great platform for learning new skills.', 3),
(4, 3, 5, 4.2, 'Useful for financial planning.', 3),
(5, 1, 3, 4.5, 'Very insightful introduction to quantum', 2),
(6, 2, 3, 4, 'Comprehensive digital marketing strategy', 2),
(7, 1, 4, 4.8, 'Great exercises and peer reviews.', 2),
(8, 1, 4, 4.5, 'Challenging yet rewarding.', 1),
(9, 2, 5, 4, 'Learned a lot about social media marketing', 1);

INSERT INTO ProgramUser (id, user_id, program_id, progresspercent, status)
VALUES 
(1, 3, 1, 50, 'In Progress'),
(2, 3, 2, 30, 'In Progress'),
(3, 4, 1, 80, 'Completed'),
(4, 4, 2, 69, 'In Progress'),
(5, 4, 3, 50, 'In Progress'),
(6, 2, 1, 30, 'In Progress');

INSERT INTO AdsProgram (program_id, startAt, endAt) VALUES
(1, '2024-07-01 00:00:00', '2024-07-31 23:59:59'),
(3, '2024-08-01 00:00:00', '2024-08-15 23:59:59'),
(2, '2024-07-15 00:00:00', '2024-08-15 23:59:59');

INSERT INTO EventUser(id , event_id,user_id) VALUES
(1,1,1),
(2,1,2),
(3,1,3),
(4,2,4)