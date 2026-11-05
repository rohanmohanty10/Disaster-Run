  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
local u1 = game.ReplicatedStorage:WaitForChild("Client Assets");
game:GetService("TweenService");

return function(p2, p3, p4) -- Line: 8
    -- upvalues: u1 (copy)
    local v5 = p2:FindFirstChild(p4 or "StandTrail");

    if not v5 then
        v5 = u1["Made In Heaven"][p4 or "StandTrail"]:Clone();
        v5.CFrame = p2.CFrame;
        v5.Anchored = false;
        v5.CanCollide = false;
        v5.Massless = true;

        for _, descendant in pairs(v5:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:SetAttribute("StandTrail", true);
            end;
        end;

        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = p2;
        WeldConstraint.Part1 = v5;
        WeldConstraint.Parent = v5;
        v5.Parent = p2;
    end;

    for _, descendant in pairs(v5:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
            descendant.Enabled = p3 or false;
        end;
    end;
end;