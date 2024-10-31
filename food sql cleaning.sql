SELECT * FROM food_coded;

create table food_coded1
like food_coded;

insert into food_coded1
select * from food_coded;

SELECT count(*) FROM food_coded1;

select *,ROW_NUMBER() over(partition by GPA, Gender, breakfast, calories_chicken, calories_day, calories_scone, coffee, comfort_food, comfort_food_reasons, comfort_food_reasons_coded, cook, cuisine, diet_current, diet_current_coded, drink, eating_changes, eating_changes_coded, eating_changes_coded1, eating_out, employment, ethnic_food, exercise, father_education, father_profession, fav_cuisine, fav_cuisine_coded, fav_food, food_childhood, fries, fruit_day, grade_level, greek_food, healthy_feeling, healthy_meal, ideal_diet, ideal_diet_coded, income, indian_food, italian_food, life_rewarding, marital_status, meals_dinner_friend, mother_education, mother_profession, nutritional_check, on_off_campus, parents_cook, pay_meal_out, persian_food, self_perception_weight, soup, sports, thai_food, tortilla_calories, turkey_calories, type_sports, veggies_day, vitamins, waffle_calories, weight) as row_num
from food_coded1;

SELECT distinct GPA
 FROM food_coded1;
 
 SELECT distinct calories_day
 FROM food_coded1;
 
 SELECT calories_day
 FROM food_coded1
 where calories_day='nan';
 
 update food_coded1
 set calories_day='nill'
 where calories_day='nan';
 
 SELECT distinct employment
 FROM food_coded1;

SELECT distinct comfort_food
 FROM food_coded1;
 
SELECT trim(comfort_food) FROM food_coded1;

update food_coded1
set comfort_food=trim(comfort_food);

update food_coded1
set comfort_food=lower(comfort_food);

SELECT distinct comfort_food_reasons
 FROM food_coded1;
 
 SELECT 
    CASE
        WHEN LOWER(comfort_food_reasons) LIKE '%stress%' THEN 'Stress'
        WHEN LOWER(comfort_food_reasons) LIKE '%bored%' THEN 'Boredom'
        WHEN LOWER(comfort_food_reasons) LIKE '%anger%' THEN 'Anger'
        WHEN LOWER(comfort_food_reasons) LIKE '%sad%' THEN 'Sadness'
        ELSE 'Other'
    END AS categorized_reasons
FROM food_coded1;


UPDATE food_coded1
SET categorized_reasons = TRIM(
    CONCAT(
        CASE WHEN LOWER(comfort_food_reasons) LIKE '%stress%' THEN 'Stress, ' ELSE '' END,
        CASE WHEN LOWER(comfort_food_reasons) LIKE '%bored%' THEN 'Boredom, ' ELSE '' END,
        CASE WHEN LOWER(comfort_food_reasons) LIKE '%anger%' THEN 'Anger, ' ELSE '' END,
        CASE WHEN LOWER(comfort_food_reasons) LIKE '%sad%' THEN 'Sadness, ' ELSE '' END
    )
)
WHERE categorized_reasons IS NULL;  

 
 

ALTER TABLE food_coded1 ADD comfort_food_reasons1 VARCHAR(255);
select * from food_coded1;

alter table food_coded1
drop column comfort_food_reasons1;

update food_coded1
set comfort_food_reasons=lower(comfort_food_reasons);

select distinct weight from food_coded1;

select distinct father_education from food_coded1;

select distinct fav_cuisine from food_coded1;

update food_coded1
set fav_cuisine=lower(fav_cuisine);

update food_coded1
set fav_cuisine=trim(fav_cuisine);

update food_coded1
set fav_cuisine='american'
where fav_cuisine='anything american style.';

update food_coded1
set fav_cuisine='thai'
where fav_cuisine='thai food';

update food_coded1
set fav_cuisine= case 
        WHEN fav_cuisine like'%italian%' THEN 'italian'
        WHEN fav_cuisine like'%thai%' THEN 'thai'
        WHEN fav_cuisine like'%indian%' THEN 'indian'
        WHEN fav_cuisine like'%american%' THEN 'american'
        WHEN fav_cuisine like'%mexican%' THEN 'mexican'
        WHEN fav_cuisine like'%french%' THEN 'french'
        WHEN fav_cuisine like'%chinese%' THEN 'chinese'
        else 'other'
	end;
    
    
UPDATE food_coded1
SET type_sports= CASE
    -- Team Sports
    WHEN LOWER(type_sports) LIKE '%basketball%' THEN 'Team Sport'
    WHEN LOWER(type_sports) LIKE '%soccer%' OR LOWER(type_sports) LIKE '%football%' THEN 'Team Sport'
    WHEN LOWER(type_sports) LIKE '%volleyball%' THEN 'Team Sport'

    -- Individual Sports
    WHEN LOWER(type_sports) LIKE '%tennis%' THEN 'Individual Sport'
    WHEN LOWER(type_sports) LIKE '%swimming%' THEN 'Individual Sport'
    WHEN LOWER(type_sports) LIKE '%running%' THEN 'Individual Sport'

    -- Motorsports
    WHEN LOWER(type_sports) LIKE '%car racing%' OR LOWER(type_sports) LIKE '%motorsport%' THEN 'Motorsport'

    -- Other or Unspecified
    ELSE 'Other'
END;


select distinct type_sports from food_coded1;

SELECT distinct drink
FROM food_coded1;

select * from food_coded1;

update food_coded1
set cuisine='nill'
where cuisine='nan';

update food_coded1
set eating_changes='nill'
where eating_changes='Nun';

UPDATE food_coded1
SET diet_current =
    CASE
        -- Vegetarian category
        WHEN LOWER(diet_current) LIKE '%vegetarian%' OR LOWER(diet_current) LIKE '%veg%' OR LOWER(diet_current) LIKE '%no meat%' THEN 'Vegetarian'
        
        -- Vegan category
        WHEN LOWER(diet_current) LIKE '%vegan%' OR LOWER(diet_current) LIKE '%plant-based%' THEN 'Vegan'
        
        -- Paleo category
        WHEN LOWER(diet_current) LIKE '%paleo%' THEN 'Paleo'
        
        -- Low-carb category
        WHEN LOWER(diet_current) LIKE '%low carb%' OR LOWER(diet_current) LIKE '%keto%' THEN 'Low-carb'
        
        -- Gluten-free category
        WHEN LOWER(diet_current) LIKE '%gluten-free%' THEN 'Gluten-free'
        
        -- Standard/Regular Diet category
        WHEN LOWER(diet_current) LIKE '%regular%' OR LOWER(diet_current) LIKE '%standard%' THEN 'Standard'
        
        -- Other category (catch-all for entries that don’t match any known category)
        ELSE 'Other'
    END;


UPDATE food_coded1
SET eating_changes = 
    CASE
        -- Increased eating
        WHEN LOWER(eating_changes) LIKE '%eat more%' OR LOWER(eating_changes) LIKE '%overeating%' OR LOWER(eating_changes) LIKE '%snacking%' THEN 'Increased Eating'
        
        -- Decreased eating
        WHEN LOWER(eating_changes) LIKE '%eat less%' OR LOWER(eating_changes) LIKE '%lost appetite%' THEN 'Decreased Eating'
        
        -- Healthier eating
        WHEN LOWER(eating_changes) LIKE '%healthier%' OR LOWER(eating_changes) LIKE '%more fruits%' OR LOWER(eating_changes) LIKE '%vegetables%' THEN 'Healthier Eating'
        
        -- Unhealthier eating
        WHEN LOWER(eating_changes) LIKE '%junk food%' OR LOWER(eating_changes) LIKE '%fast food%' OR LOWER(eating_changes) LIKE '%unhealthy%' THEN 'Unhealthier Eating'
        
        -- No change
        WHEN LOWER(eating_changes) LIKE '%no change%' OR LOWER(eating_changes) LIKE '%same%' THEN 'No Change'
        
        -- Other
        ELSE 'Other'
    END;

select distinct eating_changes from food_coded1;



UPDATE food_coded1
SET comfort_food= 
    CASE
        -- Sweets category
        WHEN LOWER(comfort_food) LIKE '%chocolate%' OR LOWER(comfort_food) LIKE '%ice cream%' OR LOWER(comfort_food) LIKE '%cake%' THEN 'Sweets'
        
        -- Snacks category
        WHEN LOWER(comfort_food) LIKE '%chips%' OR LOWER(comfort_food) LIKE '%popcorn%' OR LOWER(comfort_food) LIKE '%cookies%' THEN 'Snacks'
        
        -- Fast Food category
        WHEN LOWER(comfort_food) LIKE '%pizza%' OR LOWER(comfort_food) LIKE '%burger%' OR LOWER(comfort_food) LIKE '%fries%' THEN 'Fast Food'
        
        -- Beverages category
        WHEN LOWER(comfort_food) LIKE '%coffee%' OR LOWER(comfort_food) LIKE '%tea%' OR LOWER(comfort_food) LIKE '%soda%' THEN 'Beverages'
        
        -- Home-cooked meals category
        WHEN LOWER(comfort_food) LIKE '%soup%' OR LOWER(comfort_food) LIKE '%pasta%' OR LOWER(comfort_food) LIKE '%rice%' THEN 'Home-cooked Meals'
        
        -- Other (catch-all for unknown or non-categorized entries)
        ELSE 'Other'
    END;
    
select comfort_food from food_coded1;


UPDATE food_coded1
SET healthy_meal =
    CASE
        -- Balanced meal category
        WHEN LOWER(healthy_meal) LIKE '%balanced%' OR LOWER(healthy_meal) LIKE '%protein%' AND LOWER(healthy_meal) LIKE '%carbs%' AND LOWER(healthy_meal) LIKE '%veggies%' THEN 'Balanced Meal'
        
        -- Low-carb meal category
        WHEN LOWER(healthy_meal) LIKE '%low carb%' OR LOWER(healthy_meal) LIKE '%keto%' THEN 'Low-carb Meal'
        
        -- Vegetarian meal category
        WHEN LOWER(healthy_meal) LIKE '%vegetarian%' OR LOWER(healthy_meal) LIKE '%veg%' THEN 'Vegetarian Meal'
        
        -- Vegan meal category
        WHEN LOWER(healthy_meal) LIKE '%vegan%' OR LOWER(healthy_meal) LIKE '%plant-based%' THEN 'Vegan Meal'
        
        -- Salads category
        WHEN LOWER(healthy_meal) LIKE '%salad%' OR LOWER(healthy_meal) LIKE '%greens%' OR LOWER(healthy_meal) LIKE '%leafy%' THEN 'Salads'
        
        -- Home-cooked meal category
        WHEN LOWER(healthy_meal) LIKE '%home%' OR LOWER(healthy_meal) LIKE '%homemade%' THEN 'Home-cooked Meal'
        
        -- Other (catch-all for unknown or non-categorized entries)
        ELSE 'Other'
    END ;
    
    UPDATE food_coded1
SET ideal_diet =
    CASE
        -- Vegetarian category
        WHEN LOWER(ideal_diet) LIKE '%vegetarian%' OR LOWER(ideal_diet) LIKE '%no meat%' OR LOWER(ideal_diet) LIKE '%veg%' THEN 'Vegetarian'
        
        -- Vegan category
        WHEN LOWER(ideal_diet) LIKE '%vegan%' OR LOWER(ideal_diet) LIKE '%plant-based%' THEN 'Vegan'
        
        -- Low-carb category
        WHEN LOWER(ideal_diet) LIKE '%low carb%' OR LOWER(ideal_diet) LIKE '%keto%' THEN 'Low-carb'
        
        -- Balanced diet category
        WHEN LOWER(ideal_diet) LIKE '%balanced%' OR LOWER(ideal_diet) LIKE '%healthy mix%' OR LOWER(ideal_diet) LIKE '%all nutrients%' THEN 'Balanced Diet'
        
        -- Paleo category
        WHEN LOWER(ideal_diet) LIKE '%paleo%' THEN 'Paleo'
        
        -- Mediterranean diet category
        WHEN LOWER(ideal_diet) LIKE '%mediterranean%' THEN 'Mediterranean'
        
        -- Other (catch-all for unknown or non-categorized entries)
        ELSE 'Other'
    END ;

select * from food_coded1;

UPDATE food_coded1
SET comfort_food_reasons = 
    CONCAT(
        CASE WHEN LOWER(comfort_food_reasons) LIKE '%stress%' THEN 'Stress, ' ELSE '' END,
        CASE WHEN LOWER(comfort_food_reasons) LIKE '%bored%' THEN 'Boredom, ' ELSE '' END,
        CASE WHEN LOWER(comfort_food_reasons) LIKE '%sad%' THEN 'Sadness, ' ELSE '' END,
        CASE WHEN LOWER(comfort_food_reasons) LIKE '%happy%' OR LOWER(comfort_food_reasons) LIKE '%joy%' OR LOWER(comfort_food_reasons) LIKE '%celebrat%' THEN 'Happiness, ' ELSE '' END,
        CASE WHEN LOWER(comfort_food_reasons) LIKE '%anger%' OR LOWER(comfort_food_reasons) LIKE '%frustrat%' THEN 'Anger, ' ELSE '' END,
        CASE WHEN LOWER(comfort_food_reasons) LIKE '%other%' OR LOWER(comfort_food_reasons) LIKE '%none%' THEN 'Other, ' ELSE '' END
    );

update food_coded1
set comfort_food_reasons='other'
where comfort_food_reasons='';

select distinct comfort_food_reasons
from food_coded1;

UPDATE food_coded1
SET father_profession = 
    CASE
        -- Business category
        WHEN LOWER(father_profession) LIKE '%business%' OR LOWER(father_profession) LIKE '%entrepreneur%' OR LOWER(father_profession) LIKE '%shop owner%' THEN 'Business'
        
        -- Engineer category
        WHEN LOWER(father_profession) LIKE '%engineer%' THEN 'Engineer'
        
        -- Doctor category
        WHEN LOWER(father_profession) LIKE '%doctor%' OR LOWER(father_profession) LIKE '%physician%' OR LOWER(father_profession) LIKE '%surgeon%' THEN 'Doctor'
        
        -- Teacher category
        WHEN LOWER(father_profession) LIKE '%teacher%' OR LOWER(father_profession) LIKE '%professor%' OR LOWER(father_profession) LIKE '%lecturer%' THEN 'Teacher'
        
        -- Farmer category
        WHEN LOWER(father_profession) LIKE '%farmer%' OR LOWER(father_profession) LIKE '%agriculture%' THEN 'Farmer'
        
        -- Retired category
        WHEN LOWER(father_profession) LIKE '%retired%' THEN 'Retired'
        
        -- Other (for unknown or less common professions)
        ELSE 'Other'
    END;
    
UPDATE food_coded1
SET mother_profession = 
    CASE
        -- Homemaker category
        WHEN LOWER(mother_profession) LIKE '%housewife%' OR LOWER(mother_profession) LIKE '%homemaker%' OR LOWER(mother_profession) LIKE '%stay-at-home%' THEN 'Homemaker'
        
        -- Business category
        WHEN LOWER(mother_profession) LIKE '%business%' OR LOWER(mother_profession) LIKE '%entrepreneur%' OR LOWER(mother_profession) LIKE '%shop owner%' THEN 'Business'
        
        -- Teacher category
        WHEN LOWER(mother_profession) LIKE '%teacher%' OR LOWER(mother_profession) LIKE '%professor%' OR LOWER(mother_profession) LIKE '%lecturer%' THEN 'Teacher'
        
        -- Nurse/Doctor category
        WHEN LOWER(mother_profession) LIKE '%nurse%' OR LOWER(mother_profession) LIKE '%doctor%' OR LOWER(mother_profession) LIKE '%physician%' THEN 'Medical Professional'
        
        -- Engineer category
        WHEN LOWER(mother_profession) LIKE '%engineer%' THEN 'Engineer'
        
        -- Retired category
        WHEN LOWER(mother_profession) LIKE '%retired%' THEN 'Retired'
        
        -- Other (for unknown or less common professions)
        ELSE 'Other'
    END ;
    
    ALTER TABLE food_coded1
MODIFY Gender VARCHAR(10);

    
UPDATE food_coded1
SET Gender= CASE
    WHEN Gender = '1' THEN 'Male'
    WHEN Gender = '2' THEN 'Female'
    ELSE 'Other'  
END;
select * from food_coded1;

ALTER TABLE food_coded1
RENAME COLUMN comfort_food_reasons_coded_[0] TO comfort_food_reasons_coded;

ALTER TABLE food_coded1
RENAME COLUMN Gender TO gender;
