  

 

local v1 = {
    SoundIndex = {
        ["1"] = "SoundId",
        ["2"] = "Volume",
        ["3"] = "PlaybackSpeed",
        ["4"] = "PlaybackRegionsEnabled",
        ["5"] = "PlaybackRegion",
        ["6"] = "Looped",
        ["7"] = "LoopRegion",
        ["8"] = "RollOffMinDistance",
        ["9"] = "RollOffMaxDistance",
        ["10"] = "Cleanup",
        ["11"] = "Transformer",
        ["12"] = "Parent",
        ["13"] = "Vector3",
        ["14"] = "Effects",
        ["15"] = "Attributes",
        ["16"] = "SoundGroup"
    },
    SoundKeys = {}
};

for i, v in pairs(v1.SoundIndex) do
    v1.SoundKeys[v] = i;
end;

return v1;