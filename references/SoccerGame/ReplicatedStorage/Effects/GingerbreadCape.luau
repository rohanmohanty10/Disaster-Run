  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local Debris = game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);

return function(u1) -- Line: 8
    -- upvalues: ReplicatedStorage (copy), Essentials (copy), VfxManager (copy), Debris (copy)
    local u2 = ReplicatedStorage.Assets.Misc.Gingerbread:Clone();
    u2.CFrame = u1.Char.Torso.CFrame;
    u2.CanCollide = false;
    u2.Anchored = false;
    u2.Massless = true;
    u2.Parent = workspace;
    Essentials:Weld(u2, u1.Char.Torso);
    local Descendants = u1.Char:GetDescendants();
    local u3 = {};

    for _, v in pairs(Descendants) do
        if (v:IsA("Part") ~= false or v:IsA("MeshPart") ~= false) and v.Name ~= "HumanoidRootPart" then
            u3[v] = v.Transparency;
            v.Transparency = 1;
        end;
    end;

    local v4 = ReplicatedStorage.Assets.Vfx.IceAnkleBreaker:Clone();
    v4.Parent = workspace;
    v4.CFrame = u2.CFrame;
    VfxManager.Emit(v4);
    Debris:AddItem(v4, 2);
    task.delay(u1.Timer, function() -- Line: 33
        -- upvalues: u2 (copy), ReplicatedStorage (ref), VfxManager (ref), Descendants (copy), u3 (copy)
        u2:Destroy();
        local u5 = ReplicatedStorage.Assets.Vfx.IceAnkleBreaker:Clone();
        u5.Parent = workspace;
        u5.CFrame = u2.CFrame;
        VfxManager.Emit(u5);

        for _, v in pairs(Descendants) do
            if (v:IsA("Part") ~= false or v:IsA("MeshPart") ~= false) and v.Name ~= "HumanoidRootPart" then
                v.Transparency = u3[v];
            end;
        end;

        task.delay(2, function() -- Line: 47
            -- upvalues: u5 (copy)
            u5:Destroy();
        end);
    end);
    task.delay(3, function() -- Line: 52
        -- upvalues: u1 (copy), u3 (copy), Descendants (copy)
        table.clear(u1);
        table.clear(u3);
        table.clear(Descendants);
    end);
end;