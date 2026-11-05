  

 

local RunService = game:GetService("RunService");
local GameSettings = UserSettings().GameSettings;
local u1 = {
    _MaxQuality = 10
};
local SavedQualityLevel = GameSettings.SavedQualityLevel;
GameSettings:GetPropertyChangedSignal("SavedQualityLevel"):Connect(function() -- Line: 9
    -- upvalues: SavedQualityLevel (ref), GameSettings (copy)
    SavedQualityLevel = GameSettings.SavedQualityLevel;
end);

if RunService:IsClient() then
    function u1.GetMaxQuality() -- Line: 14
        -- upvalues: u1 (copy)
        return u1._MaxQuality;
    end;

    function u1.GetQualityScale() -- Line: 18
        -- upvalues: u1 (copy)
        return u1._MaxQuality;
    end;

    function u1.GetRawQualityLevel() -- Line: 22
        -- upvalues: SavedQualityLevel (ref)
        return SavedQualityLevel;
    end;

    function u1.GetQualityLevel() -- Line: 26
        -- upvalues: SavedQualityLevel (ref), u1 (copy)
        return SavedQualityLevel == Enum.SavedQualitySetting.Automatic and u1.GetQualityScale() / 2 or SavedQualityLevel.Value;
    end;

    function u1.ScaleQuality(p2) -- Line: 31
        -- upvalues: u1 (copy)
        local v3 = p2 * (u1.GetQualityLevel() / u1.GetQualityScale());
        local v4 = math.ceil(v3);

        return math.clamp(v4, 1, p2);
    end;
end;

return u1;