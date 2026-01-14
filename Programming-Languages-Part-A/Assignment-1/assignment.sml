(* Code is mine, comments are from ChatGPT for readability purposes *)

(* Date is of the form (year, month, day) *)

(* ================ Constants ================*)

(* A list of the number of days in each month for a leap year (2020, 2024, etc.) *)
val days_in_month_leap: int list = [31, 29, 31,30, 31, 30, 31, 31, 30, 31, 30, 31]

(* A list of the number of days in each month for a non-leap year (2021, 2022, etc.) *)
val days_in_month_non_leap: int list = [31, 28, 31,30, 31, 30, 31, 31, 30, 31, 30, 31]

(* A list of month names for printing purposes, used for converting month numbers to month names *)
val monthAsString: string list = ["January", "February", "March", "April", "May", "June",
"July", "August", "September", "October", "November", "December"]

(* ================ Question 1 ================*)

(* Compares two dates (in the form (year, month, day)) and returns true if the first date is earlier than the second date *)
fun is_older(date1: int*int*int, date2: int*int*int) = 
    if (#1 date1) < (#1 date2)  (* Compare years first *)
        orelse (#1 date1) = (#1 date2) andalso (#2 date1) < (#2 date2)  (* If years are equal, compare months *)
        orelse (#1 date1) = (#1 date2) andalso (#2 date1) = (#2 date2) andalso (#3 date1) < (#3 date2)  (* If months are equal, compare days *)
    then true
    else false

(* ================ Question 2 ================*)

(* Given a list of dates and a month, counts how many dates fall in that month *)
fun number_in_month(datesList: (int*int*int) list, month: int) = 
    if null datesList  (* If the list is empty, return 0 *)
        then 0
    else 
        let
            val monthOfCurrHead: int = (#2  (hd datesList))  (* Extract the month from the current date tuple *)
            val increaseCount =  if monthOfCurrHead = month then 1 else 0  (* Increment count if month matches *)
        in
            increaseCount + number_in_month(tl datesList, month)  (* Recursively count the occurrences in the tail of the list *)
        end

(* ================ Question 3 ================*)

(* Counts the total number of dates that fall into any of the months specified in monthList *)
fun number_in_months(datesList: (int*int*int) list, monthList: int list) = 
    if null monthList  (* If there are no months left to check, return 0 *)
        then 0
    else
        let 
            val isMonthPresentInDatesList = number_in_month(datesList, hd monthList)  (* Get the count for the current month *)
        in
            isMonthPresentInDatesList + number_in_months(datesList, tl monthList)  (* Add counts recursively for the rest of the months *)
        end

(* ================ Question 4 ================*)

(* Returns a list of all dates that fall in the specified month from a list of dates *)
fun dates_in_month(datesList:(int*int*int) list, month: int) = 
    if null datesList  (* If the list is empty, return an empty list *)
        then []
    else 
        let
            val isDatePresentInMonth = #2 (hd datesList) = month  (* Check if the month of the current date matches the input month *)
        in 
            if isDatePresentInMonth
                then (hd datesList):: dates_in_month(tl datesList, month)  (* Include the current date if it matches, and check the rest *)
            else
                dates_in_month(tl datesList, month)  (* Skip the current date if it doesn't match *)
        end

(* ================ Question 5 ================*)

(* Given a list of dates and a list of months, returns a list of all dates in any of the given months *)
fun dates_in_months(datesList:(int*int*int) list, monthList:int list) =
    if null monthList  (* If there are no more months to check, return an empty list *)
        then []
    else
        dates_in_month(datesList, hd monthList) @ dates_in_months(datesList, tl monthList)  (* Combine the result for the current month with the result for the rest of the months *)

(* ================ Question 6 ================*)

(* A helper function to get the nth element in a list (1-based index) *)
fun get_nth(inputStringList: string list, n: int) =
    if n = 1  (* If we're looking for the first element, return it *)
        then hd inputStringList
    else 
        get_nth(tl inputStringList, n - 1) 

(* ================ Question 7 ================*)

(* Converts a date (in the form (year, month, day)) into a string format: "Month Day, Year" *)
fun date_to_string(date: int*int*int) = 
    get_nth(monthAsString, #2 date) ^ " " ^ (Int.toString (#3 date)) ^ ", " ^ (Int.toString (#1 date))

(* ================ Question 8 ================*)

(* Given a target sum and a list of numbers, returns the index where the sum is reached or exceeded *)
fun number_before_reaching_sum(sum: int, numberList: int list) = 
    let
        fun get_index_of_sum(currentSum: int, index: int, newNumberList: int list) = 
            if currentSum + hd newNumberList >= sum orelse null newNumberList  (* If sum is reached or list is empty, return index *)
                then index
            else
                get_index_of_sum(currentSum + (hd newNumberList), index + 1, tl newNumberList)  (* Recursively sum the numbers and increment the index *)
    in
        get_index_of_sum(0, 0, numberList)  (* Start with a current sum of 0 and index 0 *)
    end

(* ================ Question 9 ================*)

(* Given a number of days, returns the corresponding month in a non-leap year *)
fun what_month(days: int) = 
    number_before_reaching_sum (days, days_in_month_non_leap) + 1  (* Find the month by summing the days until the target is reached *)

(* ================ Question 10 ================*)

(* Given two day numbers, returns the list of months between those days (inclusive) *)
fun month_range(day1 : int, day2: int) = 
    if day1 > day2  (* If day1 is greater than day2, return an empty list *)
        then []
    else
        what_month(day1)::month_range(day1 + 1, day2)  (* Recursively get the month for day1 and increment day1 until reaching day2 *)

(* ================ Question 11 ================*)

(* Finds the oldest date in a list of dates *)
fun oldest (dates: (int*int*int) list) =
    if null dates  (* If the list is empty, return NONE *)
        then NONE
    else
        let 
            val currOldest = oldest (tl dates)  (* Recursively find the oldest date in the tail of the list *)
        in
            if isSome currOldest andalso is_older(valOf currOldest, hd dates)  (* If the current oldest is older than the head date, keep it *)
                then  currOldest
            else
                SOME (hd dates)  (* Otherwise, the current head date is the oldest *)
        end

(* ================ Question 12 ================*)

(* Checks if a number is present in a list *)
fun is_number_in_numberList(numberList: int list, number: int) = 
    if null numberList  (* If the list is empty, return false *)
        then false
    else hd numberList = number orelse is_number_in_numberList(tl numberList, number)  (* Recursively check the head of the list *)

(* Converts a list of numbers into a set (removes duplicates) *)
fun number_to_set(numberList: int list) = 
    let
        (* Helper function for number_to_set *)
        fun number_to_set_helper(uniqueList: int list, remainingList: int list) = 
            if null remainingList  (* If there are no more elements in the list, return the unique list *)
                then uniqueList
            else 
                let
                    val alreadyExists = is_number_in_numberList(uniqueList, hd remainingList)  (* Check if the current number is already in the unique list *)
                in
                    if alreadyExists  (* If it's already in the set, skip it *)
                        then number_to_set_helper(uniqueList, tl remainingList)
                    else
                        number_to_set_helper(hd remainingList :: uniqueList, tl remainingList)  (* Otherwise, add it to the set and continue *)
                end
    in
        number_to_set_helper([], numberList)  (* Start with an empty set and process the whole list *)
    end

(* ================ Challenge Questions ================*)

(* Given a list of dates and a list of months, returns the count of dates in the unique months (duplicates in monthList are removed) *)
fun number_in_months_challenge(datesList: (int*int*int) list, monthList: int list) = 
    if null monthList  (* If no months are left, return 0 *)
        then 0
    else
        let 
            val unique_months = number_to_set monthList  (* Remove duplicates in the month list *)
        in
            number_in_months(datesList, unique_months)  (* Call the original number_in_months function with the unique months *)
        end

(* Given a list of dates and a list of months, returns a list of dates in the unique months (duplicates in monthList are removed) *)
fun dates_in_months_challenge(datesList:(int*int*int) list, monthList:int list) =
    if null monthList  (* If no months are left, return an empty list *)
        then []
    else
        let
            val unique_months = number_to_set monthList  (* Remove duplicates in the month list *)
        in
            dates_in_month(datesList, hd unique_months) @ dates_in_months(datesList, tl unique_months)  (* Call the original dates_in_month function for each unique month *)
        end

(* ================ Question 13 ================*)

(* Checks if a year is a valid year (greater than 0) *)
fun is_valid_year(year: int) =
    year > 0

(* Checks if a year is a valid leap year according to the rules *)
fun is_valid_leap_year(year: int) =
    (((year mod 400 = 0) orelse (year mod 4 = 0 andalso year mod 100 <> 0)))  (* A year is a leap year if divisible by 400, or divisible by 4 but not 100 *)

(* Checks if a month is valid (between 1 and 12) *)
fun is_valid_month(month: int) =
    month >= 1 andalso month <= 12

(* Checks if a specific day is valid in the given month (for both leap and non-leap years) *)
fun day_present_in_month(datesList: int list, month: int, date: int) = 
    if month = 1  (* Base case: If it's the first month, we only need to check if the day is within the number of days in the month *)
        then date <= hd datesList
    else day_present_in_month(tl datesList, month - 1, date)  (* Otherwise, recursively check the number of days in the months preceding *)

(* Checks if a date is valid in a leap year *)
fun is_valid_leap_date(date: int*int*int) = 
    (#3 date) > 0 andalso day_present_in_month(days_in_month_leap, #2 date, #3 date)

(* Checks if a date is valid in a non-leap year *)
fun is_valid_non_leap_date(date: int*int*int) = 
    (#3 date) > 0 andalso day_present_in_month(days_in_month_non_leap, #2 date, #3 date)

(* Checks if a date is reasonable (valid year, month, and day) considering leap years and non-leap years *)
fun reasonable_date(date: int*int*int) = 
    let
        val isYearValid = is_valid_year(#1 date)  (* Check if the year is valid *)
        val isLeapYear = isYearValid andalso is_valid_leap_year(#1 date)  (* Check if the year is a leap year *)
        val isValidMonth = isYearValid andalso is_valid_month(#2 date)  (* Check if the month is valid *)
        val isValidDate = 
        if not isValidMonth  (* If the month is invalid, the date is invalid *)
        then false
        else 
            if isLeapYear  (* If it's a leap year, validate the date accordingly *)
                then is_valid_leap_date date
            else is_valid_non_leap_date date  (* Otherwise, validate as a non-leap year *)
    in
        isValidDate  (* Return true if the date is valid, otherwise false *)
    end

(* use "assignment.sml"; *) 
