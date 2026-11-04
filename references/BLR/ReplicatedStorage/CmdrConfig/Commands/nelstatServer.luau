  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local u1 = {
    Goals = true,
    Assists = true,
    Saves = true,
    Steals = true
};

return function(p2, p3, p4, p5) -- Line: 6
    -- upvalues: u1 (copy), Knit (copy)
    local v6 = p4:sub(1, 1):upper() .. p4:sub(2):lower();

    if not u1[v6] then
        return "Invalid stat — use Goals, Assists, Saves, or Steals";
    end;

    local v7, v8 = Knit.GetService("SalaryService"):AdminGiveStat(p3, v6, p5);

    if v7 then
        return string.format("Gave %s %d %s", p3.Name, p5, v6);
    end;

    return "Failed: " .. tostring(v8);
end;