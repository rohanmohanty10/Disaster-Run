  

 

local u1 = nil;
local Disorient = require(script.Parent:WaitForChild("Disorient"));
local RunService = game:GetService("RunService");
local CurrentCamera = game.Workspace.CurrentCamera;

return function(p2) -- Line: 7
    -- upvalues: u1 (ref), Disorient (copy), RunService (copy), CurrentCamera (copy)
    if p2 and u1 == p2 then
        return;
    end;

    u1 = p2;

    if u1 == nil then
        return;
    end;

    task.spawn(function() -- Line: 17
        -- upvalues: Disorient (ref)
        Disorient();
        task.wait(0.05);
        Disorient();
        task.wait(0.05);
        Disorient();
        task.wait(0.05);
    end);
    task.wait(0.1);
    local v3 = p2:FindFirstChild("Head") or p2:FindFirstChildWhichIsA("BasePart");
    p2:FindFirstChildOfClass("Humanoid");

    for _, child in pairs(p2:GetChildren()) do
        if child:IsA("BasePart") and child.Name == "Head" then
            child.LocalTransparencyModifier = 1;
        elseif child:IsA("Accessory") then
            local Handle = child:FindFirstChild("Handle");

            if Handle then
                Handle.LocalTransparencyModifier = 1;
            end;
        end;
    end;

    local function GetPositionComponents(p4) -- Line: 40
        local v5, v6, v7, _, _, _, _, _, _, _, _, _ = p4:GetComponents();

        return { v5, v6, v7 };
    end;

    local function GetOrientationComponents(p8) -- Line: 45
        local _, _, _, v9, v10, v11, v12, v13, v14, v15, v16, v17 = p8:GetComponents();

        return {
            v9,
            v10,
            v11,
            v12,
            v13,
            v14,
            v15,
            v16,
            v17
        };
    end;

    local _ = v3.CFrame;

    while u1 ~= nil and u1 == p2 do
        RunService.RenderStepped:Wait();
        local v18, v19, v20, _, _, _, _, _, _, _, _, _ = v3.CFrame:GetComponents();
        local v21 = { v18, v19, v20 };
        local _, _, _, v22, v23, v24, v25, v26, v27, v28, v29, v30 = CurrentCamera.CFrame:Lerp(v3.CFrame, 0.1):GetComponents();
        CurrentCamera.CFrame = CFrame.new(v21[1], v21[2], v21[3], unpack({
            v22,
            v23,
            v24,
            v25,
            v26,
            v27,
            v28,
            v29,
            v30
        }));
    end;

    if p2 then
        for _, child in pairs(p2:GetChildren()) do
            if child:IsA("BasePart") and child.Name == "Head" then
                child.LocalTransparencyModifier = 0;
            elseif child:IsA("Accessory") then
                local Handle = child:FindFirstChild("Handle");

                if Handle then
                    Handle.LocalTransparencyModifier = 0;
                end;
            end;
        end;
    end;

    Disorient();
    task.wait(0.05);
    Disorient();
    task.wait(0.05);
    Disorient();
    task.wait(0.05);
end;