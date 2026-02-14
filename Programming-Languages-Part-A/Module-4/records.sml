val x = {bar = (1+2, true andalso true), foo = 3+4 , baz = (false, 9)};

#bar x;

datatype mytype = TwoInts of int*int | Str of string | Pizza;

val a = Str "hi";
val b = Str;
val c = Pizza;
val d = TwoInts (1+2, 3+4);
val e = a;
