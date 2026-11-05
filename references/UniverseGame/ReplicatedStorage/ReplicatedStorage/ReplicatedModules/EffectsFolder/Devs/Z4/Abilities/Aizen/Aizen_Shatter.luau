  

 

local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Trove = require(PathShortcuts.KnitPath.Trove);
local u1 = Random.new();

return function() -- Line: 10
    -- upvalues: Trove (copy), u1 (copy), TweenService (copy), RunService (copy)
    local u2 = Trove.new();
    local u3 = u2:Add(script.Effect:Clone());
    u3.Parent = workspace.Effects;
    task.delay(0.8, u3.Destroy, u3);

    local function BindSignalDisconnectToInstanceDestroying(p4, u5, p6) -- Line: 13
        -- upvalues: u2 (copy)
        local u7 = u2:Extend();

        local function Deletion() -- Line: 16
            -- upvalues: u5 (copy), u7 (copy)
            if u5.Parent == nil then
                u7:Destroy();
            end;
        end;

        task.defer(Deletion);
        u7:Add(u5:GetPropertyChangedSignal("Parent"):Connect(Deletion));
        u7:Add(p4:Connect(p6));

        return u7;
    end;

    for _ = 1, 20 do
        local v8 = u2:Add(script.Shard:Clone());
        v8.CFrame = u3.PrimaryPart.CFrame * CFrame.new(u1:NextInteger(-40, 40) / 10, u1:NextInteger(-20, 20) / 10, 0);
        local _ = v8.Size;
        local Size = v8.Size;
        local v9 = u1:NextInteger(0.5, 3);
        local v10 = u1:NextInteger(0.5, 3);
        v8.Size = Size + Vector3.new(v9, v10, u1:NextInteger(0.5, 3));
        TweenService:Create(v8, TweenInfo.new(u1:NextInteger(150, 500) / 100, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = Vector3.new(0, 0, 0)
        }):Play();
        local v11 = u1:NextInteger(-5, 5);
        local v12 = u1:NextInteger(-5, 5);
        v8.AssemblyAngularVelocity = Vector3.new(v11, v12, u1:NextInteger(-5, 5));
        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Velocity = (u3.PrimaryPart.CFrame * CFrame.Angles(u1:NextInteger(-15, -15), u1:NextInteger(-25, 25), 0)).LookVector * u1:NextInteger(1, 75) / 10;
        BodyVelocity.Parent = v8;
        v8.Parent = u3.Shards;
    end;

    u2:Add((BindSignalDisconnectToInstanceDestroying(RunService.PostSimulation, u3, function() -- Line: 50
        -- upvalues: u3 (copy)
        if not (u3 and u3:FindFirstChild("Shards")) then
            return;
        end;

        u3:PivotTo(workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -7));

        for _, v in u3.Shards:QueryDescendants("BodyVelocity") do
            v.Velocity = v.Velocity - Vector3.new(0, 0.25, 0) - u3.PrimaryPart.CFrame.LookVector * 0.15;
        end;
    end)));
end;