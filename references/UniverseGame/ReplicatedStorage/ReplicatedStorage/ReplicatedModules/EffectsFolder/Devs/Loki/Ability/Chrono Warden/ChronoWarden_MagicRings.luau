  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.GenericModule);
local ClientAssets = PathShortcuts.ClientAssets;
local Trove = require(Knit.Util.Trove);
local Petal = _G.Petal;
Petal("New");
local u1 = Petal("Util");
local _ = u1.Tween;
local Heartbeat = game:GetService("RunService").Heartbeat;
local _ = Instance.new;
local new = Vector3.new;
local new2 = CFrame.new;
local Angles = CFrame.Angles;
local _ = Color3.fromRGB;

local function Lerp(p2, p3, p4) -- Line: 16
    return p2:Lerp(p3, p4);
end;

local function Quad(p5, p6, p7, p8) -- Line: 21
    -- upvalues: Lerp (copy)
    return Lerp(p5:Lerp(p6, p8), p6:Lerp(p7, p8), p8);
end;

local ChronoMagicRing = ClientAssets["Chrono Warden"].ChronoMagicRing;

return function(p9) -- Line: 30
    -- upvalues: Trove (copy), ChronoMagicRing (copy), u1 (copy), new (copy), new2 (copy), Heartbeat (copy), Angles (copy)
    local ChronocannonLevel = p9:FindFirstChild("ChronocannonLevel");

    if not ChronocannonLevel then
        return;
    end;

    local u10 = Trove.new();
    u10:AttachToInstance(ChronocannonLevel);
    local HumanoidRootPart = p9:FindFirstChild("HumanoidRootPart");

    local function MakeRing(u11) -- Line: 39
        -- upvalues: ChronoMagicRing (ref), u1 (ref), new (ref), u10 (copy)
        local u12 = ChronoMagicRing:Clone();
        u12.Size = Vector3.new(0, 0, 0);
        u12.Parent = workspace.Effects;
        u1.Tween(u12, 0.85 * (u11 / 4), "Quad", "InOut", {
            Size = new(u11, 0, u11)
        });
        u10:Add(function() -- Line: 46
            -- upvalues: u1 (ref), u12 (copy), u11 (copy)
            task.spawn(function() -- Line: 47
                -- upvalues: u1 (ref), u12 (ref), u11 (ref)
                u1.Tween(u12, 0.3 * (u11 / 4), "Back", "In", {
                    Size = Vector3.new(0, 0, 0)
                });
                task.wait(0.3);
                u12:Destroy();
            end);
        end);

        return u12;
    end;

    local u13 = {};
    local u14 = { function() -- Line: 59
            -- upvalues: MakeRing (copy), new2 (ref)
            return {
                MakeRing(3),
                {
                    Rotation = -5,
                    Offset = new2(0, 0, -3)
                }
            };
        end, function() -- Line: 70
            -- upvalues: MakeRing (copy), new2 (ref)
            return {
                MakeRing(3.5),
                {
                    Rotation = -2.5,
                    Offset = new2(0, 0, -3.35)
                }
            };
        end, function() -- Line: 81
            -- upvalues: MakeRing (copy), new2 (ref)
            return {
                MakeRing(4.5),
                {
                    Rotation = 1.5,
                    Offset = new2(0, 0, -2.75)
                }
            };
        end };

    local function Run(p15) -- Line: 94
        -- upvalues: u14 (copy), u13 (copy)
        local v16 = u14[p15];

        if not v16 then
            return;
        end;

        table.insert(u13, v16());
    end;

    local v17 = u14[ChronocannonLevel.Value];

    if v17 then
        table.insert(u13, v17());
    end;

    ChronocannonLevel:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 103
        -- upvalues: ChronocannonLevel (copy), u14 (copy), u13 (copy)
        local v18 = u14[ChronocannonLevel.Value];

        if not v18 then
            return;
        end;

        table.insert(u13, v18());
    end);
    local u19 = 0;
    u10:Connect(Heartbeat, function(p20) -- Line: 108
        -- upvalues: u19 (ref), u13 (copy), HumanoidRootPart (copy), Angles (ref)
        u19 = u19 + p20 * 30;

        for i = 1, #u13 do
            local v21 = u13[i][1];
            local v22 = u13[i][2];
            v21.CFrame = v21.CFrame:Lerp(HumanoidRootPart.CFrame * v22.Offset * Angles(-1.5707963267948966, math.rad(v22.Rotation * u19), 0), 0.8);
        end;
    end);
end;