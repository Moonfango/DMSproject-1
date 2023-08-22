CREATE TABLE `mcategory` (
  `categoryid` int PRIMARY KEY,
  `category` varchar(255),
  `categoryactive` bool,
  `createdate` datetime
);

CREATE TABLE `mdepartment` (
  `deptid` int PRIMARY KEY,
  `deptname` varchar(255),
  `deptactive` bool,
  `createdate` datetime
);

CREATE TABLE `mrole` (
  `roleid` int PRIMARY KEY,
  `rolename` varchar(255),
  `rolecreatedate` datetime,
  `roleactive` bool
);

CREATE TABLE `mstaff` (
  `staffid` int PRIMARY KEY,
  `staffname` varchar(255),
  `staffdeptid` int,
  `staffrole` int,
  `username` varchar(255),
  `staffpwd` varchar(255),
  `staffemail` varchar(255),
  `staffmobile` varchar(255),
  `staffmgr` int,
  `createdate` datetime,
  `staffactive` bool
);

CREATE TABLE `mworkflow` (
  `workflowid` int PRIMARY KEY,
  `workflowname` varchar(255),
  `refdeptid` int,
  `wfdesc` varchar(255)
);

CREATE TABLE `mworkflowdefinition` (
  `wfdefinitionid` int PRIMARY KEY,
  `refworkflowid` int,
  `seqno` int,
  `roleid` int,
  `wfcreatedate` datetime,
  `wfactive` bool
);

CREATE TABLE `trxdocucheckinout` (
  `checkid` bigint PRIMARY KEY,
  `refdocuid` bigint,
  `checkoutdate` datetime,
  `checkindate` datetime,
  `refstaffid` int,
  `checkoutreason` varchar(255)
);

CREATE TABLE `trxdocurequest` (
  `requestid` bigint PRIMARY KEY,
  `refdocumentid` bigint,
  `refdeptid` int,
  `requestby` int,
  `requestdate` datetime,
  `reqstatus` varchar(255),
  `reqapprovedby` int,
  `reqreason` varchar(255)
);

CREATE TABLE `trxdocustore` (
  `documentid` bigint PRIMARY KEY,
  `refdeptid` int,
  `refcategoryid` int,
  `docuname` varchar(255),
  `docudescription` text,
  `docucreatedate` datetime,
  `docucreatedby` varchar(255),
  `jsondetails` json,
  `docuversion` varchar(255),
  `docuactive` bool,
  `docucheckinoutstatus` tinyint
);

CREATE TABLE `trxloginaudit` (
  `loginauditid` bigint PRIMARY KEY,
  `fkstaffid` int,
  `logindate` datetime,
  `loginotp` int,
  `otpverificationstatus` varchar(255),
  `ipaddress` varchar(255)
);

CREATE TABLE `trxworkflow` (
  `twfid` bigint PRIMARY KEY,
  `fkworkflowid` int,
  `fkwfdefinitionid` int,
  `fkdocumentid` bigint,
  `fkseqno` int,
  `fkassignedroleid` int,
  `fkassignedstaffid` int,
  `wfassignedate` datetime,
  `wfcompletiondate` datetime,
  `wfstatus` varchar(255),
  `wfapprovedrejectstaffid` int
);

ALTER TABLE `mstaff` ADD FOREIGN KEY (`staffdeptid`) REFERENCES `mdepartment` (`deptid`);

ALTER TABLE `mstaff` ADD FOREIGN KEY (`staffrole`) REFERENCES `mrole` (`roleid`);

ALTER TABLE `mworkflow` ADD FOREIGN KEY (`refdeptid`) REFERENCES `mdepartment` (`deptid`);

ALTER TABLE `mworkflowdefinition` ADD FOREIGN KEY (`refworkflowid`) REFERENCES `mworkflow` (`workflowid`);

ALTER TABLE `mworkflowdefinition` ADD FOREIGN KEY (`roleid`) REFERENCES `mrole` (`roleid`);

ALTER TABLE `trxdocucheckinout` ADD FOREIGN KEY (`refdocuid`) REFERENCES `trxdocustore` (`documentid`);

ALTER TABLE `trxdocucheckinout` ADD FOREIGN KEY (`refstaffid`) REFERENCES `mstaff` (`staffid`);

ALTER TABLE `trxdocurequest` ADD FOREIGN KEY (`refdocumentid`) REFERENCES `trxdocustore` (`documentid`);

ALTER TABLE `trxdocurequest` ADD FOREIGN KEY (`refdeptid`) REFERENCES `mdepartment` (`deptid`);

ALTER TABLE `trxdocurequest` ADD FOREIGN KEY (`requestby`) REFERENCES `mstaff` (`staffid`);

ALTER TABLE `trxdocurequest` ADD FOREIGN KEY (`reqapprovedby`) REFERENCES `mstaff` (`staffid`);

ALTER TABLE `trxdocustore` ADD FOREIGN KEY (`refdeptid`) REFERENCES `mdepartment` (`deptid`);

ALTER TABLE `trxdocustore` ADD FOREIGN KEY (`refcategoryid`) REFERENCES `mcategory` (`categoryid`);

ALTER TABLE `trxloginaudit` ADD FOREIGN KEY (`fkstaffid`) REFERENCES `mstaff` (`staffid`);

ALTER TABLE `trxworkflow` ADD FOREIGN KEY (`fkworkflowid`) REFERENCES `mworkflow` (`workflowid`);

ALTER TABLE `trxworkflow` ADD FOREIGN KEY (`fkwfdefinitionid`) REFERENCES `mworkflowdefinition` (`wfdefinitionid`);

ALTER TABLE `trxworkflow` ADD FOREIGN KEY (`fkdocumentid`) REFERENCES `trxdocustore` (`documentid`);

ALTER TABLE `trxworkflow` ADD FOREIGN KEY (`fkassignedroleid`) REFERENCES `mrole` (`roleid`);

ALTER TABLE `trxworkflow` ADD FOREIGN KEY (`fkassignedstaffid`) REFERENCES `mstaff` (`staffid`);

ALTER TABLE `trxworkflow` ADD FOREIGN KEY (`wfapprovedrejectstaffid`) REFERENCES `mstaff` (`staffid`);
