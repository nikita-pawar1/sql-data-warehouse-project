/*
=======================================================================================================
This stored procedure loads external csv files into into bronze schema. 
It performs following action
  1. truncate table before loading
  2. Uses Bulk Insert Command to load data from csv file.

Stored Procedure does not accept any parameter or return any values.

Usage Example:
EXEC bronze.load_bronze 
=======================================================================================================
*/


CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @bronze_start Datetime, @bronze_end Datetime
	Set @bronze_start = GETDATE();
	BEGIN TRY
		PRINT '===================================================================';
		PRINT 'LOADING BRONZE LAYER';
		PRINT '===================================================================';

		PRINT '-------------------------------------------------------------------';
		PRINT 'LOADING CRM TABLES';
		PRINT '-------------------------------------------------------------------';
		
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_cust_info;

		BULK INSERT bronze.crm_cust_info
		FROM 'D:\DevOps@6\DataSets\datasets\engineering\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		Print'>>> Load Duration: ' + Cast( Datediff(second, @start_time, @end_time) as Nvarchar) + 'seconds'
		print '....................................................................'

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_prd_info;

		BULK INSERT bronze.crm_prd_info
		FROM 'D:\DevOps@6\DataSets\datasets\engineering\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		Print'>>> Load Duration: ' + Cast( Datediff(second, @start_time, @end_time) as Nvarchar) + 'seconds'
		print '....................................................................'


		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_sales_details ;

		BULK INSERT bronze.crm_sales_details
		FROM 'D:\DevOps@6\DataSets\datasets\engineering\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		Print'>>> Load Duration: ' + Cast( Datediff(second, @start_time, @end_time) as Nvarchar) + 'seconds'
		print '....................................................................'


		PRINT '-------------------------------------------------------------------';
		PRINT 'LOADING ERP TABLES';
		PRINT '-------------------------------------------------------------------';


		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_cust_az12 ;

		BULK INSERT bronze.erp_cust_az12
		FROM 'D:\DevOps@6\DataSets\datasets\engineering\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		Print'>>> Load Duration: ' + Cast( Datediff(second, @start_time, @end_time) as Nvarchar) + 'seconds'
		print '....................................................................'


		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_loc_a101;

		BULK INSERT bronze.erp_loc_a101
		FROM 'D:\DevOps@6\DataSets\datasets\engineering\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		Print'>>> Load Duration: ' + Cast( Datediff(second, @start_time, @end_time) as Nvarchar) + 'seconds'
		print '....................................................................'


		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_px_cat_g1v2 ;

		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'D:\DevOps@6\DataSets\datasets\engineering\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		Print'>>> Load Duration: ' + Cast( Datediff(second, @start_time, @end_time) as Nvarchar) + 'seconds'
		print '....................................................................'

	END TRY
	BEGIN CATCH
		PRINT '===================================================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
		PRINT 'ERROR NUMBER' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'ERROR STATE ' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '===================================================================';
	END CATCH
	set @bronze_end = GETDATE();
	print '....................................................................';
	Print'>>> Bronze layer Completion time: ' + Cast( Datediff(second, @bronze_start, @bronze_end) as Nvarchar) + 'seconds';
	print '....................................................................';

END

