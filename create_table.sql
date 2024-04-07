CREATE TABLE `vtuberdata`.`VtuberSC`(
    `itemId` VARCHAR(50) NOT NULL,
    `channelPlayCount` FLOAT NOT NULL,
    `subscriberCount` FLOAT NOT NULL,
    `subscriberFluc` FLOAT NOT NULL,
    `maxLiveViewer` INT NOT NULL,
    `donationAmount` FLOAT NOT NULL,
    `donationCount` INT NOT NULL,
    `rank` INT NOT NULL,
    `rankFluc` VARCHAR(10) NOT NULL,
    `name` VARCHAR(50) NOT NULL,
    `date` VARCHAR(50) NOT NULL
);
