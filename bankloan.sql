CREATE DATABASE bankloan_db;
USE bankloan_db;

SELECT * FROM loan_data;

---------------------------------------------------------------------------------------------------------

---------------------------------- Total_Loan_Applications ----------------------------------------------
SELECT
      COUNT(id) AS Total_Loan_Applications
FROM loan_data;


---------------------------------- MTD_Total_Loan_Applications ----------------------------------------------
SELECT
     COUNT(id) AS MTD_Loan_Applications
FROM loan_data
WHERE issue_date BETWEEN '2021-12-01' AND '2021-12-31';

SELECT * FROM loan_data;

SELECT
     COUNT(id) AS MTD_Loan_Applications
FROM loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;


---------------------------------- PMTD_Total_Loan_Applications ----------------------------------------------
SELECT
     COUNT(id) AS PMTD_Loan_Applications
FROM loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

--------------------------------------------------------------------------------------------------------

------------------------------------- Total Funded Amount ----------------------------------------------
SELECT
     SUM(loan_amount) AS Total_Funded_Amount
FROM loan_data;


---------------------------------- MTD_Total_Funded_Amount ----------------------------------------------
SELECT
	 SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

---------------------------------- PMTD_Total_Funded_Amount ----------------------------------------------
SELECT
	 SUM(loan_amount) AS PMTD_Total_Funded_Amount
FROM loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

--------------------------------------------------------------------------------------------------

-------------------------------- Total Payment Reveived -------------------------------------------
SELECT * FROM loan_data;

SELECT
     SUM(total_payment) AS Total_Amount_Reveived
FROM loan_data;

---------------------------------- MTD_Total_Payment_Received ------------------------------------
SELECT 
	 SUM(total_payment) AS MTD_Total_Amount_Received
FROM loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

---------------------------------- PMTD_Total_Payment_Received -----------------------------------
SELECT 
	 SUM(total_payment) AS PMTD_Total_Amount_Received
FROM loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

--------------------------------------------------------------------------------------------------

-------------------------------------- Average Interest Rate ------------------------------------
SELECT * FROM loan_data;

SELECT ROUND(AVG(int_rate) * 100, 2) AS Avg_Interest_Rate
FROM loan_data;

-------------------------------------- MTD_Average_Interest_Rate ----------------------------------
SELECT
	  ROUND(AVG(int_rate) * 100, 2) AS MTD_Average_Interest_Rate
FROM loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

-------------------------------------- PMTD_Average_Interest_Rate ----------------------------------
SELECT
     ROUND(AVG(int_rate) * 100, 2) AS PMTD_Average_Interest_Rate
FROM loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

--------------------------------------------------------------------------------------------------

-------------------------------------- Average DTI -----------------------------------------------
SELECT * FROM loan_data;

SELECT
	 ROUND(AVG(dti) * 100, 2) AS Avg_DTI
FROM loan_data;

-------------------------------------- MTD_Average_DTI --------------------------------------------
SELECT
	 ROUND(AVG(dti) * 100, 2) AS MTD_Average_DTI
FROM loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

-------------------------------------- PMTD_Average_DTI --------------------------------------------
SELECT
	 ROUND(AVG(dti) * 100, 2) AS PMTD_Average_DTI
FROM loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

--------------------------------------------------------------------------------------------------

-------------------------------------- Good loan % -----------------------------------------------
SELECT * FROM loan_data;

SELECT
     ROUND((COUNT(CASE
           WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100)
           /
           COUNT(id),2) AS Good_Loan_Percentage
FROM loan_data;

-------------------------------------- Good loan applications -----------------------------------------------
SELECT
     COUNT(id) AS Good_Loan_Applications
FROM loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

SELECT
     COUNT(id) AS Good_Loan_Applications
FROM loan_data
WHERE loan_status IN ('Fully Paid','Current');

-------------------------------------- Good loan funded amount -----------------------------------------------
SELECT
     SUM(loan_amount) AS Good_Loan_Funded_Amount
FROM loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

-------------------------------------- Good loan Received amount -----------------------------------------------
SELECT
     SUM(total_payment) AS Good_Loan_Received_Amount
FROM loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

-------------------------------------- Bad loan % -----------------------------------------------
SELECT
	 ROUND(COUNT(CASE
           WHEN loan_status = 'Charged Off' THEN id END) * 100
           /
           COUNT(id), 2) AS Bad_Loan_Percentage
FROM loan_data;

-------------------------------------- Bad loan applications -------------------------------------
SELECT
     COUNT(id) AS Bad_Loan_Applications
FROM loan_data
WHERE loan_status = 'Charged Off';

-------------------------------------- Bad loan funded amount ---------------------------------
SELECT
      SUM(loan_amount) AS Bad_Loan_Funded_Amount
FROM loan_data
WHERE loan_status = 'Charged Off';

-------------------------------------- Bad loan received amount ---------------------------------
SELECT
     SUM(total_payment) AS Bad_Loan_Received_Amount
FROM loan_data
WHERE loan_status = 'Charged Off';

------------------------------------ LOAN STATUS GRID VIEW --------------------------------------
SELECT * FROM loan_data;

SELECT
      loan_status,
      COUNT(id) AS Total_Loan_Applications,
      SUM(loan_amount) AS Total_Funded_Amount,
      SUM(total_payment) AS Total_Payment_Received,
      ROUND(AVG(int_rate * 100),2) AS Avg_Interest_Rate,
      ROUND(AVG(dti * 100), 2) AS DTI
FROM loan_data
GROUP BY loan_status
ORDER BY Total_Payment_Received DESC;

---------------------------- MTD_Total_Funded_Amount VS MTD_Total_Reveived_Amount ----------------
SELECT
      loan_status
	 ,SUM(loan_amount) AS MTD_Total_Funded_Amount
	 ,SUM(total_payment) AS MTD_Total_Reveived_Amount
FROM loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021
GROUP BY loan_status;

-------------------------------- BANK LOAN REPORT: OVERVIEW ---------------------------------

------------------------- Total Applications/Loan/Payment by Month -------------------------
SELECT * FROM loan_data;

SELECT
     MONTH(issue_date) AS Month_Number
	,MONTHNAME(issue_date) AS Month_Name
	,COUNT(id) AS Total_Loan_Applications
    ,SUM(loan_amount) AS Total_Funded_Amount
    ,SUM(total_payment) AS Total_Payment_Reveived
FROM loan_data
GROUP BY Month_Number, Month_Name
ORDER BY Month_Number ASC;

----------------------- Total Applications/Loan/Payment by Address State -------------------------
SELECT
      address_state
     ,COUNT(id) AS Total_Loan_Applications
     ,SUM(loan_amount) AS Total_Funded_Amount
     ,SUM(total_payment) AS Total_Payment_Reveived
FROM loan_data
GROUP BY address_state
ORDER BY Total_Loan_Applications DESC;

----------------------- Total Applications/Loan/Payment by Term -------------------------
SELECT
      term
	 ,COUNT(id) AS Total_Loan_Applications
     ,SUM(loan_amount) AS Total_Funded_Amount
     ,SUM(total_payment) AS Total_Payment_Reveived
FROM loan_data
GROUP BY term
ORDER BY term DESC;

----------------------- Total Applications/Loan/Payment by Emp Lenghth -------------------------
SELECT
      emp_length
	 ,COUNT(id) AS Total_Loan_Applications
     ,SUM(loan_amount) AS Total_Funded_Amount
     ,SUM(total_payment) AS Total_Payment_Reveived
FROM loan_data
GROUP BY emp_length
ORDER BY Total_Loan_Applications DESC;

----------------------- Total Applications/Loan/Payment by Purpose -------------------------
SELECT
      purpose
	 ,COUNT(id) AS Total_Loan_Applications
     ,SUM(loan_amount) AS Total_Funded_Amount
     ,SUM(total_payment) AS Total_Payment_Reveived
FROM loan_data
GROUP BY purpose
ORDER BY Total_Loan_Applications DESC;

----------------------- Total Applications/Loan/Payment by home_ownership -------------------------
SELECT
      home_ownership
	 ,COUNT(id) AS Total_Loan_Applications
     ,SUM(loan_amount) AS Total_Funded_Amount
     ,SUM(total_payment) AS Total_Payment_Reveived
FROM loan_data
GROUP BY home_ownership
ORDER BY Total_Loan_Applications DESC;

