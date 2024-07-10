


INSERT INTO Setting (id, setting_type, setting_name, setting_value) VALUES
(1, 'SourceType', 'course', 1),
(2, 'SourceType', 'challenge', 2),
(3, 'SourceType', 'program', 3),
(4, 'Role', 'Admin', 1),
(5, 'Role', 'Mentor', 2),
(6, 'Role', 'Mentee', 3);


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

INSERT INTO [User] (id, name, location_id, jobtitle_id, role_id, createAt, age, gender, status) VALUES
(1, 'Tai Dang', 1, 1, 2, '2024-06-24 12:00:00', 24, 'Male',1),
(2, 'Tai Pham', 2, 2, 2, '2024-05-24 12:00:00', 28, 'Male',1),
(3, 'Tai Nguyen', 1, 2, 2, '2024-04-24 12:00:00', 30, 'Female',1),
(4, 'Tai Loc', 3, 3, 3, '2024-03-24 12:00:00', 20, 'Male',1),
(5, 'Khoa Nguyen', 1, 2, 2, '2024-06-24 12:00:00', 22, 'Female',0),
(6, 'Dao Vo', 1, 4, 2, '2024-06-24 12:00:00', 30, 'Male',0);

INSERT INTO Category (name) VALUES
('Information Technology'),
('UI/UX Design'),
('Marketing'),
('Lifestyle'),
('Photography'),
('Video');

INSERT INTO Program (id, user_id, program_name, description, price, category_id, asset_id) VALUES
(1, 5, 'Software Engineering Fundamentals', 'Essential software engineering concepts', 33.99, 1, 101),
(2, 6, 'Data Science', 'Data analysis and machine learning mastery', 12.99, 1, 102),
(3, 5, 'Web Development Mastery', 'Interactive e-learning platform', 17.77, 1, 103),
(4, 6, 'Mentoring Hub', 'Personalized professional growth through mentorship', 19.99, 3, 104),
(5, 5, 'Digital Marketing Bootcamp', 'Comprehensive training in digital marketing strategies and tools', 99.99, 2, 105),
(6, 1, 'Machine Learning A-Z', 'Complete machine learning guide', 45.99, 1, 106),
(7, 2, 'Cloud Computing Basics', 'Introduction to cloud services and architecture', 29.99, 4, 107),
(8, 2, 'Cybersecurity Essentials', 'Fundamentals of cybersecurity practices', 39.99, 3, 108),
(9, 3, 'Advanced Java Programming', 'Deep dive into Java programming language', 55.00, 1, 109),
(10, 4, 'Blockchain and Cryptocurrency', 'Understanding blockchain technology and cryptocurrencies', 60.00, 4, 110),
(11, 5, 'Artificial Intelligence for Beginners', 'Basics of AI and its applications', 70.00, 1, 111),
(12, 3, 'Project Management Professional (PMP)', 'Comprehensive PMP certification prep', 80.00, 5, 112),
(13, 4, 'User Experience (UX) Design', 'Designing user-friendly interfaces', 50.00, 2, 113),
(14, 5, 'Mobile App Development with Flutter', 'Building mobile apps using Flutter', 65.00, 4, 114),
(15, 1, 'DevOps and Continuous Integration', 'Introduction to DevOps practices and tools', 75.00, 1, 115);

INSERT INTO Course (name, category_id, price, description, created_at, [user_id], pass_condition) VALUES
('Introduction to Python Programming', 1, 49.99, 'Learn Python programming basics and fundamentals.', CURRENT_TIMESTAMP, 2, 70),
('UI/UX Design Principles', 2, 79.99, 'Explore principles of user interface and user experience design.', CURRENT_TIMESTAMP, 3, 80),
('Digital Marketing Strategies', 3, 59.99, 'Discover effective digital marketing strategies and techniques.', CURRENT_TIMESTAMP, 4, 75),
('Healthy Lifestyle Habits', 4, 29.99, 'Learn practical tips and habits for a healthy lifestyle.', CURRENT_TIMESTAMP, 6, 60),
('Photography Masterclass', 4, 89.99, 'Master the art of photography with professional techniques.', CURRENT_TIMESTAMP, 5, 85),
('Video Production Essentials', 5, 69.99, 'Essential skills and tools for producing high-quality videos.', CURRENT_TIMESTAMP, 2, 80),
('Advanced Data Structures in C++', 6, 99.99, 'Advanced data structures and algorithms in C++ programming language.', CURRENT_TIMESTAMP, 3, 85),
('Introduction to Web Development', 2, 49.99, 'Start your journey into web development with HTML, CSS, and JavaScript.', CURRENT_TIMESTAMP, 5, 70),
('Effective Communication Skills', 3, 39.99, 'Develop effective communication skills for personal and professional success.', CURRENT_TIMESTAMP, 6, 65),
('Financial Planning and Budgeting', 1, 79.99, 'Learn how to plan your finances and create effective budgets.', CURRENT_TIMESTAMP, 5, 75),
('Data Science with R', 1, 59.99, 'An introductory course on data science using R programming language.', CURRENT_TIMESTAMP, 2, 75),
('Graphic Design Basics', 2, 49.99, 'Learn the basics of graphic design and essential tools.', CURRENT_TIMESTAMP, 3, 70),
('Social Media Marketing', 3, 39.99, 'Effective strategies for marketing on social media platforms.', CURRENT_TIMESTAMP, 4, 65),
('Personal Development and Wellness', 4, 29.99, 'Techniques for improving personal development and wellness.', CURRENT_TIMESTAMP, 5, 60),
('Advanced Photography Techniques', 5, 89.99, 'Advanced techniques for professional photography.', CURRENT_TIMESTAMP, 6, 85),
('Video Editing for Beginners', 6, 69.99, 'A beginner�s guide to video editing and essential tools.', CURRENT_TIMESTAMP, 2, 80),
('Machine Learning with Python', 1, 99.99, 'Advanced machine learning concepts and applications using Python.', CURRENT_TIMESTAMP, 3, 85),
('User Experience Research', 2, 79.99, 'Methods and tools for conducting user experience research.', CURRENT_TIMESTAMP, 4, 80),
('Content Marketing Strategies', 3, 59.99, 'Effective strategies for content marketing.', CURRENT_TIMESTAMP, 5, 75),
('Mindfulness and Meditation', 4, 29.99, 'Learn techniques for mindfulness and meditation.', CURRENT_TIMESTAMP, 6, 60),
('Portrait Photography', 5, 89.99, 'Master the art of portrait photography.', CURRENT_TIMESTAMP, 2, 85),
('Advanced Videography', 6, 99.99, 'Advanced techniques and tools for professional videography.', CURRENT_TIMESTAMP, 3, 90),
('Data Analysis with Excel', 1, 49.99, 'Learn how to analyze data effectively using Excel.', CURRENT_TIMESTAMP, 4, 70),
('Design Thinking', 2, 79.99, 'An introduction to design thinking principles and practices.', CURRENT_TIMESTAMP, 5, 80),
('SEO Best Practices', 3, 59.99, 'Learn the best practices for search engine optimization.', CURRENT_TIMESTAMP, 6, 75),
('Healthy Eating Habits', 4, 29.99, 'Develop healthy eating habits for a better lifestyle.', CURRENT_TIMESTAMP, 2, 65),
('Landscape Photography', 5, 89.99, 'Techniques for capturing stunning landscape photos.', CURRENT_TIMESTAMP, 3, 85),
('Film Production Basics', 6, 69.99, 'Learn the basics of film production and essential tools.', CURRENT_TIMESTAMP, 4, 80),
('Introduction to SQL', 1, 49.99, 'Learn SQL for database management and data analysis.', CURRENT_TIMESTAMP, 5, 70),
('Web Accessibility', 2, 79.99, 'Best practices for creating accessible web designs.', CURRENT_TIMESTAMP, 6, 80);

INSERT INTO Challenge (id, user_id, category_id, challenge_name, description, location, phase, start_date) VALUES
(1,1,1, 'Image Classification', 'The challenge is to develop a deep learning model', 'Remote', 'Starting Phase', '2024-06-26'),
(2,2,1, 'Fraud Detection Kaggle', 'Participate in a Kaggle competition', 'HCM', 'Starting Phase', '2024-06-27'),
(3,3,5, 'Short Story Writing', 'Writing a compelling short story', 'Remote', 'Starting Phase', '2024-06-23'),
(4,1,1, 'Data Prediction', 'Predicting data trends using ML', 'Remote', 'Ending Phase', '2024-06-27'),
(5,2, 5, 'Recipe Development', 'Creating new and innovative recipes', 'Remote', 'Ending Phase', '2024-06-23'),
(6,1, 1, 'E-commerce Website', 'Develop a full-stack e-commerce website', 'Remote', 'Starting Phase', '2024-07-01'),
(7,2, 1, 'Sentiment Analysis', 'Analyze sentiment from social media data', 'Remote', 'Starting Phase', '2024-07-01'),
(8,3, 2, 'Mobile App Design', 'Design a mobile app for a retail store', 'Remote', 'Starting Phase', '2024-07-01'),
(9, 3,3, 'Email Marketing Campaign', 'Create an effective email marketing campaign', 'Remote', 'Starting Phase', '2024-07-01'),
(10, 2,4, 'Personal Finance Blog', 'Write blog posts about personal finance', 'Remote', 'Starting Phase', '2024-07-01'),
(11, 5,5, 'Food Photography', 'Capture high-quality photos of food dishes', 'Remote', 'Starting Phase', '2024-07-01'),
(12, 1,6, 'Short Film Editing', 'Edit a short film with provided footage', 'Remote', 'Starting Phase', '2024-07-01'),
(13, 2,1, 'Real-time Chat Application', 'Build a real-time chat application', 'Remote', 'Starting Phase', '2024-07-01'),
(14, 3,2, 'Landing Page Optimization', 'Optimize the landing page of a website', 'Remote', 'Starting Phase', '2024-07-01'),
(15, 6,5, 'Travel Vlog', 'Create a travel vlog with provided footage', 'Remote', 'Starting Phase', '2024-07-01');

INSERT INTO Review (id, source_id, user_id, source_type_id, rating_star, content) VALUES
(1, 2, 1, 3, 3, 'Excellent tool for tracking environmental impact.'),
(2, 2, 2, 3, 4, 'Very helpful for managing patient records.'),
(3, 2, 3, 3, 4, 'Great platform for learning new skills.'),
(4, 4, 4, 3, 4, 'Useful for financial planning.'),
(5, 5, 5, 3, 5, 'Perfect place to showcase handmade products.'),
(6, 1, 1, 2, 4, 'Very insightful introduction to quantum computing.'),
(7, 2, 2, 2, 4, 'Comprehensive digital marketing strategies.'),
(8, 1, 3, 2, 3, 'Great exercises and peer reviews.'),
(9, 2, 4, 2, 3, 'Good coverage of data science techniques.'),
(10, 2, 5, 2, 5, 'Excellent culinary skills development.'),
(11, 1, 1, 1, 5, 'Challenging yet rewarding.'),
(12, 2, 2, 1, 4, 'Learned a lot about social media marketing.'),
(13, 2, 3, 1, 5, 'Fun and engaging short story writing tasks.'),
(14, 1, 4, 1, 5, 'Useful for improving data prediction skills.'),
(15, 1, 5, 1, 5, 'Inspired me to create new recipes.');

INSERT INTO ProgramSource (program_id, source_id, source_type_id, source_order) VALUES
(2, 1, 1, 1),
(2, 2, 1, 3),
(3, 3, 1, 3),
(4, 4, 1, 4),
(5, 5, 1, 5),
(2, 1, 2, 2),
(2, 2, 2, 4),
(3, 3, 2, 8),
(4, 4, 2, 9),
(5, 5, 2, 10);

INSERT INTO ProgramMentor (program_id, user_id) VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 6),
(3, 4),
(3, 5);

INSERT INTO ProgramUser (program_id, user_id, progress_percent, status, startAt) VALUES
(1, 1, 50, 'In Progress', '2024-01-01'),
(2, 2, 30, 'In Progress', '2024-02-01'),
(3, 3, 80, 'Completed', '2024-03-01'),
(2, 1, 69, 'In Progress', '2024-04-01'),
(4, 2, 61, 'In Progress', '2024-05-01'),
(4, 3, 99, 'Completed', '2024-06-01'),
(5, 4, 81, 'Completed', '2024-07-01'),
(5, 6, 72, 'In Progress', '2024-08-01'),
(1, 2, 60, 'In Progress', '2024-07-10'),
(2, 3, 45, 'In Progress', '2024-06-15'),
(3, 4, 90, 'Completed', '2024-07-20'),
(1, 5, 70, 'In Progress', '2024-07-05'),
(5, 2, 95, 'Completed', '2024-06-23'),
(3, 1, 50, 'In Progress', '2024-07-12'),
(4, 1, 60, 'In Progress', '2024-07-08'),
(5, 1, 70, 'In Progress', '2024-07-15'),
(1, 3, 80, 'Completed', '2024-07-25'),
(2, 4, 90, 'Completed', '2024-07-30')


INSERT INTO ChallengeUser (challenge_id, user_id, score, status, date_submission) VALUES
(1, 1, 8, 'Passed', '2024-06-10'),
(2, 1, 6, 'Passed', '2024-05-08'),
(3, 2, 7, 'Passed', '2024-01-23'),
(4, 2, 3, 'Failed', '2024-02-04'),
(5, 3, 5, 'Passed', '2024-08-14'),
(3, 3, 4, 'Failed', '2024-12-17');

INSERT INTO EventLog (id, user_id, source_id, source_type_id, event_time) VALUES
(1, 1, 1, 3, '2024-03-02 00:00:00'),
(2, 1, 1, 1, '2024-03-03 00:00:00'),
(3, 1, 3, 2, '2024-04-04 00:00:00'),
(4, 1, 2, 3, '2024-05-05 00:00:00'),
(5, 3, 2, 1, '2024-06-06 00:00:00'),
(6, 1, 4, 3, '2024-07-07 00:00:00'),
(7, 1, 5, 3, '2024-08-08 00:00:00'),
(8, 1, 3, 3, '2024-09-09 00:00:00'),
(9, 1, 1, 3, '2024-03-05 00:00:00'),
(10, 1, 2, 1, '2024-03-06 00:00:00'),
(11, 1, 3, 2, '2024-04-07 00:00:00'),
(12, 1, 4, 3, '2024-05-08 00:00:00'),
(13, 2, 2, 1, '2024-06-09 00:00:00'),
(14, 2, 4, 3, '2024-07-10 00:00:00'),
(15, 2, 5, 3, '2024-08-11 00:00:00'),
(16, 2, 3, 3, '2024-09-12 00:00:00'),
(17, 3, 1, 3, '2024-03-11 00:00:00'),
(18, 3, 2, 1, '2024-03-12 00:00:00'),
(19, 3, 3, 2, '2024-04-13 00:00:00'),
(20, 3, 4, 3, '2024-05-14 00:00:00');

INSERT INTO PaymentMethod (id, method) VALUES
(1, 'Visa'),
(2, 'Credit / Debit Card');

INSERT INTO Voucher (id, code, source_id, source_type_id, discount, quantity, expire_date) VALUES
(1, 'DISCOUNT10', 1, 3, 10.0, 100, '2024-12-31 23:59:59'),
(2, 'SAVE20', 2, 3, 20.0, 50, '2024-11-30 23:59:59'),
(3, 'OFFER30', 3, 3, 30.0, 25, '2024-10-31 23:59:59'),
(4, 'PROMO15', 4, 3, 15.0, 200, '2024-09-30 23:59:59'),
(5, 'DEAL25', 5, 2, 25.0, 75, '2024-08-31 23:59:59');

INSERT INTO UserPayment (id, user_id, card_name, card_number, expire_date, PaymentMethod_id) VALUES
(1, 1, 'Mentee1223', '****1234', '2024-06-10', 1),
(2, 1, 'Mente4123', '****3232', '2024-06-10', 2);

INSERT INTO [order] (id, user_id, user_payment_id, status, created_at) VALUES
(1, 1, 1, 'Success', '2024-06-10 13:36:00'),
(2, 2, 2, 'Success', '2024-06-09 17:40:00'),
(3, 2, 2, 'Success', '2024-03-01 08:40:00'),
(4, 2, 2, 'Success', '2024-04-02 11:40:00'),
(5, 2, 2, 'Success', '2024-06-10 09:40:00');

INSERT INTO OrderDetails (id, order_id, source_id, source_type_id) VALUES
(1, 1, 1, 3),
(2, 1, 2, 3),
(3, 2, 2, 3),
(4, 2, 4, 3),
(5, 2, 5, 3),
(6, 3, 1, 3),
(7, 3, 2, 3),
(8, 4, 5, 3);



INSERT INTO CartItem (id, user_id, source_id, source_type_id) VALUES
(1, 1, 1, 3),
(2, 1, 2, 3),
(3, 2, 2, 3),
(4, 2, 4, 3),
(5, 2, 5, 3),
(6, 3, 1, 3),
(7, 3, 2, 3),
(8, 4, 5, 3);


INSERT INTO Tag(id, tag_name) VALUES
(1, 'Python'),
(2, 'Data Science'),
(3, 'Selenium'),
(4, 'Web Development'),
(5, 'React'),
(6, 'React Router'),
(7, 'Redux'),
(8, 'NextJS'),
(9, 'React Native'),
(10, 'Jupyter Notebook'),
(11, 'Machine Learning'),
(12, 'Cloud Computing'),
(13, 'Cybersecurity'),
(14, 'Java'),
(15, 'Blockchain'),
(16, 'Cryptocurrency'),
(17, 'Artificial Intelligence'),
(18, 'Project Management'),
(19, 'UX Design'),
(20, 'Flutter'),
(21, 'DevOps');


INSERT INTO SourceTag (source_id, source_type_id, tag_id) VALUES
(1, 3, 4),
(2, 3, 2),
(2, 3, 11),
(3, 3, 4),
(3, 3, 5),
(3, 3, 6),
(3, 3, 7),
(3, 3, 8),
(3, 3, 9),
(4, 3, 18),
(5, 3, 4),
(6, 3, 2),
(6, 3, 11),
(7, 3, 12),
(8, 3, 13),
(9, 3, 14),
(10, 3, 15),
(10, 3, 16),
(11, 3, 17),
(12, 3, 18),
(13, 3, 19),
(14, 3, 20),
(15, 3, 21),
(1, 2, 4),
(1, 2, 5),
(2, 2, 4),
(2, 2, 6),
(3, 2, 4),
(3, 2, 5),
(3, 2, 6),
(3, 2, 7),
(3, 2, 8),
(3, 2, 9),
(4, 2, 4),
(4, 2, 5),
(4, 2, 6),
(5, 2, 4),
(5, 2, 5),
(5, 2, 6),
(6, 2, 4),
(6, 2, 5),
(6, 2, 7), 
(7, 2, 11),
(8, 2, 19),
(8, 2, 20),
(9, 2, 3),
(10, 2, 4),
(11, 2, 5),
(12, 2, 6),
(13, 2, 4),
(13, 2, 5),
(14, 2, 19),
(15, 2, 6);

INSERT INTO SourceImage (asset_id, source_id, source_type_id) VALUES
(1, 1, 3),
(2, 2, 1),
(3, 3, 2),
(4, 4, 3),
(5, 5, 3),
(6, 1, 3),
(7, 2, 2),
(8, 3, 2),
(9, 4, 1),
(10, 1, 3);



INSERT INTO AdsProgram (program_id, startAt, endAt) VALUES
(1, '2024-07-01 00:00:00', '2024-07-31 23:59:59'),
(3, '2024-08-01 00:00:00', '2024-08-15 23:59:59'),
(5, '2024-07-15 00:00:00', '2024-08-15 23:59:59');


INSERT INTO UserOnline (user_id, online_date, online_time) VALUES
(1, '2024-01-15', '08:30:00'),
(2, '2024-01-20', '09:00:00'),
(3, '2024-02-10', '09:15:00'),
(4, '2024-02-18', '09:45:00'),
(5, '2024-04-05', '10:00:00'),
(1, '2024-04-22', '08:30:00'),
(2, '2024-04-14', '09:00:00'),
(3, '2024-04-25', '09:15:00'),
(4, '2024-05-08', '09:45:00'),
(5, '2024-05-19', '10:00:00'),
(1, '2024-06-03', '10:30:00'),
(2, '2024-06-15', '11:00:00'),
(1, '2024-07-02', '11:30:00'),
(2, '2024-07-20', '12:00:00'),
(1, '2024-08-05', '12:30:00'),
(2, '2024-08-16', '10:30:00'),
(3, '2024-09-01', '11:00:00'),
(3, '2024-09-18', '11:30:00'),
(3, '2024-10-10', '12:00:00'),
(2, '2024-10-25', '12:30:00'),
(1, '2024-11-03', '08:30:00'),
(2, '2024-11-14', '09:00:00'),
(3, '2024-12-01', '09:15:00'),
(4, '2024-12-22', '09:45:00'),
(5, '2024-12-31', '10:00:00');

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

INSERT INTO WorkingType(id,name) VALUES
(1 , 'Fulltime'),
(2 , 'Partime'),
(3 , 'Online Program' )

INSERT INTO Experience (id, jobtitle_id, company_id, type_id, user_id,isworking) VALUES 
(1, 1, 1, 1, 1,1),
(2, 3, 2, 2, 2,1);

INSERT INTO University (id, name, img) VALUES 
(1, 'HCMC University of Technology and Education', 'link'),
(2, 'Harvard University', 'link'),
(3, 'Boston University', 'link');

INSERT INTO Education (id, degree, university_id, user_id) VALUES 
(1, 'Bachelor degree', 1, 1),
(2, 'Master degree', 2, 2),
(3, 'Master of Science', 3, 3);

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

INSERT INTO EventUser(id , event_id,user_id) VALUES
(1,1,1),
(2,1,2),
(3,1,3),
(4,2,4)

-- INSERT TABLE config (
--     id INT PRIMARY KEY,
--     config_type VARCHAR(255),
--     config_name VARCHAR(255),
--     config_value VARCHAR(255)  
-- );

-- INSERT TABLE config (id, config_type, config_name, config_value) VALUES 
-- (1, "Trending Program", "Growth in enrollments", 0.4),
-- (2, "Trending Program", "View Activity", 0.3),
-- (3, "Trending Program", "Average Rating", 0.3)

-- Create function to get config value
