  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local _ = game:GetService("Players").LocalPlayer;
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);

local function AssertNonFatal(u1, u2) -- Line: 11
    local success, result = pcall(function() -- Line: 12
        -- upvalues: u1 (copy), u2 (copy)
        assert(u1, u2);
    end);

    if not success then
        warn(result, debug.traceback());
    end;

    return u1;
end;

local u3 = {
    TextStrokeTransparency = 0.65,
    Font = Enum.Font.Nunito,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
};

return function(p4, p5, p6) -- Line: 38
    -- upvalues: u3 (copy), EffectsHandler (copy)
    local u7;

    if p4 then
        u7 = p4.Parent;
    else
        u7 = p4;
    end;

    local u8 = "";
    local success, result = pcall(function() -- Line: 12
        -- upvalues: u7 (copy), u8 (copy)
        assert(u7, u8);
    end);

    if not success then
        warn(result, debug.traceback());
    end;

    if not u7 then
        return;
    end;

    local v9 = p6 or {};
    EffectsHandler.CallEffect("Quote V2", p4, {
        SoundVolume = 3,
        OmitReconcile = true,
        Visible = true,
        SoundId = v9.AudioId or "rbxassetid://132172761396292",
        YieldSound = v9.YieldSound or true,
        TextStyle = u3,
        LoopSound = v9.LoopSound or true,
        FullQuote = {
            {
                Quote = p5 or "",
                ScaleTime = v9.ScaleTime or 0.75,
                EndLag = v9.EndLag or 1.5
            }
        }
    }, {});
end;