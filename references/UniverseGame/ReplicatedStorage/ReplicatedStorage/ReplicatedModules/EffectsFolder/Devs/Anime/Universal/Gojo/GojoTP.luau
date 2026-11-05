  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Trove = require(PathShortcuts.KnitPath.Trove);

return function(u1, u2) -- Line: 8
    -- upvalues: TweenService (copy), Debris (copy), Trove (copy), ReplicatedStorage (copy)
    task.spawn(function() -- Line: 9
        -- upvalues: u1 (copy), TweenService (ref), Debris (ref)
        local v3 = Random.new();

        for _ = 1, 5 do
            local Part = Instance.new("Part", workspace.Effects);
            Part.Shape = Enum.PartType.Ball;
            Part.Color = Color3.new(1, 1, 1);
            Part.Anchored = true;
            Part.CanCollide = false;
            Part.CastShadow = false;
            Part.Size = Vector3.new(0.1, 0.1, 0.1);
            Part.Material = Enum.Material.Neon;
            local Position = u1.HumanoidRootPart.Position;
            local v4 = v3:NextNumber(-3, 3);
            local v5 = v3:NextNumber(-4, 1);
            Part.Position = Position + Vector3.new(v4, v5, v3:NextNumber(-3, 3));
            local v6 = TweenInfo.new(1, Enum.EasingStyle.Exponential);
            local v7 = {
                Transparency = 1
            };
            local Position2 = Part.Position;
            local v8 = v3:NextNumber(3, 5);
            v7.Position = Position2 + Vector3.new(0, v8, 0);
            TweenService:Create(Part, v6, v7):Play();
            Debris:AddItem(Part, 1);
        end;
    end);
    local v9 = Trove.new();

    for _, child in pairs(ReplicatedStorage["Client Assets"].Gojo.teleport.particles:GetChildren()) do
        local v10 = v9:Clone(child);
        v10.Parent = u1.HumanoidRootPart;
        v10:Emit(25);
    end;

    if u2 then
        task.spawn(function() -- Line: 32
            -- upvalues: u1 (copy), u2 (copy)
            local v11 = {};

            for _, descendant in ipairs(u1:GetDescendants()) do
                if descendant:IsA("BasePart") or descendant:IsA("Decal") then
                    v11[descendant] = descendant.Transparency;
                    descendant.Transparency = 1;
                end;
            end;

            wait(u2);

            for i, v in pairs(v11) do
                i.Transparency = v;
            end;
        end);
    end;

    task.delay(1, v9.Destroy, v9);
end;