 
 

local RunService = game:GetService("RunService");
local workspace_CurrentCamera = workspace.CurrentCamera;
local v1 = {};

local function randomOffset(p2) -- Line: 5
    local v3 = (math.random() - 0.5) * 2 * p2;
    local v4 = (math.random() - 0.5) * 2 * p2;
    local v5 = (math.random() - 0.5) * 2 * p2;

    return Vector3.new(v3, v4, v5);
end;

local function randomRotation(p6) -- Line: 13
    return CFrame.Angles((math.random() - 0.5) * 2 * p6, (math.random() - 0.5) * 2 * p6, (math.random() - 0.5) * 2 * p6);
end;

function v1.shake(p7, p8, p9) -- Line: 21
    -- upvalues: RunService (copy), workspace_CurrentCamera (copy), randomRotation (copy)
    local u10 = p7 or 0.5;
    local u11 = p8 or 0.05;
    local u12 = p9 or 0.5;
    local u13 = 0;
    local u14 = nil;
    u14 = RunService.RenderStepped:Connect(function(p15) -- Line: 27
        -- upvalues: u13 (ref), u12 (copy), u10 (copy), u11 (copy), workspace_CurrentCamera (ref), randomRotation (ref), u14 (ref)
        u13 = u13 + p15;
        local v16 = u13 / u12;
        local v17 = u10 * (1 - v16);
        local CFrame2 = workspace_CurrentCamera.CFrame;
        local CFrame_new = CFrame.new;
        local v18 = (math.random() - 0.5) * 2 * v17;
        local v19 = (math.random() - 0.5) * 2 * v17;
        local v20 = (math.random() - 0.5) * 2 * v17;
        workspace_CurrentCamera.CFrame = CFrame2 * CFrame_new((Vector3.new(v18, v19, v20))) * randomRotation(u11 * (1 - v16));

        if u12 <= u13 then
            u14:Disconnect();
        end;
    end);
end;

function v1.shake2D(p21, p22) -- Line: 41
    -- upvalues: RunService (copy), workspace_CurrentCamera (copy)
    local u23 = p21 or 0.5;
    local u24 = p22 or 0.5;
    local u25 = 0;
    local u26 = nil;
    u26 = RunService.RenderStepped:Connect(function(p27) -- Line: 46
        -- upvalues: u25 (ref), u24 (copy), workspace_CurrentCamera (ref), u23 (copy), u26 (ref)
        u25 = u25 + p27;
        local v28 = 1 - math.clamp(u25 / u24, 0, 1);
        local v29 = workspace_CurrentCamera;
        v29.CFrame = v29.CFrame * CFrame.new((math.random() - 0.5) * u23 * v28, (math.random() - 0.5) * u23 * v28, 0);

        if u24 <= u25 then
            u26:Disconnect();
        end;
    end);
end;

function v1.continuous(p30, p31) -- Line: 60
    -- upvalues: RunService (copy), workspace_CurrentCamera (copy), randomRotation (copy)
    local u32 = p30 or 0.3;
    local u33 = p31 or 0.03;
    local u34 = true;
    local u39 = RunService.RenderStepped:Connect(function() -- Line: 64
        -- upvalues: u34 (ref), workspace_CurrentCamera (ref), u32 (copy), randomRotation (ref), u33 (copy)
        if not u34 then
            return;
        end;

        local CFrame2 = workspace_CurrentCamera.CFrame;
        local CFrame_new = CFrame.new;
        local v35 = u32;
        local v36 = (math.random() - 0.5) * 2 * v35;
        local v37 = (math.random() - 0.5) * 2 * v35;
        local v38 = (math.random() - 0.5) * 2 * v35;
        workspace_CurrentCamera.CFrame = CFrame2 * CFrame_new((Vector3.new(v36, v37, v38))) * randomRotation(u33);
    end);

    return function() -- Line: 70
        -- upvalues: u34 (ref), u39 (copy)
        u34 = false;
        u39:Disconnect();
    end;
end;

function v1.trauma(p40, p41, p42, p43) -- Line: 76
    -- upvalues: RunService (copy), workspace_CurrentCamera (copy), randomRotation (copy)
    local math_clamp_ret = math.clamp(p40 or 0.5, 0, 1);
    local u44 = p41 or 0.8;
    local u45 = p42 or 1;
    local u46 = p43 or 0.1;
    local u47 = nil;
    u47 = RunService.RenderStepped:Connect(function(p48) -- Line: 82
        -- upvalues: math_clamp_ret (ref), u44 (copy), u45 (copy), u46 (copy), workspace_CurrentCamera (ref), randomRotation (ref), u47 (ref)
        math_clamp_ret = math.max(0, math_clamp_ret - u44 * p48);
        local v49 = math_clamp_ret * math_clamp_ret;
        local v50 = v49 * u45;
        local CFrame2 = workspace_CurrentCamera.CFrame;
        local CFrame_new = CFrame.new;
        local v51 = (math.random() - 0.5) * 2 * v50;
        local v52 = (math.random() - 0.5) * 2 * v50;
        local v53 = (math.random() - 0.5) * 2 * v50;
        workspace_CurrentCamera.CFrame = CFrame2 * CFrame_new((Vector3.new(v51, v52, v53))) * randomRotation(v49 * u46);

        if math_clamp_ret <= 0 then
            u47:Disconnect();
        end;
    end);
end;

return v1;