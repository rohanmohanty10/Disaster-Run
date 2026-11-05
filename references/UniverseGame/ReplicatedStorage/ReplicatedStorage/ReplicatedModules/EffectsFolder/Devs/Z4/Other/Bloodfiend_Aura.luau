  

 

local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Trove = require(PathShortcuts.KnitPath.Trove);

return function(u1) -- Line: 9
    -- upvalues: ReplicatedStorage (copy), Trove (copy), RunService (copy)
    local _ = u1.HumanoidRootPart;
    local Trail = ReplicatedStorage["Client Assets"].Titles.Bloodfiend.Trail;
    local u2 = 0;
    local u3 = Trove.new();
    u3:AttachToInstance(u1);
    task.spawn(function() -- Line: 19
        -- upvalues: u3 (copy), Trail (copy), u1 (copy), RunService (ref), u2 (ref)
        local u4 = u3:Clone(Trail);
        u4.Parent = workspace.Effects;
        local Head = u1.Head;
        u3:Connect(RunService.Heartbeat, function(p5) -- Line: 27
            -- upvalues: u2 (ref), Head (copy), u4 (copy)
            u2 = (u2 + p5 * 3.141592653589793) % 6.283185307179586;
            local v6 = Head.Position + Vector3.new(0, 1, 0);
            local v7 = math.cos(u2) * 2;
            local v8 = math.sin(u2) * 2;
            u4.Position = v6 + Vector3.new(v7, 0, v8);
        end);
        task.wait(0.4);
    end);

    while u1.Parent and u1:GetAttribute("BloodfiendAura") do
        task.wait(0.1);
    end;

    u3:Destroy();
end;