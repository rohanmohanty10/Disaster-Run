  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.GenericModule);
local _ = PathShortcuts.ClientAssets;
local PathShortcuts2 = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
game:GetService("RunService");
local EffectsHandler = require(PathShortcuts2.ReplicatedModules.EffectsHandler);
require(Knit.Util.Trove);
local Petal = _G.Petal;
local u1 = Petal("New");
local u2 = Petal("Util");

return function(u3) -- Line: 19, Name: CreateWormhole
    -- upvalues: u1 (copy), EffectsHandler (copy), u2 (copy)
    local v4 = u3.Origin or CFrame.identity;
    local u5 = u3.Radius or 10;
    local u6 = u3.Segments or 15;
    local Reference = u3.Reference;
    local u7 = u3.TransitionIn or 0.25;
    local u8 = u3.TransitionOut or 0.5;
    local u9 = false;
    local u10 = table.create(u6);
    local u11 = table.create(u6);
    local u12 = u1("Model")({
        Name = "Wormhole"
    });
    local u13 = v4 * CFrame.new(0, -0.15, 0);
    local u14 = u5 / 2.65 + 0.2;
    task.delay(u7, function() -- Line: 38
        -- upvalues: EffectsHandler (ref), u3 (copy), u13 (ref), u14 (copy)
        EffectsHandler.CallEffect("Emit Particle V3", {
            Path = "Particles/WormholeAppear",
            AutoSerialize = true,
            AbilityName = "Tusk ACT4",
            Player = u3.Player,
            Origin = u13,
            Scale = u14
        });
    end);
    EffectsHandler.CallEffect("Play Sound At", {
        Object = u3.SpawnSound,
        Origin = u13,
        Volume = u14
    });
    local v15 = nil;

    for i = 1, u6 do
        local v16 = u1("Part")({
            Anchored = true,
            Size = Vector3.new(0.25, 0.25, 0.25),
            Transparency = 1,
            CanCollide = false,
            Name = i,
            Parent = u12,
            CFrame = u13,
            Children = {
                BeamAttachment = u1("Attachment")({})
            }
        });
        u10[i] = v16;
        u2.Tween(v16, u7, "Back", "Out", {
            CFrame = u13 * CFrame.Angles(0, math.rad(360 / u6) * i, 0) * CFrame.new(0, 0, -u5) * CFrame.Angles(1.5707963267948966, 0, 0)
        });

        if v15 then
            local v17 = v16:FindFirstChildOfClass("Attachment");
            local v18 = v15:FindFirstChildOfClass("Attachment");
            local u19 = u1("Beam")({
                Name = "WormholeBeam",
                LightEmission = 0,
                LightInfluence = 0,
                Width0 = 0,
                Width1 = 0,
                ZOffset = 0,
                Parent = v16,
                Attachment0 = v17,
                Attachment1 = v18,
                Transparency = NumberSequence.new(0),
                Color = ColorSequence.new(Color3.new())
            });
            u11[i] = u19;
            task.delay(u7 * 0.8, function() -- Line: 100
                -- upvalues: u2 (ref), u19 (copy), u7 (copy), u5 (copy)
                u2.Tween(u19, u7 * 2, "Back", "InOut", {
                    Width0 = u5 * 2.5,
                    Width1 = u5 * 2.5
                });
            end);

            if i == u6 then
                local v20 = u10[1];
                local v21 = v16:FindFirstChildOfClass("Attachment");
                local v22 = v20:FindFirstChildOfClass("Attachment");
                local u23 = Instance.fromExisting(u19);
                u23.Attachment0 = v21;
                u23.Attachment1 = v22;
                u23.Parent = v20;
                u11[1] = u23;
                task.delay(u7 * 0.8, function() -- Line: 115
                    -- upvalues: u2 (ref), u23 (copy), u7 (copy), u5 (copy)
                    u2.Tween(u23, u7 * 2, "Back", "InOut", {
                        Width0 = u5 * 2.5,
                        Width1 = u5 * 2.5
                    });
                end);
            end;
        end;

        v15 = v16;
    end;

    local u24 = nil;
    local u25 = nil;
    task.delay(u7 / 1.5, function() -- Line: 125
        -- upvalues: u24 (ref), u25 (ref), EffectsHandler (ref), u3 (copy), u13 (ref), u14 (copy)
        local v26, v27 = EffectsHandler.CallEffect("Play Sound At", {
            Object = u3.LoopSound,
            Origin = u13,
            Volume = u14
        });
        u24 = v26;
        u25 = v27;
    end);

    local function Cleanup() -- Line: 134
        -- upvalues: u9 (ref), u10 (copy), u2 (ref), u8 (copy), u13 (ref), u11 (copy), EffectsHandler (ref), u3 (copy), u14 (copy), u24 (ref), u25 (ref), u12 (copy)
        u9 = false;

        for i = 1, #u10 do
            u2.Tween(u10[i], u8 * 0.8, "Quad", "InOut", {
                Position = u13.Position
            });
            u2.Tween(u11[i], u8 * 0.785, "Back", "In", {
                Width0 = 0,
                Width1 = 0
            });
        end;

        task.delay(u8 * 0.78, function() -- Line: 142
            -- upvalues: EffectsHandler (ref), u3 (ref), u13 (ref), u14 (ref)
            EffectsHandler.CallEffect("Emit Particle V3", {
                Path = "Particles/WormholeDisappear",
                AutoSerialize = true,
                AbilityName = "Tusk ACT4",
                Player = u3.Player,
                Origin = u13,
                Scale = u14
            });
        end);
        EffectsHandler.CallEffect("Play Sound At", {
            Object = u3.DespawnSound,
            Origin = u13,
            Volume = u14
        });

        if u24 then
            u2.Tween(u24, u8 * 0.8, "Quad", "InOut", {
                Volume = 0
            });
        end;

        task.delay(u8 * 2.5, function() -- Line: 163
            -- upvalues: u10 (ref), u11 (ref), u25 (ref), u12 (ref)
            table.clear(u10);
            table.clear(u11);

            if u25 then
                u25:Destroy();
            end;

            u12:Destroy();
        end);
    end;

    task.delay(u7, function() -- Line: 175
        -- upvalues: u9 (ref), u10 (copy), u13 (ref), u6 (copy), u5 (copy), u11 (copy)
        u9 = true;
        local v28 = math.random(1, 100000000) / 1000000;

        while u9 do
            for i = 1, #u10 do
                local v29 = u10[i];
                local v30 = math.noise(math.noise(i ^ 5 / 1000), math.noise(-i ^ 5 - 0.1), os.clock() + i * v28);
                v29.CFrame = v29.CFrame:Lerp(u13 * CFrame.Angles(0, math.rad(360 / u6) * i, 0) * CFrame.new(0, 0, -u5) * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(0, v30 * u5 / 2, 0), 0.5);
                u11[i].CurveSize0 = v30 / 2;
                u11[i].CurveSize1 = v30 / 2;
            end;

            task.wait();
        end;
    end);
    task.spawn(function() -- Line: 197
        -- upvalues: Reference (copy), u8 (copy), u25 (ref), Cleanup (copy)
        while Reference and Reference:IsDescendantOf(workspace) do
            task.wait(0.1);
        end;

        task.delay(u8 * 3, function() -- Line: 201
            -- upvalues: u25 (ref)
            if u25 then
                u25:Destroy();
            end;
        end);
        Cleanup();
    end);
    u12.Parent = workspace.Effects;
end;