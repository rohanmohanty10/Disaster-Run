  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local Petal = _G.Petal;
local u1 = Petal("New");
local u2 = Petal("Util");
Petal("Extensions");
local RunService = game:GetService("RunService");
local new = Vector3.new;
local Triangle = require(script.Triangle);

local function Shuffle(p3) -- Line: 14
    for i = #p3, 1, -1 do
        local v4 = math.random(i);
        local v5 = p3[i];
        p3[i] = p3[v4];
        p3[v4] = v5;
    end;
end;

local ParticleHandler = require(PathShortcuts.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

local function Lerp(p6, p7, p8) -- Line: 25
    return p6 + (p7 - p6) * p8;
end;

return function(p9) -- Line: 29
    -- upvalues: Trove (copy), u1 (copy), Shuffle (copy), Triangle (copy), ParticleHandler (copy), u2 (copy), RunService (copy), new (copy)
    local Player = p9.Player;
    local Reference = p9.Reference;
    local OriginPart = p9.OriginPart;
    local Position = OriginPart.Position;
    local Scale = p9.Scale;
    local u10 = Trove.new();
    local u11 = {};

    ({}).new = function(p12, p13) -- Line: 43, Name: new
        -- upvalues: Position (ref), Scale (copy)
        return Position + p12 * Scale;
    end;

    ({}).new = function(p14, p15, p16) -- Line: 47, Name: new
        -- upvalues: u11 (copy)
        table.insert(u11, { p14, p15, p16 });
    end;

    local v17 = Position + (Vector3.new(-1, 1.618034, 0)).unit * Scale;
    local v18 = Position + (Vector3.new(1, 1.618034, 0)).unit * Scale;
    local v19 = Position + (Vector3.new(-1, -1.618034, 0)).unit * Scale;
    local v20 = Position + (Vector3.new(1, -1.618034, 0)).unit * Scale;
    local v21 = Position + (Vector3.new(0, -1, 1.618034)).unit * Scale;
    local v22 = Position + (Vector3.new(0, 1, 1.618034)).unit * Scale;
    local v23 = Position + (Vector3.new(0, -1, -1.618034)).unit * Scale;
    local v24 = Position + (Vector3.new(0, 1, -1.618034)).unit * Scale;
    local v25 = Position + (Vector3.new(1.618034, 0, -1)).unit * Scale;
    local v26 = Position + (Vector3.new(1.618034, 0, 1)).unit * Scale;
    local v27 = Position + (Vector3.new(-1.618034, 0, -1)).unit * Scale;
    local v28 = Position + (Vector3.new(-1.618034, 0, 1)).unit * Scale;
    table.insert(u11, { v17, v28, v22 });
    table.insert(u11, { v17, v22, v18 });
    table.insert(u11, { v17, v18, v24 });
    table.insert(u11, { v17, v24, v27 });
    table.insert(u11, { v17, v27, v28 });
    table.insert(u11, { v18, v22, v26 });
    table.insert(u11, { v22, v28, v21 });
    table.insert(u11, { v28, v27, v19 });
    table.insert(u11, { v27, v24, v23 });
    table.insert(u11, { v24, v18, v25 });
    table.insert(u11, { v20, v26, v21 });
    table.insert(u11, { v20, v21, v19 });
    table.insert(u11, { v20, v19, v23 });
    table.insert(u11, { v20, v23, v25 });
    table.insert(u11, { v20, v25, v26 });
    table.insert(u11, { v23, v19, v27 });
    table.insert(u11, { v25, v23, v24 });
    table.insert(u11, { v26, v25, v18 });
    table.insert(u11, { v21, v26, v22 });
    table.insert(u11, { v19, v21, v28 });
    local u29 = u1("Model")({
        Name = "ChronosIcospshere",
        Parent = workspace.Effects
    });
    Shuffle(u11);
    local v30 = Player and (Player.Data.Skin:GetAttribute("UnusualHueId") and Player.Data.Skin:GetAttribute("UnusualHueId") * 5) or (p9.HueShift or 0);
    local u31 = {};

    for i = 1, #u11 do
        local v32, v33, v34 = unpack(u11[i]);
        local v35 = v32:Lerp(v33, 0.5);
        local v36 = v33:Lerp(v34, 0.5);
        local v37 = v34:Lerp(v32, 0.5);
        local v38 = -Scale / 5.5;
        local v39 = v35 - (v35 - Position).Unit * v38;
        local v40 = v36 - (v36 - Position).Unit * v38;
        local v41 = v37 - (v37 - Position).Unit * v38;
        local v42, v43 = Triangle(v33, v40, v39, u29);
        local v44, v45 = Triangle(v32, v41, v39, u29);
        local v46, v47 = Triangle(v34, v41, v40, u29);
        local v48, v49 = Triangle(v39, v41, v40, u29);
        local v50 = {
            { v42, v43 },
            { v44, v45 },
            { v46, v47 },
            { v48, v49 }
        };
        Shuffle(v50);

        for i2 = 1, #v50 do
            local v51, v52 = unpack(v50[i2]);
            local Size = v51.Size;
            local Size2 = v52.Size;
            local Unit = (v51.Position - Position).Unit;
            local Unit2 = (v52.Position - Position).Unit;
            local Position2 = v51.Position;
            local Position3 = v52.Position;
            v51.Position = v51.Position + Unit * Random.new():NextNumber(-3, 3);
            v52.Position = v52.Position + Unit2 * Random.new():NextNumber(-3, 3);
            local v53 = CFrame.new(Position2):ToObjectSpace(CFrame.new(Position)):Inverse();
            local v54 = CFrame.new(Position3):ToObjectSpace(CFrame.new(Position)):Inverse();
            v51.Transparency = 1;
            v52.Transparency = 1;
            v51.Material = "Neon";
            v52.Material = "Neon";
            v51.CastShadow = false;
            v52.CastShadow = false;
            v51.Size = v51.Size / 120;
            v52.Size = v52.Size / 120;
            v51.Color = ParticleHandler.HSVShift(v51.Color, {
                HueShift = v30
            });
            v52.Color = ParticleHandler.HSVShift(v52.Color, {
                HueShift = v30
            });
            u2.Tween(v51, Random.new():NextNumber(0.1, 0.3), "Quad", "InOut", {
                Size = Size - Vector3.new(0.15, 0.15, 0.15),
                Position = Position2
            });
            u2.Tween(v52, Random.new():NextNumber(0.1, 0.3), "Quad", "InOut", {
                Size = Size2 - Vector3.new(0.15, 0.15, 0.15),
                Position = Position3
            });
            table.insert(u31, {
                { v51, Unit, v53 },
                { v52, Unit2, v54 },
                i,
                i2
            });
        end;
    end;

    local u55 = 0;
    u10:Connect(RunService.Heartbeat, function(p56) -- Line: 165
        -- upvalues: OriginPart (copy), Reference (ref), u10 (copy), u55 (ref), Position (ref), Scale (copy), new (ref), u31 (copy)
        if not (OriginPart.Parent and OriginPart.Parent.Parent) then
            Reference = nil;
            task.delay(1, function() -- Line: 168
                -- upvalues: u10 (ref)
                u10:Destroy();
            end);
        end;

        u55 = (u55 + p56 * 3.141592653589793) % 12.566370614359172;

        if Reference then
            Position = OriginPart.Position;
        end;

        local v57 = Position + new(math.cos(u55) * Scale, math.sin(u55 / 1.333) * Scale, math.sin(u55) * Scale);

        for _, v in u31 do
            local v58 = v[1];
            local v59 = v[2];
            local v60 = v[3];
            local v61 = v[4];
            local v62 = v58[1];
            local v63 = v59[1];
            local v64 = v59[2];
            local Position2 = v59[3].Position;
            local Magnitude = (v62.Position - v57).Magnitude;
            local Magnitude2 = (v63.Position - v57).Magnitude;
            local Position3 = v62.Position;
            local v65 = Position + v58[3].Position;
            local v66 = v58[2] * (2 - Magnitude / 10) / (Scale / 1.8);
            local v67 = tick() * 3 + v60 * v61;
            v62.Position = Position3:Lerp(v65 + v66 * math.sin(v67), 0.5);
            local Position4 = v63.Position;
            local v68 = tick() * 1.5 + v60 * v61;
            v63.Position = Position4:Lerp(Position + Position2 + v64 * (2 - Magnitude2 / 10) / (Scale / 1.8) * math.sin(v68), 0.5);

            if Reference then
                local Transparency = v62.Transparency;
                v62.Transparency = math.clamp(Transparency + (Magnitude / Scale * 0.9 - Transparency) * 0.2, 0, 1);
                local Transparency2 = v63.Transparency;
                v63.Transparency = math.clamp(Transparency2 + (Magnitude2 / Scale * 0.9 - Transparency2) * 0.2, 0, 1);
            else
                local Transparency = v62.Transparency;
                v62.Transparency = Transparency + (1 - Transparency) * 0.1;
                local Transparency2 = v63.Transparency;
                v63.Transparency = Transparency2 + (1 - Transparency2) * 0.1;
            end;
        end;
    end);
    u10:Connect(Reference.AncestryChanged, function() -- Line: 202
        -- upvalues: Reference (ref), u10 (copy)
        if not Reference.Parent then
            Reference = nil;
            task.delay(1, function() -- Line: 206
                -- upvalues: u10 (ref)
                u10:Destroy();
            end);
        end;
    end);
    u10:Add(function() -- Line: 212
        -- upvalues: u29 (copy)
        task.delay(1, function() -- Line: 213
            -- upvalues: u29 (ref)
            u29:Destroy();
        end);
    end);
end;