 
 

local v1 = {};
local RunContext = require(script.Parent.Parent.Shared.RunContext);
local u2 = {
    [Enum.UserInputType.MouseButton1] = true,
    [Enum.UserInputType.Touch] = true
};

function v1.LevenshteinDistance(p3: string, p4: string) -- Line: 14
    local v5 = #p3;
    local v6 = #p4;
    local v7 = {};

    for i = 0, v5 do
        v7[i] = { i };
        local _ = i;
    end;

    for i = 0, v6 do
        v7[0][i] = i;
        local _ = i;
    end;

    for i = 1, v5 do
        local v8 = i;

        for i2 = 1, v6 do
            local v9 = p3:sub(v8, v8):lower() == p4:sub(i2, i2):lower() and 0 or 1;
            v7[v8][i2] = math.min(v7[v8 - 1][i2] + 1, v7[v8][i2 - 1] + 1, v7[v8 - 1][i2 - 1] + v9);
            local _ = i2;
        end;
    end;

    return v7[v5][v6];
end;

function v1.GetUserId() -- Line: 43
    -- upvalues: RunContext (copy)
    if RunContext.IsEdit then
        return game:GetService("StudioService"):GetUserId();
    end;

    local LocalPlayer = game:GetService("Players").LocalPlayer;

    return assert(LocalPlayer).UserId;
end;

function v1.PlaySound(p10: string, p11: userdata, p12: number?) -- Line: 53
    local Sound = Instance.new("Sound");
    Sound.Volume = p12 or 0.5;
    Sound.SoundId = p10;
    Sound.Playing = true;
    Sound.Parent = p11;
    Sound.Ended:Once(function() -- Line: 60
        -- upvalues: Sound (copy)
        Sound:Destroy();
    end);

    return Sound;
end;

function v1.IsPointerInput(p13: userdata) -- Line: 67
    -- upvalues: u2 (copy)
    return u2[p13.UserInputType] ~= nil;
end;

function v1.IsMoveInput(p14: userdata) -- Line: 72
    -- upvalues: u2 (copy)
    local UserInputType = p14.UserInputType;

    return UserInputType == Enum.UserInputType.MouseMovement and true or u2[UserInputType] ~= nil;
end;

return v1;