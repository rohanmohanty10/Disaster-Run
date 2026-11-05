  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local Petal = _G.Petal;
Petal("New");
Petal("Util");
local v1 = Petal("Extensions");
local RunService = game:GetService("RunService");
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local new = CFrame.new;
local _ = Vector3.new;
local Rng = v1.Rng;

local function Lerp(p2, p3, p4) -- Line: 16
    return p2 + (p3 - p2) * p4;
end;

return function(p5) -- Line: 20
    -- upvalues: Trove (copy), EffectsHandler (copy), RunService (copy), new (copy), Rng (copy)
    local Reference = p5.Reference;
    local Character = p5.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local u6 = game:GetService("Players"):GetPlayerFromCharacter(Character);
    local u7 = Trove.new();
    local u8 = u6 and u6.Data.Skin:GetAttribute("UnusualHueId") and u6.Data.Skin:GetAttribute("UnusualHueId") * 5 or (p5.HueShift or 0);
    local u9 = EffectsHandler.GetEffect("ChronoWarden_Clock");
    local u10 = EffectsHandler.GetEffect("ChronoWarden_Crack");
    local u11 = os.clock();
    local u12 = nil;
    local Halo = Character:FindFirstChild("Halo");
    local u13;

    if Halo then
        u13 = Halo.Inner.Color;
    else
        u13 = nil;
    end;

    u7:Connect(RunService.Heartbeat, function(p14) -- Line: 42
        -- upvalues: Character (copy), Reference (ref), u7 (copy), u11 (ref), HumanoidRootPart (copy), new (ref), Rng (ref), u12 (ref), u10 (copy), u6 (copy), u13 (ref), u9 (copy), u8 (copy)
        if not Character.Parent then
            Reference = nil;
            task.delay(1, function() -- Line: 45
                -- upvalues: u7 (ref)
                u7:Destroy();
            end);
        end;

        if os.clock() - u11 > 0.7 then
            local v15 = HumanoidRootPart.CFrame * new(0, 0, 5.5) * CFrame.new(Rng(-8, 8), Rng(1.5, 4.5), Rng(-3, 0));
            local v16 = HumanoidRootPart.CFrame * new(0, 0, -5);

            if u12 and (u12.Position - v15.Position).Magnitude < 6 then
                repeat
                    v15 = HumanoidRootPart.CFrame * new(0, 0, 7) * CFrame.new(Rng(-8.5, 8.5), Rng(3, 7), Rng(-3, 0));
                until (u12.Position - v15.Position).Magnitude > 6;
            end;

            local v17 = new(v15.Position, v16.Position);
            local Angles = CFrame.Angles;
            local v18 = Rng(-10, 10);
            local v19 = v17 * Angles(1.5707963267948966, 1.5707963267948966 + math.rad(v18), 0);
            task.spawn(u10, {
                Iterations = 4,
                LastMultiplier = 12,
                Player = u6,
                Origin = v19,
                BranchDuration = { 0.01, 0.025 },
                BranchThickness = { 0.1, 0.2 },
                BranchAmount = Rng(2, 4),
                BranchLength = { 0.9, 1.9 },
                Color = u13
            });
            task.spawn(u9, {
                ExtraTime = 6,
                Origin = v19,
                Duration = Rng(0.75, 1),
                Speed = Rng(2, 4.5),
                StartCoeff = Rng(1, 1.15),
                EndCoeff = Rng(1, 1.15),
                Scale = Rng(0.45, 0.85),
                Sway = Rng(0.4, 1),
                Character = Character,
                HueShift = u8
            });
            u12 = v19;
            u11 = os.clock();
        end;
    end);
    u7:Connect(Reference.AncestryChanged, function() -- Line: 91
        -- upvalues: Reference (ref), u7 (copy)
        if not Reference.Parent then
            Reference = nil;
            task.delay(1, function() -- Line: 95
                -- upvalues: u7 (ref)
                u7:Destroy();
            end);
        end;
    end);
end;