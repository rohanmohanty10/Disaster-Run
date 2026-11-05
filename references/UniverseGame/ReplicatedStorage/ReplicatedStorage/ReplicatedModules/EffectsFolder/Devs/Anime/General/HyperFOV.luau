  

 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local CameraDistortionStack = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedLibrary"):WaitForChild("CameraDistortionStack"));
local u1 = false;

return function(p2) -- Line: 8
    -- upvalues: u1 (ref), LocalPlayer (copy), CameraDistortionStack (copy)
    local v3 = p2 or {};

    if u1 then
        return;
    end;

    u1 = true;
    local u4 = v3.StartFOV or (LocalPlayer.Settings.FieldOfView.Value or 70);
    local u5 = v3.EndFOV or 170;
    local u6 = v3.TimeIn or 1;
    local u7 = v3.TimeOut or 1;
    local u8 = v3.WaitTime or 0;
    local u9 = u6 + u7 + u8;
    local u10 = os.clock();

    local function CalculateEnvelope(p11) -- Line: 22
        -- upvalues: u6 (copy), u8 (copy), u7 (copy)
        if p11 < u6 then
            local v12 = p11 / u6;

            return math.pow(v12, 2) * (3 - 2 * v12);
        end;

        if p11 < u6 + u8 then
            return 1;
        end;

        local v13 = math.clamp((p11 - u6 - u8) / u7, 0, 1);

        return 1 - math.pow(v13, 2) * (3 - 2 * v13);
    end;

    local u14 = nil;
    u14 = CameraDistortionStack.Register(function() -- Line: 37, Name: GetMatrix
        -- upvalues: u10 (copy), u9 (copy), u1 (ref), u14 (ref), u6 (copy), u8 (copy), u7 (copy), u4 (copy), u5 (copy)
        local v15 = os.clock() - u10;

        if u9 <= v15 then
            u1 = false;

            if u14 then
                local v16 = u14;
                u14 = nil;
                task.defer(v16);
            end;

            return nil;
        end;

        local v17;

        if v15 < u6 then
            local v18 = v15 / u6;
            v17 = math.pow(v18, 2) * (3 - 2 * v18);
        elseif v15 < u6 + u8 then
            v17 = 1;
        else
            local v19 = math.clamp((v15 - u6 - u8) / u7, 0, 1);
            v17 = 1 - math.pow(v19, 2) * (3 - 2 * v19);
        end;

        local v20 = math.rad(u4 / 2);
        local v21 = math.tan(v20);
        local v22 = math.rad((u4 + (u5 - u4) * v17) / 2);
        local v23 = v21 / math.tan(v22);
        local v24 = math.clamp(v23, 0, 1);

        return CFrame.new(0, 0, 0, v24, 0, 0, 0, v24, 0, 0, 0, 1);
    end);
end;