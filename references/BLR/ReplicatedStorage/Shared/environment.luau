  

local v1 = {
    Dev = {
        Normal = 88233429548268,
        Normal8v8 = 132344939934019,
        Pro = 92287296992635,
        Custom = 76686851445962,
        Noob = 71309721159772,
        Tutorial = 131555438595295,
        AfkWorld = 104564848623099,
        Normal3v3 = 104781835901710,
        Ranked = 75313569154781,
        WorldTournament = 108164315467008
    },
    AC = {
        Normal = 101367510064034,
        Normal8v8 = 132344939934019,
        Pro = 101367510064034,
        Custom = 101367510064034,
        LTM = 101367510064034,
        Noob = 101367510064034,
        Tutorial = 101367510064034,
        AfkWorld = 101367510064034
    },
    Main = {
        Normal = 18668065416,
        Normal8v8 = 124087144919678,
        Pro = 99999183305180,
        Custom = 92517437168342,
        Noob = 115110570222234,
        Tutorial = 77915441816737,
        AfkWorld = 124044706645343,
        Ranked = 120174012332958,
        Normal3v3 = 96295071527827,
        WorldTournament = 87645694182203
    }
};
local v2 = {
    [6840797264] = "Dev",
    [6325068386] = "Main",
    [7299826510] = "AC"
};
local v3 = v2[game.GameId];
local v4 = nil;

for i, v in v1[v3] do
    if game.PlaceId == v then
        v4 = i;
        break;
    end;
end;

local v5 = require(script.Configs:FindFirstChild(v4) or script.Configs.Default);

return {
    env = v2[game.GameId],
    mode = v4,
    config = v5,
    sub = v1[v3]
};