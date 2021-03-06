(* this is  the program for the first assigment  *)
(* Assigment one *)
fun is_older(date1:int*int*int, date2: int*int*int)=
  let 
        val y1 = #1 date1
        val m1 = #2 date1
        val d1 = #3 date1
        val y2 = #1 date2
        val m2 = #2 date2
        val d2 = #3 date2
    in
        y1 < y2 orelse (y1=y2 andalso m1 < m2)
                orelse (y1=y2 andalso m1=m2 andalso d1 < d2)
    end 

  (* other solution
    fun is_older (d1 : int * int * int, d2 : int * int * int) =
  if #1 d1 <> #1 d2
  then #1 d1 < #1 d2
  else if #2 d1 <> #2 d2
  then #2 d1 < #2 d2
  else #3 d1 < #3 d2
  
  *)
    

(* Assigemnt two *)
fun number_in_month(dates : (int*int*int)  list , month : int)=
let 
    fun helper(dates: (int*int*int) list , Acc:int)=
      if null dates then Acc
      else 
	  let 
	      val h=hd(dates)
	      val t=tl(dates)
	  in
	      if(#2 h)=month then helper(t, Acc+1)
	      else helper(t,Acc)
	  end
in
    helper(dates,0)
end

(* other solution
fun number_in_month(listOfDates: (int*int*int) list, month: int) =
  if null listOfDates
  then 0
  else
      let val resultOfTail = number_in_month(tl(listOfDates), month) in 
	  if #2(hd(listOfDates)) = month
	  then 1 + resultOfTail
	  else resultOfTail
      end
 *)     

(* Assigment three *)
fun number_in_months(dates : (int*int*int) list, months : int list)=
  let 
      fun helper( months: int list, Acc:int)=
	if null months then Acc
	else 
	    let 
		val m= hd months
		val tm=tl months
	    val t= number_in_month(dates, m)
	    in
		    helper(tm, Acc+t)
	    end
  in 
      helper(months,0)      
  end

(* Assigment Four *)
fun dates_in_month(dates:(int*int*int) list , month:int)=
  let 
      fun helper(dates :(int*int*int) list, Acc:(int*int*int) list)=
	if null dates then Acc else
	let
	    val h=hd dates
	    val t= tl dates
	    val temp=h::Acc
	in
	    if(month= (#2 h))  then helper(t,temp) else helper(t,Acc)
	end

      fun reverse(xs : (int*int*int) list, Acc : (int*int*int) list)=
	if null xs then Acc else
	reverse(tl xs, hd xs::Acc)
	       
      val re_result =helper(dates, []) 
  in
      reverse(re_result,[])
  end

  (* must know why it need not to reverse!*)
  (* 
    fun dates_in_month (dates : (int * int * int) list, month : int) =
  if null dates
  then []
  else if #2 (hd(dates)) = month
  then hd(dates)::dates_in_month(tl dates, month)
  else dates_in_month(tl dates, month)
  *)

(* Assigment Five *)

fun dates_in_months(dates:(int*int*int) list, months: int list)=
  let 
      fun helper(months: int list, Acc:(int*int*int) list)=
	if null months then Acc else 
	let 
	    val h=hd months;
	    val re=dates_in_month(dates, h)
	in 
	    helper(tl months, Acc@re) 
	end			 
  in
      helper(months, [])
end


(*Assigment Six *)
fun get_nth(st_list : string list, n:int)=
  if n=1 then hd st_list else
  get_nth(tl st_list,n-1)

(*Assigment seven *)
fun date_to_string(date : (int*int*int))=
  let
      val monthes=["January", "February","March","April",
"May", "June", "July", "August", "September", "October","November", "December"]
      val month =get_nth(monthes, #2 date)
      val year=Int.toString(#1 date)
      val day=Int.toString(#3 date)
in
    month^" "^day^", "^year
end

(* Assigment Eight*)

fun number_before_reaching_sum(sum:int, xs: int list)=
  let
      fun helper(xs: int list, n:int, result: int)=
	if(result >= sum) then n-1 else
	helper(tl xs, n+1, result + hd xs)
  in
      helper(xs ,0, 0)
end


(* Assigment Nine *)
fun what_month(day : int )=
  let 
      val days=[31,28,31,30,31,30,31,31,30,31,30,31]
  in
      number_before_reaching_sum(day, days)+1
end



(* Assigment Ten*)
fun month_range(day1:int, day2:int)=
let 
    fun helper(day:int, Acc: int list)=
      if day=day1 then what_month(day)::Acc else
      helper(day-1, what_month(day)::Acc)
in
    if(day2<day1) then [] else helper(day2,[])
end



(*Assigment 11*)
fun oldest(dates :(int*int*int) list)=
let 
    fun helper(dates:(int*int*int) list , Acc: (int*int*int) )=
      if null dates then Acc else 
      let 
	  val t= hd dates;
	  val old= if is_older(t, Acc) then t else Acc
      in
	  helper(tl dates, old)
      end  
in
    if null dates then NONE else
    let 
	val result = helper(tl dates, hd dates)
    in
	SOME(result)
    end
end





