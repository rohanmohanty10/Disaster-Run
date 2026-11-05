  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Lighting = game:GetService("Lighting");
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local Petal = _G.Petal;
local u1 = Petal("New");
local Tween = Petal("Util").Tween;
local _ = Instance.new;
local new = Vector3.new;
local _ = CFrame.new;
local _ = CFrame.Angles;
local _ = Color3.fromRGB;
local u2 = Random.new();

local function Rng(p3, p4) -- Line: 14
    -- upvalues: u2 (copy)
    return u2:NextNumber(p3, p4);
end;

local function Lerp(p5, p6, p7) -- Line: 18
    return p5 + (p6 - p5) * p7;
end;

local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local UserGameSettings = UserSettings():GetService("UserGameSettings");

return function(p8) -- Line: 25
    -- upvalues: Lighting (copy), Tween (copy), Trove (copy), u1 (copy), EffectsHandler (copy), UserGameSettings (copy), new (copy)
    local Origin = p8.Origin;
    local Size = p8.Size;
    local Duration = p8.Duration;
    local Cancel = p8.Cancel;

    if Lighting:FindFirstChild("TSEffect") then
        if not Cancel then
            local TSEffect = Lighting:FindFirstChild("TSEffect");
            Tween(TSEffect, 0.5, "Quad", "InOut", {
                Saturation = 0
            });
            task.wait(1);
            TSEffect:Destroy();

            return;
        end;

        Lighting:FindFirstChild("TSEffect"):Destroy();
    end;

    local u9 = Trove.new();
    local u10 = u1("ColorCorrectionEffect")({
        Name = "TSEffect",
        Parent = Lighting
    });
    u9:Add(u10);
    task.spawn(function() -- Line: 51
        -- upvalues: Tween (ref), u10 (copy), Cancel (copy), u9 (copy), EffectsHandler (ref), Origin (copy), Size (copy), UserGameSettings (ref)
        Tween(workspace.CurrentCamera, 0.5, "Quad", "Out", {
            FieldOfView = 100
        });
        task.spawn(function() -- Line: 53
            -- upvalues: Tween (ref), u10 (ref)
            for _ = 1, 10 do
                Tween(u10, 0.25, "Sine", "InOut", {
                    Contrast = math.random(-5, 5),
                    Saturation = math.random(-5, 5),
                    TintColor = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
                });
                task.wait(0.1);
            end;

            Tween(workspace.CurrentCamera, 0.5, "Quad", "Out", {
                FieldOfView = game.Players.LocalPlayer.Settings.FieldOfView.Value
            });
            Tween(u10, 0.25, "Sine", "InOut", {
                Contrast = 0,
                Saturation = -1.5,
                TintColor = Color3.fromRGB(255, 255, 255)
            });
        end);

        if not Cancel then
            return;
        end;

        local u11 = true;
        u9:Add(function() -- Line: 65
            -- upvalues: u11 (ref)
            u11 = false;
        end);
        EffectsHandler.CallEffect("Emit Particle V3", {
            AutoSerialize = true,
            Origin = Origin,
            Particle = script.TimeStopAirVFX,
            Scale = 0.7 + Size / 80
        });
        local Effects = workspace.Effects;
        local Position = Origin.Position;

        if UserGameSettings.SavedQualityLevel.Value <= 5 then
            return;
        end;

        local v12 = {};

        while true do
            if not u11 then
                for i, v in v12 do
                    if i and i.Parent then
                        i.TimeScale = v;
                    end;
                end;

                table.clear(v12);

                return;
            end;

            local v13 = task.wait() * 2;

            for _, v in Effects:QueryDescendants("ParticleEmitter") do
                local v14 = 1.5;
                local Parent = v.Parent;

                if Parent ~= nil then
                    local v15 = Parent:IsA("Attachment") and "WorldPosition" or (Parent:IsA("BasePart") and "Position" or nil);
                    local v16, v17;

                    if v15 == nil then
                        if v12[v] == nil then
                            v12[v] = v.TimeScale;
                        end;

                        v16 = v.TimeScale;
                        v17 = math.clamp(v13 / v14, v13, 0.9);
                        v.TimeScale = v16 + (0.05 - v16) * v17;
                    else
                        local v18 = Parent[v15];

                        if Size >= (v18 - Position).Magnitude then
                            v14 = 1 + (v18 - Position).Magnitude * 0.125;

                            if v12[v] == nil then
                                v12[v] = v.TimeScale;
                            end;

                            v16 = v.TimeScale;
                            v17 = math.clamp(v13 / v14, v13, 0.9);
                            v.TimeScale = v16 + (0.05 - v16) * v17;
                        end;
                    end;
                end;
            end;
        end;
    end);

    for i = 1, 2 do
        local u19 = u1("Part")({
            Shape = "Ball",
            CastShadow = false,
            Anchored = true,
            CanCollide = false,
            Size = Vector3.new(2, 2, 2),
            Name = "TS_Part",
            Parent = workspace.Effects,
            Material = Enum.Material.ForceField,
            CFrame = Origin
        });
        local u20 = Size * (i / 1.35);
        task.spawn(function() -- Line: 138
            -- upvalues: Tween (ref), u19 (copy), u20 (copy), new (ref)
            Tween(u19, 1, "Back", "Out", {
                Size = new(u20, u20, u20)
            });
            task.wait(1);
            Tween(u19, 0.5, "Quad", "InOut", {
                Size = Vector3.new(0, 0, 0)
            });
            task.delay(0.5, function() -- Line: 143
                -- upvalues: u19 (ref)
                u19:Destroy();
            end);
        end);
    end;

    task.delay(Duration + 1, function() -- Line: 149
        -- upvalues: u9 (copy)
        u9:Destroy();
    end);
end;