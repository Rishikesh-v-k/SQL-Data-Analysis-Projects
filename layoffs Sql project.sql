SELECT * FROM layoffs;

CREATE TABLE layoffs_staging
LIKE layoffs;

INSERT layoffs_staging
SELECT *
FROM layoffs;

SELECT * FROM layoffs_staging;



CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,date,stage,country,funds_raised_millions)AS row_num
FROM layoffs_staging;

SELECT * FROM layoffs_staging2
WHERE row_num>1;

SELECT * 
FROM layoffs_staging2
WHERE company= 'Yahoo' ;

DELETE
FROM layoffs_staging2
WHERE row_num  >1;

SELECT distinct company FROM layoffs_staging2
order by 1;

UPDATE layoffs_staging2
SET company=TRIM(company);

SELECT distinct industry FROM layoffs_staging2
order by 1;

 UPDATE layoffs_staging2
SET industry='crypto'
WHERE industry LIKE 'crypto%';

SELECT distinct industry FROM layoffs_staging2
order by 1;

UPDATE layoffs_staging2
SET country=TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

SELECT distinct country FROM layoffs_staging2
order by 1;


UPDATE layoffs_staging2
set `date`=str_to_date(`date`,'%m/%d/%Y');

SELECT date 
FROM layoffs_staging2
;

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;



SELECT*
FROM layoffs_staging2
WHERE total_laid_off = ' '
AND percentage_laid_off = ' ';

SELECT*
FROM layoffs_staging2
WHERE industry = '';

UPDATE layoffs_staging2
SET industry=null
WHERE industry='';

SELECT*
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
 on t1.company=t2.company
WHERE t1.industry IS NULL AND t2.industry IS NOT NULL;


UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
 on t1.company=t2.company
 SET t1.industry=t2.industry
WHERE t1.industry IS NULL AND t2.industry IS NOT NULL;



SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL and percentage_laid_off IS NULL;

DELETE 
FROM layoffs_staging2
WHERE total_laid_off IS NULL and percentage_laid_off IS NULL;

alter TABLE layoffs_staging2
DROP COLUMN row_num;

SELECT MIN(total_laid_off)
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2;

SELECT company,MAx(funds_raised_millions)
FROM layoffs_staging2
GROUP BY company
ORDER by 2 DESC
LIMIT 5;

SELECT year(`date`),SUM(total_laid_off) AS Totaloff
FROM layoffs_staging2
WHERE year(`date`) IS NOT NULL
GROUP BY year(`date`)
ORDER by 1;

SELECT SUBSTRING(`date`,1,7) as month ,SUM(total_laid_off) AS 'Totaloff'
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY month
ORDER by 1;

WITH rolling_total AS(
SELECT SUBSTRING(`date`,1,7) as month ,SUM(total_laid_off) AS 'Totaloff'
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY month
ORDER by 1)
SELECT month,Totaloff,SUM(Totaloff)OVER(ORDER BY month)AS rolling
FROM rolling_total;

WITH company_year(company,years,total_laid_off) AS(
SELECT company,YEAR(`date`),SUM(total_laid_off) 
FROM layoffs_staging2
GROUP BY company,YEAR(`date`)
),company_year_ranking AS(
SELECT *,DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC)AS ranking
FROM company_year
WHERE years IS NOT NULL)
SELECT *
FROM company_year_ranking
WHERE ranking<=5;