  

 

local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local CurrentCamera = workspace.CurrentCamera;

return function(u1, p2) -- Line: 6
    -- upvalues: RunService (copy), CollectionService (copy), CurrentCamera (copy), TweenService (copy)
    local u3 = false;

    local function wait(p4) -- Line: 8
        -- upvalues: RunService (ref), CollectionService (ref), u1 (copy), u3 (ref)
        local v5 = 0;
        local v6 = p4 or 0;

        while true do
            v5 = v5 + RunService.Heartbeat:Wait();

            if CollectionService:HasTag(u1, "Timestopped") then
                repeat
                    CollectionService:GetInstanceRemovedSignal("Timestopped"):Wait();
                until not CollectionService:HasTag(u1, "Timestopped");
            end;

            if v6 <= v5 or u3 == true then
                return v5;
            end;
        end;
    end;

    local Part = Instance.new("Part", CurrentCamera);
    Part.CanCollide = false;
    Part.Anchored = true;
    Part.Transparency = 1;
    Part.CFrame = p2.HumanoidRootPart.CFrame * CFrame.new(0, 1, -2) * CFrame.Angles(0, 3.141592653589793, 0);
    TweenService:Create(Part, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        CFrame = p2.HumanoidRootPart.CFrame * CFrame.new(0, 10, -5) * CFrame.Angles(1.3962634015954636, 3.141592653589793, 0)
    }):Play();
    CurrentCamera.CameraType = "Scriptable";
    local u7 = {
        camConnection = RunService.RenderStepped:Connect(function() -- Line: 32
            -- upvalues: CurrentCamera (ref), Part (copy)
            CurrentCamera.CFrame = Part.CFrame;
        end),
        OnVictimDeath = p2.Humanoid.Died:Connect(function() -- Line: 35
            -- upvalues: u3 (ref)
            u3 = true;
        end),
        OnVictimLeave = p2:GetPropertyChangedSignal("Parent"):Connect(function() -- Line: 38
            -- upvalues: u3 (ref)
            u3 = true;
        end),
        OnAttackerDeath = u1.Humanoid.Died:Connect(function() -- Line: 41
            -- upvalues: u3 (ref)
            u3 = true;
        end),
        OnAttackerLeave = u1:GetPropertyChangedSignal("Parent"):Connect(function() -- Line: 44
            -- upvalues: u3 (ref)
            u3 = true;
        end)
    };

    local function stop() -- Line: 48
        -- upvalues: u7 (copy), CurrentCamera (ref)
        for _, v in pairs(u7) do
            v:Disconnect();
        end;

        CurrentCamera.CameraType = "Custom";
    end;

    wait(1);

    if u3 then
        for _, v in pairs(u7) do
            v:Disconnect();
        end;

        CurrentCamera.CameraType = "Custom";

        return;
    end;

    TweenService:Create(Part, TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        CFrame = p2.HumanoidRootPart.CFrame * CFrame.new(0, 20, -6) * CFrame.Angles(1.3962634015954636, 3.141592653589793, 0)
    }):Play();
    wait(3);

    if u3 then
        for _, v in pairs(u7) do
            v:Disconnect();
        end;

        CurrentCamera.CameraType = "Custom";

        return;
    end;

    Part.CFrame = p2.HumanoidRootPart.CFrame * CFrame.new(0, -2, -2) * CFrame.Angles(0, 0, 0);
    TweenService:Create(Part, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        CFrame = p2.HumanoidRootPart.CFrame * CFrame.new(-8, 0, -2) * CFrame.Angles(0, -1.3962634015954636, 0)
    }):Play();
    wait(1.5);

    for _, v in pairs(u7) do
        v:Disconnect();
    end;

    CurrentCamera.CameraType = "Custom";
end;