 

 

local v1 = {};
local l__Modules__1 = game.ReplicatedStorage:WaitForChild("Modules");
require(l__Modules__1:WaitForChild("Debris2"));
local _ = task.wait;
local l__FunctionLibrary__2 = require(l__Modules__1:WaitForChild("FunctionLibrary"));
local l__CollectionService__3 = game:GetService("CollectionService");
function v1.Start(u2) --[[ Line: 10 ]]
    -- upvalues: l__CollectionService__3 (copy), l__FunctionLibrary__2 (copy)
    if not l__CollectionService__3:HasTag(u2, "SpeedLines") then
        l__CollectionService__3:AddTag(u2, "SpeedLines");
        local u3 = Instance.new("Part");
        u3.Transparency = 1;
        u3.Anchored = false;
        u3.CanCollide = false;
        u3.CanQuery = false;
        u3.CanTouch = false;
        u3.CFrame = u2.HumanoidRootPart.CFrame;
        local u4 = Instance.new("BodyPosition");
        u4.P = 200000;
        u4.MaxForce = Vector3.new(1, 1, 1) * (1 / 0);
        u4.Position = u2.HumanoidRootPart.CFrame.p;
        u4.Parent = u3;
        local u5 = Instance.new("BodyGyro");
        u5.P = 200000;
        u5.MaxTorque = Vector3.new(1, 1, 1) * (1 / 0);
        u5.CFrame = u2.HumanoidRootPart.CFrame;
        u5.Parent = u3;
        u3.Parent = workspace.IgnoreInstances;
        local v6 = game.ReplicatedStorage.Objects.Misc.speed_lines:Clone();
        v6.Name = "SpeedLines" .. u2.name;
        v6.CFrame = u3.CFrame;
        v6.Parent = workspace.IgnoreInstances;
        local u7 = Instance.new("ObjectValue");
        u7.Name = "SpeedLines";
        u7.Parent = u2;
        u7.Value = v6;
        local v8 = l__FunctionLibrary__2.Weld(u3, v6, CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1));
        v8.Name = "Weld";
        v8.Parent = v6;
        local u9 = nil;
        u9 = game:GetService("RunService").Heartbeat:connect(function() --[[ Line: 52 ]]
            -- upvalues: u2 (copy), u7 (copy), u9 (ref), u3 (copy), u4 (copy), u5 (copy)
            if u2 and (u2.Parent and (u7 and u7.Parent)) then
                u4.Position = u2.HumanoidRootPart.CFrame.p;
                u5.CFrame = u2.HumanoidRootPart.CFrame;
            else
                u9:Disconnect();
                u3:Destroy();
            end;
        end);
    end;
end;
function v1.End(p10) --[[ Line: 67 ]]
    -- upvalues: l__CollectionService__3 (copy)
    l__CollectionService__3:RemoveTag(p10, "SpeedLines");
    for _, v11 in pairs(p10:GetChildren()) do
        if v11.Name == "SpeedLines" then
            local l__Value__4 = v11.Value;
            v11:Destroy();
            l__Value__4.Speed.Enabled = false;
            l__Value__4.Speed2.Enabled = false;
            game.Debris:AddItem(l__Value__4, 3);
            l__Value__4.Weld:Destroy();
            l__Value__4.Anchored = true;
        end;
    end;
end;
return v1;