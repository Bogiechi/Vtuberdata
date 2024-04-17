CREATE TABLE `vtuberdata`.`VtuberSuperChat`(
    `itemId` VARCHAR(50) NOT NULL,
    `period` INT NOT NULL,
    `channelPlayCount` FLOAT NOT NULL,
    `subscriberCount` FLOAT NOT NULL,
    `subscriberFluc` FLOAT NOT NULL,
    `maxLiveViewer` VARCHAR(50) NOT NULL,
    `donationAmount` FLOAT NOT NULL,
    `donationCount` INT NOT NULL,
    `rank` INT NOT NULL,
    `rankFluc` VARCHAR(10) NOT NULL,
    `start_date` VARCHAR(50) NOT NULL,
    `end_date` VARCHAR(50) NOT NULL,
    `name` VARCHAR(50) NOT NULL
);
