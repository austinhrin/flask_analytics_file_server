-- -----------------------------------------------------
-- create user
-- -----------------------------------------------------
INSERT INTO users (email, first_name, last_name)
	SELECT * FROM (SELECT 'test@gmail.com', 'Austin', 'Hrin') AS temp
	WHERE NOT EXISTS (
		SELECT email FROM users WHERE email = 'test@gmail.com'
	) LIMIT 1;

-- -----------------------------------------------------
-- create website
-- -----------------------------------------------------
INSERT INTO websites (domain)
	SELECT * FROM (SELECT 'austinhrin.com') AS temp
	WHERE NOT EXISTS (
		SELECT domain FROM websites WHERE domain = 'austinhrin.com'
	) LIMIT 1;

-- -----------------------------------------------------
-- create analytics url path
-- -----------------------------------------------------
INSERT INTO analytics_url_path (url_path)
	SELECT * FROM (SELECT '/') AS temp
    WHERE NOT EXISTS (
		SELECT url_path FROM analytics_url_path WHERE url_path = '/'
	) LIMIT 1;

-- -----------------------------------------------------
-- create analytics user agent
-- -----------------------------------------------------
INSERT INTO analytics_user_agent (user_agent)
	SELECT * FROM (SELECT '5.0/mozilla') AS temp
    WHERE NOT EXISTS (
		SELECT user_agent FROM analytics_user_agent WHERE user_agent = '5.0/mozilla'
	) LIMIT 1;

-- -----------------------------------------------------
-- create analytics browser fingerprint
-- -----------------------------------------------------
INSERT INTO analytics_browser_fingerprint (browser_fingerprint)
	SELECT * FROM (SELECT '1234567890') AS temp
    WHERE NOT EXISTS (
		SELECT browser_fingerprint FROM analytics_browser_fingerprint WHERE browser_fingerprint = '1234567890'
	) LIMIT 1;

-- -----------------------------------------------------
-- create analytics screen info
-- -----------------------------------------------------
INSERT INTO analytics_screen_info (screen_info)
	SELECT * FROM (SELECT '1920x1080') AS temp
    WHERE NOT EXISTS (
		SELECT screen_info FROM analytics_screen_info WHERE screen_info = '1920x1080'
	) LIMIT 1;

-- -----------------------------------------------------
-- create analytics
-- -----------------------------------------------------
INSERT INTO analytics (
		user_id,
		website_id,
		url_path_id,
		ip,
        date_time,
		cookie,
		user_agent_id,
		browser_fingerprint_id,
		screen_info_id)
	VALUES (
		(SELECT user_id FROM users WHERE email='test@gmail.com'),
		(SELECT website_id FROM websites WHERE domain='austinhrin.com'),
        (SELECT url_path_id FROM analytics_url_path WHERE url_path='/'),
        '127.0.0.1',
        CURRENT_TIMESTAMP(),
        'this is a cookie',
        (SELECT user_agent_id FROM analytics_user_agent WHERE user_agent='5.0/mozilla'),
        (SELECT browser_fingerprint_id FROM analytics_browser_fingerprint WHERE browser_fingerprint='1234567890'),
        (SELECT screen_info_id FROM analytics_screen_info WHERE screen_info='1920x1080'));