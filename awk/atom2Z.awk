#! /usr/bin/awk -f

BEGIN{
    const_atomicnumber["bq"] =   0;
    const_atomicnumber["gh"] =   0;
    const_atomicnumber["xx"] =   0;
    const_atomicnumber["h" ] =   1;
    const_atomicnumber["he"] =   2;
    const_atomicnumber["li"] =   3;
    const_atomicnumber["be"] =   4;
    const_atomicnumber["b" ] =   5;
    const_atomicnumber["c" ] =   6;
    const_atomicnumber["n" ] =   7;
    const_atomicnumber["o" ] =   8;
    const_atomicnumber["f" ] =   9;
    const_atomicnumber["ne"] =  10;
    const_atomicnumber["na"] =  11;
    const_atomicnumber["mg"] =  12;
    const_atomicnumber["al"] =  13;
    const_atomicnumber["si"] =  14;
    const_atomicnumber["p" ] =  15;
    const_atomicnumber["s" ] =  16;
    const_atomicnumber["cl"] =  17;
    const_atomicnumber["ar"] =  18;
    const_atomicnumber["k" ] =  19;
    const_atomicnumber["ca"] =  20;
    const_atomicnumber["sc"] =  21;
    const_atomicnumber["ti"] =  22;
    const_atomicnumber["v" ] =  23;
    const_atomicnumber["cr"] =  24;
    const_atomicnumber["mn"] =  25;
    const_atomicnumber["fe"] =  26;
    const_atomicnumber["co"] =  27;
    const_atomicnumber["ni"] =  28;
    const_atomicnumber["cu"] =  29;
    const_atomicnumber["zn"] =  30;
    const_atomicnumber["ga"] =  31;
    const_atomicnumber["ge"] =  32;
    const_atomicnumber["as"] =  33;
    const_atomicnumber["se"] =  34;
    const_atomicnumber["br"] =  35;
    const_atomicnumber["kr"] =  36;
    const_atomicnumber["rb"] =  37;
    const_atomicnumber["sr"] =  38;
    const_atomicnumber["y" ] =  39;
    const_atomicnumber["zr"] =  40;
    const_atomicnumber["nb"] =  41;
    const_atomicnumber["mo"] =  42;
    const_atomicnumber["tc"] =  43;
    const_atomicnumber["ru"] =  44;
    const_atomicnumber["rh"] =  45;
    const_atomicnumber["pd"] =  46;
    const_atomicnumber["ag"] =  47;
    const_atomicnumber["cd"] =  48;
    const_atomicnumber["in"] =  49;
    const_atomicnumber["sn"] =  50;
    const_atomicnumber["sb"] =  51;
    const_atomicnumber["te"] =  52;
    const_atomicnumber["i" ] =  53;
    const_atomicnumber["xe"] =  54;
    const_atomicnumber["cs"] =  55;
    const_atomicnumber["ba"] =  56;
    const_atomicnumber["la"] =  57;
    const_atomicnumber["ce"] =  58;
    const_atomicnumber["pr"] =  59;
    const_atomicnumber["nd"] =  60;
    const_atomicnumber["pm"] =  61;
    const_atomicnumber["sm"] =  62;
    const_atomicnumber["eu"] =  63;
    const_atomicnumber["gd"] =  64;
    const_atomicnumber["tb"] =  65;
    const_atomicnumber["dy"] =  66;
    const_atomicnumber["ho"] =  67;
    const_atomicnumber["er"] =  68;
    const_atomicnumber["tm"] =  69;
    const_atomicnumber["yb"] =  70;
    const_atomicnumber["lu"] =  71;
    const_atomicnumber["hf"] =  72;
    const_atomicnumber["ta"] =  73;
    const_atomicnumber["w" ] =  74;
    const_atomicnumber["re"] =  75;
    const_atomicnumber["os"] =  76;
    const_atomicnumber["ir"] =  77;
    const_atomicnumber["pt"] =  78;
    const_atomicnumber["au"] =  79;
    const_atomicnumber["hg"] =  80;
    const_atomicnumber["tl"] =  81;
    const_atomicnumber["pb"] =  82;
    const_atomicnumber["bi"] =  83;
    const_atomicnumber["po"] =  84;
    const_atomicnumber["at"] =  85;
    const_atomicnumber["rn"] =  86;
    const_atomicnumber["fr"] =  87;
    const_atomicnumber["ra"] =  88;
    const_atomicnumber["ac"] =  89;
    const_atomicnumber["th"] =  90;
    const_atomicnumber["pa"] =  91;
    const_atomicnumber["u" ] =  92;
    const_atomicnumber["np"] =  93;
    const_atomicnumber["pu"] =  94;
    const_atomicnumber["am"] =  95;
    const_atomicnumber["cm"] =  96;
    const_atomicnumber["bk"] =  97;
    const_atomicnumber["cf"] =  98;
    const_atomicnumber["es"] =  99;
    const_atomicnumber["fm"] = 100;
    const_atomicnumber["md"] = 101;
    const_atomicnumber["no"] = 102;
    const_atomicnumber["lr"] = 103;
}

{ 
    n2 = tolower(substr($0,0,2))
    if (n2 in const_atomicnumber) 
	print const_atomicnumber[n2]
    else
	print const_atomicnumber[tolower(substr($0,0,1))]
}