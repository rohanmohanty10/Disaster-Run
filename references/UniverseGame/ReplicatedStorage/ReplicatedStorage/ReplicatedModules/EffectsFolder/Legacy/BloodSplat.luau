  

 

game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = game:GetService("Players").LocalPlayer;
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
Random.new();
local v1 = RaycastParams.new();
v1.FilterType = Enum.RaycastFilterType.Include;
v1.FilterDescendantsInstances = { workspace.Map };

return function(p2, p3, p4) -- Line: 17
    -- upvalues: LocalPlayer (copy), AssetHandler (copy), ParticleHandler (copy)
    local v5 = p4 or {};
    local v6 = typeof(v5) == "boolean" and {
        Guts = v5
    } or v5;

    if LocalPlayer.Settings.Gore.Value == false then
        return;
    end;

    local v7 = p2.Torso.CFrame * (v6.Offset or CFrame.identity);

    for i = 1, 25 do
        if i == 1 then
            local u8 = game.ReplicatedStorage["Client Assets"]["King Crimson"].Intestine:Clone();
            u8.Parent = game.Workspace.Effects;
            u8.CanCollide = false;
            local Angles = CFrame.Angles;
            local v9 = math.random(-45, 45);
            local v10 = math.rad(v9);
            local v11 = math.random(-45, 45);
            local v12 = math.rad(v11);
            local v13 = math.random(-45, 45);
            u8.CFrame = v7 * Angles(v10, v12, (math.rad(v13)));

            if v6.Guts == false then
                u8.Transparency = 1;
            end;

            local BodyPosition = Instance.new("BodyPosition");
            BodyPosition.D = 800;
            BodyPosition.MaxForce = Vector3.new(inf, inf, inf);
            BodyPosition.Position = (u8.CFrame * CFrame.new(0, 0, -math.random(5, 7))).Position;
            BodyPosition.Parent = u8;
            coroutine.wrap(function() -- Line: 46
                -- upvalues: BodyPosition (copy), u8 (copy)
                wait(0.2);
                BodyPosition:Destroy();
                u8.CanCollide = true;
                wait(5);
                u8:Destroy();
            end)();
            local u14 = game.ReplicatedStorage["Client Assets"]["King Crimson"].Heart:Clone();
            u14.Parent = game.Workspace.Effects;
            u14.CanCollide = false;
            local Angles2 = CFrame.Angles;
            local v15 = math.random(-45, 45);
            local v16 = math.rad(v15);
            local v17 = math.random(-45, 45);
            local v18 = math.rad(v17);
            local v19 = math.random(-45, 45);
            u14.CFrame = v7 * Angles2(v16, v18, (math.rad(v19)));

            if v6.Guts == false then
                u14.Transparency = 1;
            end;

            local BodyPosition2 = Instance.new("BodyPosition");
            BodyPosition2.D = 800;
            BodyPosition2.MaxForce = Vector3.new(inf, inf, inf);
            BodyPosition2.Position = (u14.CFrame * CFrame.new(0, 0, -math.random(5, 7))).Position;
            BodyPosition2.Parent = u14;
            coroutine.wrap(function() -- Line: 68
                -- upvalues: BodyPosition2 (copy), u14 (copy)
                wait(0.2);
                BodyPosition2:Destroy();
                u14.CanCollide = true;
                wait(5);
                u14:Destroy();
            end)();
        end;

        for _ = 1, 4 do
            local u20 = game.ReplicatedStorage["Client Assets"]["King Crimson"].BloodTrail:Clone();
            u20.Parent = game.Workspace.Effects;
            u20.CanCollide = false;
            local Angles = CFrame.Angles;
            local v21 = math.random(-45, 45);
            local v22 = math.rad(v21);
            local v23 = math.random(-45, 45);
            local v24 = math.rad(v23);
            local v25 = math.random(-45, 45);
            u20.CFrame = v7 * Angles(v22, v24, (math.rad(v25)));
            local v26 = next;
            local v27, v28 = u20:GetDescendants();

            for _, v in v26, v27, v28 do
                if v:IsA("Trail") then
                    v.Lifetime = math.random(1, 5) / 10;
                end;
            end;

            local BodyPosition = Instance.new("BodyPosition");
            BodyPosition.D = 800;
            BodyPosition.MaxForce = Vector3.new(inf, inf, inf);
            BodyPosition.Position = (u20.CFrame * CFrame.new(0, math.random(-2, 2), -math.random(5, 13))).Position;
            BodyPosition.Parent = u20;
            coroutine.wrap(function() -- Line: 94
                -- upvalues: BodyPosition (copy), u20 (copy), AssetHandler (ref), ParticleHandler (ref)
                wait(0.2);
                BodyPosition:Destroy();
                wait(0.2);
                local v29 = { game.Workspace.Living, game.Workspace.Effects, game.Workspace.NPCS };
                local v30 = Ray.new(u20.Position, Vector3.new(0, -15, 0));
                local v31, v32 = game.Workspace:FindPartOnRayWithIgnoreList(v30, v29);

                if v31 then
                    local v33 = AssetHandler.CloneAsset("Particles/Mes/BloodSplatter", {
                        AbilityName = "Ope"
                    });
                    v33.Position = v32;
                    v33.Parent = workspace.Effects;
                    ParticleHandler.DestroyEmit(v33);
                    ParticleHandler.Emit(v33, ParticleHandler.GenerateEmitInfo(v33));
                end;

                wait(0.3);
                u20:Destroy();
            end)();
        end;

        wait();
    end;
end;