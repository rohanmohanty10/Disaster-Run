  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);

return function(p1) -- Line: 9
    -- upvalues: Trove (copy), ParticleHandler (copy)
    local v2 = p1 or {};
    local Character = v2.Character;
    local v3 = v2.Lifetime or 3;
    local v4 = (v2.Direction or "Left") .. " Leg";

    if not (Character and Character:FindFirstChild(v4)) then
        return;
    end;

    local u5 = Trove.new();
    u5:AttachToInstance(Character);
    local u6 = {};
    local v7 = Character:FindFirstChildWhichIsA("Pants");
    local v8 = Character:FindFirstChildWhichIsA("BodyColors") or {
        RightLegColor3 = Color3.fromRGB(255, 205, 144),
        LeftLegColor3 = Color3.fromRGB(255, 205, 144)
    };
    local u9 = Character:FindFirstChild(v4);
    local v10 = v4 ~= "Left Leg" and v8.RightLegColor3 or v8.LeftLegColor3;
    local v11 = u5:Clone(script.Container);
    v11.Parent = workspace.Effects;
    local v12 = v11:FindFirstChild(v4);
    v12.Color = v10;
    v12.CFrame = u9.CFrame;
    v12.CollisionGroup = "Ghosted";

    if v7 then
        v7:Clone().Parent = v11;
    end;

    u9.Transparency = 1;
    v12.Transparency = 0;
    local u13 = script.Particle:Clone();
    u13.Parent = workspace.Effects;
    ParticleHandler.EnableParticle(u13, true);
    ParticleHandler.AttachTo(u13, {
        Part = Character:FindFirstChild("Torso")
    });
    u5:Add(function() -- Line: 61
        -- upvalues: ParticleHandler (ref), u13 (copy)
        ParticleHandler.EnableParticle(u13, false);
        ParticleHandler.DestroyEmit(u13);
    end);

    for _, descendant in u9:GetDescendants() do
        if descendant:IsA("Decal") or (descendant:IsA("BasePart") or descendant:IsA("Texture")) then
            descendant.Transparency = 1;
            table.insert(u6, descendant);
        end;
    end;

    task.delay(v3, function() -- Line: 73
        -- upvalues: u5 (copy), u9 (copy), u6 (copy)
        u5:Destroy();
        u9.Transparency = 0;

        for _, v in u6 do
            v.Transparency = 0;
        end;
    end);
end;