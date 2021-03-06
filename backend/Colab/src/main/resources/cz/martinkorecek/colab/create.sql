CREATE DATABASE colab;
USE colab;

CREATE TABLE IF NOT EXISTS `user` (
  id 					INT NOT NULL AUTO_INCREMENT,
  username 	 			VARCHAR(45) NOT NULL,
  CONSTRAINT unq_user_username UNIQUE(username),
  password_hash  		VARCHAR(2000) NOT NULL,
  PRIMARY KEY (id)
 );

CREATE TABLE IF NOT EXISTS project (
  id  					INT NOT NULL AUTO_INCREMENT,
  author_id  			INT NOT NULL,
  caption  				VARCHAR(100) NOT NULL,
  description  			TEXT NOT NULL,
  creation_date  		DATETIME NOT NULL DEFAULT NOW(),
  PRIMARY KEY (id)
);

ALTER TABLE project ADD CONSTRAINT FK_PROJECT_AUTHOR_ID_USER_ID FOREIGN KEY (author_id) REFERENCES user(id) ON DELETE CASCADE;

CREATE TABLE IF NOT EXISTS project_comment (
  id  					INT NOT NULL AUTO_INCREMENT,
  author_id  			INT NOT NULL,
  text  				TEXT NOT NULL,
  parent_comment_id  	INT NULL COMMENT 'When subcomment (comment under parent comment)',
  project_id  			INT NOT NULL,
  date  				DATETIME NOT NULL DEFAULT NOW(),
  PRIMARY KEY (id)
);

ALTER TABLE project_comment ADD CONSTRAINT FK_PROJECT_COMMENT_AUTHOR_ID_USER_ID FOREIGN KEY (author_id) REFERENCES user(id) ON DELETE CASCADE;
ALTER TABLE project_comment ADD CONSTRAINT FK_PROJECT_COMMENT_PARENT_COMMENT_ID_PROJECT_COMMENT_ID FOREIGN KEY (parent_comment_id) REFERENCES project_comment(id) ON DELETE CASCADE;
ALTER TABLE project_comment ADD CONSTRAINT FK_PROJECT_COMMENT_PROJECT_ID_PROJECT_ID_idx FOREIGN KEY (project_id) REFERENCES project(id) ON DELETE CASCADE;

CREATE TABLE IF NOT EXISTS project_description_chapter (
	id             INT NOT NULL AUTO_INCREMENT,
    project_id     INT NOT NULL,
    title          VARCHAR(45) NOT NULL,
    text           TEXT NOT NULL,
    chapter_order  INT,
    PRIMARY KEY (id)
);

ALTER TABLE project_description_chapter ADD CONSTRAINT FK_PROJECT_DESCRIPTION_CHAPTER FOREIGN KEY (project_id) REFERENCES project(id) ON DELETE CASCADE;

CREATE TABLE IF NOT EXISTS project_resource (
	id           INT NOT NULL AUTO_INCREMENT,
    project_id   INT NOT NULL,
    link         VARCHAR(2000) NOT NULL,
    link_order   INT,
    PRIMARY KEY (id)
);

ALTER TABLE project_resource ADD CONSTRAINT FK_PROJECT_RESOURCE_PROJECT_ID_PROJECT_ID FOREIGN KEY (project_id) REFERENCES project(id) ON DELETE CASCADE;

