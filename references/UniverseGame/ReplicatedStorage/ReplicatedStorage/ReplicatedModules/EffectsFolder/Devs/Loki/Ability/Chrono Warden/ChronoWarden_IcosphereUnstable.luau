  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local Petal = _G.Petal;
local u1 = Petal("New");
local u2 = Petal("Util");
local u3 = Petal("Extensions");
local RunService = game:GetService("RunService");
local _ = Vector3.new;
local Triangle = require(script.Triangle);

local function Shuffle(p4) -- Line: 14
    for i = #p4, 1, -1 do
        local v5 = math.random(i);
        local v6 = p4[i];
        p4[i] = p4[v5];
        p4[v5] = v6;
    end;
end;

local ParticleHandler = require(PathShortcuts.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p7) -- Line: 25
    -- upvalues: Trove (copy), u1 (copy), Shuffle (copy), Triangle (copy), ParticleHandler (copy), u2 (copy), u3 (copy), RunService (copy)
    local Player = p7.Player;
    local Reference = p7.Reference;
    local Origin = p7.Origin;
    local Scale = p7.Scale;
    local Duration = p7.Duration;
    local u8 = Trove.new();
    local u9 = {};

    ({}).new = function(p10, p11) -- Line: 39, Name: new
        -- upvalues: Origin (copy), Scale (copy)
        return Origin + p10 * Scale;
    end;

    ({}).new = function(p12, p13, p14) -- Line: 43, Name: new
        -- upvalues: u9 (copy)
        table.insert(u9, { p12, p13, p14 });
    end;

    local v15 = Origin + (Vector3.new(-1, 1.618034, 0)).unit * Scale;
    local v16 = Origin + (Vector3.new(1, 1.618034, 0)).unit * Scale;
    local v17 = Origin + (Vector3.new(-1, -1.618034, 0)).unit * Scale;
    local v18 = Origin + (Vector3.new(1, -1.618034, 0)).unit * Scale;
    local v19 = Origin + (Vector3.new(0, -1, 1.618034)).unit * Scale;
    local v20 = Origin + (Vector3.new(0, 1, 1.618034)).unit * Scale;
    local v21 = Origin + (Vector3.new(0, -1, -1.618034)).unit * Scale;
    local v22 = Origin + (Vector3.new(0, 1, -1.618034)).unit * Scale;
    local v23 = Origin + (Vector3.new(1.618034, 0, -1)).unit * Scale;
    local v24 = Origin + (Vector3.new(1.618034, 0, 1)).unit * Scale;
    local v25 = Origin + (Vector3.new(-1.618034, 0, -1)).unit * Scale;
    local v26 = Origin + (Vector3.new(-1.618034, 0, 1)).unit * Scale;
    table.insert(u9, { v15, v26, v20 });
    table.insert(u9, { v15, v20, v16 });
    table.insert(u9, { v15, v16, v22 });
    table.insert(u9, { v15, v22, v25 });
    table.insert(u9, { v15, v25, v26 });
    table.insert(u9, { v16, v20, v24 });
    table.insert(u9, { v20, v26, v19 });
    table.insert(u9, { v26, v25, v17 });
    table.insert(u9, { v25, v22, v21 });
    table.insert(u9, { v22, v16, v23 });
    table.insert(u9, { v18, v24, v19 });
    table.insert(u9, { v18, v19, v17 });
    table.insert(u9, { v18, v17, v21 });
    table.insert(u9, { v18, v21, v23 });
    table.insert(u9, { v18, v23, v24 });
    table.insert(u9, { v21, v17, v25 });
    table.insert(u9, { v23, v21, v22 });
    table.insert(u9, { v24, v23, v16 });
    table.insert(u9, { v19, v24, v20 });
    table.insert(u9, { v17, v19, v26 });
    local u27 = u1("Model")({
        Name = "ChronosIcospshere",
        Parent = workspace.Effects
    });
    Shuffle(u9);
    local v28 = Player and (Player.Data.Skin:GetAttribute("UnusualHueId") and Player.Data.Skin:GetAttribute("UnusualHueId") * 5) or (p7.HueShift or 0);
    local u29 = {};

    for i = 1, #u9 do
        local v30, v31, v32 = unpack(u9[i]);
        local v33 = v30:Lerp(v31, 0.5);
        local v34 = v31:Lerp(v32, 0.5);
        local v35 = v32:Lerp(v30, 0.5);
        local v36 = -Scale / 5;
        local v37 = v33 - (v33 - Origin).Unit * v36;
        local v38 = v34 - (v34 - Origin).Unit * v36;
        local v39 = v35 - (v35 - Origin).Unit * v36;
        local v40, v41 = Triangle(v31, v38, v37, u27);
        local v42, v43 = Triangle(v30, v39, v37, u27);
        local v44, v45 = Triangle(v32, v39, v38, u27);
        local v46, v47 = Triangle(v37, v39, v38, u27);
        local v48 = {
            { v40, v41 },
            { v42, v43 },
            { v44, v45 },
            { v46, v47 }
        };
        Shuffle(v48);

        for i2 = 1, #v48 do
            local u49, u50 = unpack(v48[i2]);
            local Size = u49.Size;
            local Size2 = u50.Size;
            local Unit = (u49.Position - Origin).Unit;
            local Unit2 = (u50.Position - Origin).Unit;
            local Position = u49.Position;
            local Position2 = u50.Position;
            u49.Position = u49.Position + Unit * Random.new():NextNumber(-3, 3);
            u50.Position = u50.Position + Unit2 * Random.new():NextNumber(-3, 3);
            u49.Transparency = 1;
            u50.Transparency = 1;
            u49.Material = "Neon";
            u50.Material = "Neon";
            u49.CastShadow = false;
            u50.CastShadow = false;
            u49.Size = u49.Size / 120;
            u50.Size = u50.Size / 120;
            u49.Color = ParticleHandler.HSVShift(u49.Color, {
                HueShift = v28
            });
            u50.Color = ParticleHandler.HSVShift(u50.Color, {
                HueShift = v28
            });
            u2.Tween(u49, Random.new():NextNumber(0.1, 0.4), "Quad", "InOut", {
                Transparency = 0.6 + Random.new():NextNumber(-0.1, 0.1),
                Size = Size,
                Position = Position
            });
            u2.Tween(u50, Random.new():NextNumber(0.1, 0.4), "Quad", "InOut", {
                Transparency = 0.6 + Random.new():NextNumber(-0.1, 0.1),
                Size = Size2,
                Position = Position2
            });
            u8:Add(function() -- Line: 152
                -- upvalues: u2 (ref), u49 (copy), Position (copy), Unit (copy), u3 (ref), u50 (copy), Position2 (copy), Unit2 (copy)
                local Tween = u2.Tween;
                local v51 = Random.new():NextNumber(0.35, 0.75);
                local v52 = {
                    Size = Vector3.new(0, 0, 0)
                };
                local v53 = CFrame.new(Position + Unit * Random.new():NextNumber(6, 25));
                local Angles = CFrame.Angles;
                local v54 = u3.Rng(-360, 360);
                local v55 = math.rad(v54);
                local v56 = u3.Rng(-360, 360);
                local v57 = math.rad(v56);
                local v58 = u3.Rng(-360, 360);
                v52.CFrame = v53 * Angles(v55, v57, (math.rad(v58)));
                Tween(u49, v51, "Back", "InOut", v52);
                local Tween2 = u2.Tween;
                local v59 = Random.new():NextNumber(0.35, 0.75);
                local v60 = {
                    Size = Vector3.new(0, 0, 0)
                };
                local v61 = CFrame.new(Position2 + Unit2 * Random.new():NextNumber(6, 25));
                local Angles2 = CFrame.Angles;
                local v62 = u3.Rng(-360, 360);
                local v63 = math.rad(v62);
                local v64 = u3.Rng(-360, 360);
                local v65 = math.rad(v64);
                local v66 = u3.Rng(-360, 360);
                v60.CFrame = v61 * Angles2(v63, v65, (math.rad(v66)));
                Tween2(u50, v59, "Back", "InOut", v60);
            end);
            table.insert(u29, {
                { u49, Unit, Position },
                { u50, Unit2, Position2 },
                i,
                i2
            });
        end;

        RunService.Heartbeat:Wait();
    end;

    u8:Connect(RunService.Heartbeat, function() -- Line: 169
        -- upvalues: u29 (copy), Scale (copy)
        for _, v in u29 do
            local v67 = v[1];
            local v68 = v[2];
            local v69 = v[3];
            local v70 = v[4];
            local v71 = v67[1];
            local v72 = v67[3];
            local v73 = v68[1];
            local v74 = v68[2];
            local v75 = v68[3];
            local Position = v71.Position;
            local v76 = v67[2] / (Scale / 1.65);
            local v77 = tick() * 3 + v69 * v70;
            v71.Position = Position:Lerp(v72 + v76 * math.sin(v77), 0.5);
            local Position2 = v73.Position;
            local v78 = tick() * 1.5 + v69 * v70;
            v73.Position = Position2:Lerp(v75 + v74 / (Scale / 1.65) * math.sin(v78), 0.5);
        end;
    end);
    u8:Connect(Reference.AncestryChanged, function() -- Line: 180
        -- upvalues: Reference (ref), u8 (copy)
        if not Reference.Parent then
            Reference = nil;
            u8:Destroy();
        end;
    end);

    if not Reference.Parent then
        Reference = nil;
        u8:Destroy();
    end;

    u8:Add(function() -- Line: 192
        -- upvalues: u27 (copy)
        task.delay(1, function() -- Line: 193
            -- upvalues: u27 (ref)
            u27:Destroy();
        end);
    end);
    task.delay(Duration, function() -- Line: 198
        -- upvalues: u8 (copy)
        u8:Destroy();
    end);
end;