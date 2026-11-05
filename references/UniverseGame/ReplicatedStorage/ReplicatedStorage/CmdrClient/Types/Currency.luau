  

 

return function(p1) -- Line: 1
    p1:RegisterType("currency", p1.Cmdr.Util.MakeEnumType(
        "Currency",
        { "UFragments", "UPoints", "UShards", "UCoins", "EVENT", "AdventureTokens", "Gems", "DMC_RedOrbs" }
    ));
end;