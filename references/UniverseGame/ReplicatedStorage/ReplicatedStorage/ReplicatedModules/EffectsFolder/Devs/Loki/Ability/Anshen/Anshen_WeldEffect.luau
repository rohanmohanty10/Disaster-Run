  

 

local _ = game.ReplicatedStorage["Client Assets"];
local Petal = require(game.ReplicatedStorage.ReplicatedModules:WaitForChild("Petal"));
local u1 = Petal("Util");
local u2 = Petal("New");

return function(p3, p4, p5, p6, p7) -- Line: 6
    -- upvalues: u2 (copy), u1 (copy)
    local u8 = p4:Clone();
    local HumanoidRootPart = p3.HumanoidRootPart;
    local v9 = u2("Maid");
    u8.Parent = HumanoidRootPart;
    u2("Weld")({
        Parent = HumanoidRootPart,
        Part0 = HumanoidRootPart,
        Part1 = u8
    });
    local v10 = p7 and u1.ShiftObjectHueAbsolute or u1.ShiftObjectHue;
    local v11 = p6 or 0;

    for _, descendant in pairs(u8:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or (descendant:IsA("PointLight") or descendant:IsA("Trail")) then
            v10(descendant, v11);
        end;
    end;

    local v12 = v9 + function() -- Line: 28
        -- upvalues: u8 (copy)
        for _, descendant in pairs(u8:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("PointLight") then
                descendant.Enabled = false;
            end;
        end;

        task.delay(1, u8.Destroy, u8);
    end;
    task.delay(p5, v12.Destroy, v12);
end;