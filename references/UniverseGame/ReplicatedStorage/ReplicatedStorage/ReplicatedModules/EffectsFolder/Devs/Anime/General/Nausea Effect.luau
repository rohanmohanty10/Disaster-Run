  

 

local CameraDistortionStack = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedLibrary"):WaitForChild("CameraDistortionStack"));
local u1 = false;

return function(p2) -- Line: 5
    -- upvalues: u1 (ref), CameraDistortionStack (copy)
    local v3 = p2 or {};

    if u1 then
        return;
    end;

    u1 = true;
    local u4 = v3.Time or 1;
    local u5 = math.clamp(v3.Amplitude or 1, 0, 1);
    local u6 = v3.Frequency or 2;
    local u7 = os.clock();

    local function GetEnvelope(p8) -- Line: 16
        if p8 < 0.25 then
            return p8 / 0.25;
        end;

        return p8 < 0.75 and 1 or 1 - (p8 - 0.75) / 0.25;
    end;

    local function Wave(p9, p10, p11, p12) -- Line: 26
        return math.sin(p12 * p10 + p9) * p11;
    end;

    local u13 = nil;
    u13 = CameraDistortionStack.Register(function() -- Line: 32, Name: GetMatrix
        -- upvalues: u7 (copy), u4 (copy), u1 (ref), u13 (ref), u5 (copy), u6 (copy)
        local v14 = os.clock() - u7;

        if u4 <= v14 then
            u1 = false;

            if u13 then
                local v15 = u13;
                u13 = nil;
                task.defer(v15);
            end;

            return nil;
        end;

        local v16 = v14 / u4;
        local v17;

        if v16 < 0.25 then
            v17 = v16 / 0.25;
        else
            v17 = v16 < 0.75 and 1 or 1 - (v16 - 0.75) / 0.25;
        end;

        local v18 = u5 * v17;
        local v19 = math.sin(v14 * u6 + 0) * (v18 * 0.4);
        local v20 = v19 + math.sin(v14 * (u6 * 1.5) + 1.3) * (v18 * 0.3);
        local v21 = math.sin(v14 * (u6 * 1.2) + 2.1) * (v18 * 0.3);
        local v22 = v21 + math.sin(v14 * (u6 * 0.8) + 3.3) * (v18 * 0.2);
        local v23 = math.sin(v14 * (u6 * 1.1) + 0.7) * (v18 * 0.4);
        local v24 = v23 + math.sin(v14 * (u6 * 1.7) + 2.8) * (v18 * 0.3);
        local v25 = math.sin(v14 * (u6 * 0.9) + 1.5) * (v18 * 0.4);
        local v26 = v25 + math.sin(v14 * (u6 * 1.3) + 2.2) * (v18 * 0.3);
        local v27 = math.clamp(v20, -1, 1);
        local v28 = math.clamp(v22, -1, 1);
        local v29 = math.clamp(v24, -1, 1);
        local v30 = math.clamp(v26, -1, 1);

        return CFrame.new(0, 0, 0, 1, v27, v28, v29, 1, v30, 0, 0, 1);
    end);
end;