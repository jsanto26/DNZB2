/********************************************************************************************
NAME: [dbo].[vw_Customers]
PURPOSE: Create the view [dbo].[vw_Customers]
SUPPORT: Jose Santos
	  
MODIFICATION LOG:
Ver   Date        Author    Description
----  ----------  -------   -----------------------------------------------------------------
1.0   11/03/2019  JoseSantos  1. Built this script to create the view [dbo].[vw_Customers].
RUNTIME: 
1 min
NOTES: 
How much are the loans in years (2019, 2018, 2017, 2016)?
LICENSE: 
This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.
********************************************************************************************/
--2) Total of Existents Customers and New Customers (2019)
CREATE VIEW vw_Customer
As
SELECT DISTINCT 
       cd.cust_id
     , ca.acct_id
     , cd.gender
     , Year(ad.cust_since_date) AS Start_Year
     , ad.open_close_code AS Status_Account
     , DATENAME(M, cd.birth_date) AS Birth_month
     , DATEDIFF(Month, cd.cust_since_date, GETDATE()) / 12 AS Years_Client
     , DATEDIFF(Month, cd.birth_date, GETDATE()) / 12 AS Age
     , cd.Branch_id
  FROM dbo.tblCustomerDim AS cd
       INNER JOIN
       dbo.tblCustomer_AccountDim AS ca ON cd.cust_id = ca.cust_id
       INNER JOIN
       dbo.tblAccountFact AS af ON ca.acct_id = af.acct_id
       INNER JOIN
       dbo.tblAccountDim AS ad ON af.acct_id = ad.acct_id
       INNER JOIN
       dbo.tblCustomerRoleDim AS cr ON ca.acct_cust_role_id = cr.Customer_role_id
 GROUP BY cd.gender,
        ,ad.cust_since_date
        , cd.cust_id
        , cd.cust_since_date
        , cd.birth_date
        , cd.cust_since_date
        , cd.birth_date
        , cd.Branch_id
        , ca.acct_id
        , af.as_of_date
        , af.cur_bal
        , ad.open_close_code
        , cr.Customer_role_id
        , cd.first_name
        , cd.last_name;
