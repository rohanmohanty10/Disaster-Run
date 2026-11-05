  

 

game:GetService("TweenService");
game:GetService("CollectionService");
local ServerScriptService = game:GetService("ServerScriptService");
local PathShortcuts = require(ServerScriptService.ServerLibrary.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u1 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
local u2 = Knit.GetService("EffectService");

return {
    SpeedTrails = function(p3, p4, p5) -- Line: 18, Name: SpeedTrails
        -- upvalues: ParticleHandler (copy), AssetHandler (copy)
        if not workspace.Effects:FindFirstChild(p4.Name .. " A-Train Speed Trails") then
            local Folder = Instance.new("Folder");
            Folder.Name = p4.Name .. " A-Train Speed Trails";
            Folder.Parent = workspace.Effects;
            local v6 = ParticleHandler.GetUnusualHSVData({
                Character = p4
            });

            for i = 1, 2 do
                for i2 = 1, 2 do
                    local v7 = AssetHandler.CloneAsset("Particles/Trails/Limb", {
                        AbilityName = "UGrain Dev"
                    });
                    ParticleHandler.Unusualify(v7, {
                        HSVData = v6
                    });
                    v7.Parent = Folder;
                    ParticleHandler.AttachTo(v7, {
                        Part = p4[(i == 1 and "Right" or "Left") .. " " .. (i2 == 1 and "Arm" or "Leg")]
                    });
                end;
            end;

            local v8 = AssetHandler.CloneAsset("Particles/Trails/Body", {
                AbilityName = "UGrain Dev"
            });
            ParticleHandler.Unusualify(v8, {
                HSVData = v6
            });
            v8.Parent = Folder;
            ParticleHandler.AttachTo(v8, {
                Part = p4.Torso
            });
            p5:Add(function() -- Line: 48
                -- upvalues: ParticleHandler (ref), Folder (copy)
                ParticleHandler.DestroyEmit(Folder);
                ParticleHandler.EnableAllParticles(Folder, false);
                Folder.Name = "Inactive A-Train FX";
            end);

            return Folder;
        end;
    end,

    BurstTarget = function(p9, p10, p11) -- Line: 57, Name: BurstTarget
        -- upvalues: u1 (copy), ParticleHandler (copy), u2 (copy), AssetHandler (copy)
        local v12 = p11 and u1.FetchSound(p11, "BurstBlood" .. math.random(1, 4));

        if v12 then
            v12:Clone().Parent = p10.HumanoidRootPart;
        end;

        ParticleHandler.GetUnusualHSVData({
            Character = p11
        });
        u2.FireAllClients("Emit Particle V3", {
            Path = "Particles/BloodBurst",
            AbilityName = "UGrain Dev",
            AutoSerialize = true,
            Origin = p10.HumanoidRootPart.CFrame,
            Character = p11
        });

        for _, descendant in p10:GetDescendants() do
            if descendant:IsA("BillboardGui") or (descendant:IsA("Script") or (descendant:IsA("Decal") or (descendant:IsA("Texture") or (descendant:IsA("Motor6D") or descendant:IsA("Sound"))))) then
                descendant:Destroy();
            elseif descendant:IsA("BasePart") then
                descendant.Massless = true;
                descendant.CanCollide = false;
                descendant.CollisionGroup = "NoCollision";

                if descendant.Parent == p10 then
                    descendant.CFrame = descendant.CFrame * CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360));
                    descendant.CollisionGroup = "Ghosted";
                    descendant.CanCollide = true;
                    local BodyVelocity = Instance.new("BodyVelocity");
                    BodyVelocity.MaxForce = Vector3.new(10000000, 1000, 100000);
                    BodyVelocity.Velocity = descendant.CFrame.LookVector * math.random(20, 30);
                    BodyVelocity.Parent = descendant;
                    task.delay(math.random(25, 42) / 100, BodyVelocity.Destroy, BodyVelocity);

                    for _, child in AssetHandler.GetAsset("Particles/LimbBlood", {
                        AbilityName = "UGrain Dev"
                    }):GetChildren() do
                        child:Clone().Parent = descendant;
                    end;
                end;
            end;
        end;
    end
};