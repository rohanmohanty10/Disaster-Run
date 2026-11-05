  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.GenericModule);
local _ = PathShortcuts.ClientAssets;
local Trove = require(Knit.Util.Trove);
local Petal = _G.Petal;
local u1 = Petal("New");
local u2 = Petal("Util");
local _ = u2.Tween;
local _ = game:GetService("RunService").Heartbeat;
local _ = Instance.new;
local _ = Vector3.new;
local _ = CFrame.new;
local _ = CFrame.Angles;
local _ = Color3.fromRGB;
local u3 = Random.new();

local function Rng(p4, p5) -- Line: 17
    -- upvalues: u3 (copy)
    return u3:NextNumber(p4, p5);
end;

local function Lerp(p6, p7, p8) -- Line: 21
    return p6 + (p7 - p6) * p8;
end;

require(PathShortcuts.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p9) -- Line: 27
    -- upvalues: Trove (copy), u1 (copy), u3 (copy), u2 (copy)
    local Origin = p9.Origin;
    local Iterations = p9.Iterations;
    local BranchAmount = p9.BranchAmount;
    local u10 = p9.BranchLength or { 3, 7 };
    local u11 = p9.BranchThickness or { 0.7, 1.5 };
    local u12 = p9.BranchDuration or { 0.1, 0.5 };
    local Color = p9.Color;
    local LastMultiplier = p9.LastMultiplier;
    local u13 = p9.AnimateSpawn == nil and true or p9.AnimateSpawn;
    local Player = p9.Player;

    if not (Player and (Player.Data.Skin:GetAttribute("UnusualHueId") and Player.Data.Skin:GetAttribute("UnusualHueId") * 5)) then
        local _ = p9.HueShift;
    end;

    local v14 = Trove.new();
    local u15 = u1("Model")({
        Name = "Crack"
    });
    v14:Add(u15);
    u15.Parent = workspace.Effects;

    for i = 1, BranchAmount do
        task.spawn(function() -- Line: 50
            -- upvalues: u12 (copy), u3 (ref), Origin (copy), BranchAmount (copy), i (copy), Iterations (copy), u10 (copy), u11 (copy), u1 (ref), u15 (copy), Color (copy), u2 (ref), LastMultiplier (copy), u13 (copy)
            local u16 = u3:NextNumber(u12[1], u12[2]);
            local v17 = 1;
            local v18 = Origin;
            local v19 = 360 / BranchAmount;
            local v20 = u3:NextNumber(-v19 / 4, v19 / 4);
            local v21 = v19 / v17 * i + v20;

            while v17 <= Iterations do
                local u22 = v18 * CFrame.Angles(0, math.rad(v21), 0) * CFrame.new(0, 0, -u3:NextNumber(u10[1], u10[2]));
                local Magnitude = (u22.Position - v18.Position).Magnitude;
                local v23 = u3:NextNumber(u11[1], u11[2]);
                local u24 = u1("Part")({
                    Anchored = true,
                    Material = "Neon",
                    CanCollide = false,
                    Size = Vector3.new(v23 * (1 + -0.85 * (v17 / Iterations)), v23 * (0.1 + 0.024999999999999994 * (v17 / Iterations)), 0),
                    CFrame = CFrame.new(v18.Position, u22.Position),
                    Parent = u15,
                    Color = Color
                });
                u2.Tween(u24, u16, "Linear", "InOut", {
                    Size = Vector3.new(u24.Size.X, u24.Size.Y, Magnitude),
                    CFrame = CFrame.new(v18.Position, u22.Position) * CFrame.new(0, 0, -Magnitude / 2)
                });
                task.delay(u16 * LastMultiplier, function() -- Line: 89
                    -- upvalues: u2 (ref), u24 (copy), u16 (copy)
                    u2.Tween(u24, u16 * 5, "Quad", "InOut", {
                        Transparency = 1,
                        Size = Vector3.new(u24.Size.X / 10, u24.Size.Y / 10, u24.Size.Z)
                    });
                end);

                if math.random(1, 3) == 1 then
                    task.spawn(function() -- Line: 97
                        -- upvalues: u22 (copy), u16 (copy), u3 (ref), u10 (ref), u1 (ref), u24 (copy), Color (ref), u2 (ref), LastMultiplier (ref)
                        local v25 = u22;

                        for i2 = 1, math.random(3, 5) do
                            task.wait(u16 / 2 + 0.025);
                            local Angles = CFrame.Angles;
                            local v26 = u3:NextNumber(-60, 60);
                            local v27 = v25 * Angles(0, math.rad(v26), 0) * CFrame.new(0, 0, -u3:NextNumber(u10[1] / 2, u10[2] / 2));
                            local Magnitude2 = (v27.Position - v25.Position).Magnitude;
                            local u28 = u1("Part")({
                                Anchored = true,
                                Material = "Neon",
                                CanCollide = false,
                                Size = Vector3.new(u24.Size.X / 1.2 * (1 / i2), u24.Size.X / 1.2 * (1 / i2), 0),
                                CFrame = CFrame.new(v25.Position, v27.Position),
                                Parent = u24,
                                Color = Color
                            });
                            u2.Tween(u28, u16 / 2, "Linear", "InOut", {
                                Size = Vector3.new(u28.Size.X, u28.Size.Y, Magnitude2),
                                CFrame = CFrame.new(v25.Position, v27.Position) * CFrame.new(0, 0, -Magnitude2 / 2)
                            });
                            task.delay(u16 * LastMultiplier, function() -- Line: 124
                                -- upvalues: u2 (ref), u28 (copy), u16 (ref)
                                u2.Tween(u28, u16 * 5, "Quad", "InOut", {
                                    Transparency = 1,
                                    Size = Vector3.new(u28.Size.X / 5, u28.Size.Y / 5, u28.Size.Z)
                                });
                            end);
                            v25 = v27;
                        end;
                    end);
                end;

                v21 = u3:NextNumber(-35, 35) + v20 / v17;
                u3:NextNumber(-30, 30);
                v17 = v17 + 1;

                if u13 then
                    task.wait(u16 + 0.025);
                    v18 = u22;
                else
                    v18 = u22;
                end;
            end;
        end);
    end;

    task.delay(5 * (LastMultiplier / 10), v14.Destroy, v14);
end;