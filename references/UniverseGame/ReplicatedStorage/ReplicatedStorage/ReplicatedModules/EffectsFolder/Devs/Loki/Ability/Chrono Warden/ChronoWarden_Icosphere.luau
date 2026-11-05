  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local _ = PathShortcuts.ClientAssets;
local Petal = _G.Petal;
local u1 = Petal("New");
local u2 = Petal("Util");
Petal("Extensions");
local _ = Vector3.new;
local Triangle = require(script.Triangle);

local function Shuffle(p3) -- Line: 12
    for i = #p3, 1, -1 do
        local v4 = math.random(i);
        local v5 = p3[i];
        p3[i] = p3[v4];
        p3[v4] = v5;
    end;
end;

local ParticleHandler = require(PathShortcuts.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);

return function(p6) -- Line: 24
    -- upvalues: u1 (copy), AssetHandler (copy), ParticleHandler (copy), Shuffle (copy), Triangle (copy), u2 (copy)
    local Player = p6.Player;
    local Origin = p6.Origin;
    local Scale = p6.Scale;
    local Duration = p6.Duration;
    local v7 = u1("Maid");

    ({}).new = function(p8, p9) -- Line: 30, Name: new
        -- upvalues: Origin (copy), Scale (ref)
        return Origin + p8 * Scale;
    end;

    local u10 = {};

    ({}).new = function(p11, p12, p13) -- Line: 35, Name: new
        -- upvalues: u10 (copy)
        table.insert(u10, { p11, p12, p13 });
    end;

    local v14 = Origin + (Vector3.new(-1, 1.618034, 0)).unit * Scale;
    local v15 = Origin + (Vector3.new(1, 1.618034, 0)).unit * Scale;
    local v16 = Origin + (Vector3.new(-1, -1.618034, 0)).unit * Scale;
    local v17 = Origin + (Vector3.new(1, -1.618034, 0)).unit * Scale;
    local v18 = Origin + (Vector3.new(0, -1, 1.618034)).unit * Scale;
    local v19 = Origin + (Vector3.new(0, 1, 1.618034)).unit * Scale;
    local v20 = Origin + (Vector3.new(0, -1, -1.618034)).unit * Scale;
    local v21 = Origin + (Vector3.new(0, 1, -1.618034)).unit * Scale;
    local v22 = Origin + (Vector3.new(1.618034, 0, -1)).unit * Scale;
    local v23 = Origin + (Vector3.new(1.618034, 0, 1)).unit * Scale;
    local v24 = Origin + (Vector3.new(-1.618034, 0, -1)).unit * Scale;
    local v25 = Origin + (Vector3.new(-1.618034, 0, 1)).unit * Scale;
    table.insert(u10, { v14, v25, v19 });
    table.insert(u10, { v14, v19, v15 });
    table.insert(u10, { v14, v15, v21 });
    table.insert(u10, { v14, v21, v24 });
    table.insert(u10, { v14, v24, v25 });
    table.insert(u10, { v15, v19, v23 });
    table.insert(u10, { v19, v25, v18 });
    table.insert(u10, { v25, v24, v16 });
    table.insert(u10, { v24, v21, v20 });
    table.insert(u10, { v21, v15, v22 });
    table.insert(u10, { v17, v23, v18 });
    table.insert(u10, { v17, v18, v16 });
    table.insert(u10, { v17, v16, v20 });
    table.insert(u10, { v17, v20, v22 });
    table.insert(u10, { v17, v22, v23 });
    table.insert(u10, { v20, v16, v24 });
    table.insert(u10, { v22, v20, v21 });
    table.insert(u10, { v23, v22, v15 });
    table.insert(u10, { v18, v23, v19 });
    table.insert(u10, { v16, v18, v25 });
    local u26 = u1("Model")({
        Name = "ChronosIcospshere",
        Parent = workspace.Effects
    });
    local v27 = Player and Player.Data.Skin:GetAttribute("UnusualHueId") and Player.Data.Skin:GetAttribute("UnusualHueId") * 5 or (p6.HueShift or 0);
    local v28 = AssetHandler.GetAbilityData(Player);
    local u29 = AssetHandler.CloneAsset("Particles/IcosphereAura", v28);
    u29.Position = Origin;
    u29.Parent = u26;
    ParticleHandler.HSVShiftParticles(u29, {
        HueShift = v27
    });

    if p6.Color then
        local v30, v31, v32 = p6.Color:ToHSV();
        ParticleHandler.HSVShiftParticles(u29, {
            Hue = v30,
            Saturation = v31,
            Value = v32
        });
    end;

    local v33 = v7 + function() -- Line: 98
        -- upvalues: u29 (copy)
        for _, descendant in u29:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end;
    Shuffle(u10);

    for i = 1, #u10 do
        local v34, v35, v36 = unpack(u10[i]);
        local v37 = v34:Lerp(v35, 0.5);
        local v38 = v35:Lerp(v36, 0.5);
        local v39 = v36:Lerp(v34, 0.5);
        local v40 = -Scale / 5;
        local v41 = v37 - (v37 - Origin).Unit * v40;
        local v42 = v38 - (v38 - Origin).Unit * v40;
        local v43 = v39 - (v39 - Origin).Unit * v40;
        local v44, v45 = Triangle(v35, v42, v41, u26);
        local v46, v47 = Triangle(v34, v43, v41, u26);
        local v48, v49 = Triangle(v36, v43, v42, u26);
        local v50, v51 = Triangle(v41, v43, v42, u26);
        local v52 = {
            { v44, v45 },
            { v46, v47 },
            { v48, v49 },
            { v50, v51 }
        };
        Shuffle(v52);

        for i2 = 1, #v52 do
            local u53, u54 = unpack(v52[i2]);
            local Size = u53.Size;
            local Size2 = u54.Size;
            local Unit = (u53.Position - Origin).Unit;
            local Unit2 = (u54.Position - Origin).Unit;
            local Position = u53.Position;
            local Position2 = u54.Position;
            u53.Position = u53.Position + Unit * Random.new():NextNumber(-3, 3);
            u54.Position = u54.Position + Unit2 * Random.new():NextNumber(-3, 3);
            u53.Transparency = 0;
            u54.Transparency = 0;
            u53.Material = "Neon";
            u54.Material = "Neon";
            u53.CastShadow = false;
            u54.CastShadow = false;
            u53.Size = u53.Size / 100;
            u54.Size = u54.Size / 100;

            if p6.Color then
                u53.Color = p6.Color;
                u54.Color = p6.Color;
            end;

            u53.Color = ParticleHandler.HSVShift(u53.Color, {
                HueShift = v27
            });
            u54.Color = ParticleHandler.HSVShift(u54.Color, {
                HueShift = v27
            });
            u2.Tween(u53, Random.new():NextNumber(0.1, 0.4), "Quad", "InOut", {
                Transparency = 0.6 + Random.new():NextNumber(-0.1, 0.1),
                Size = Size,
                Position = Position - Unit * 0.2
            });
            u2.Tween(u54, Random.new():NextNumber(0.1, 0.4), "Quad", "InOut", {
                Transparency = 0.6 + Random.new():NextNumber(-0.1, 0.1),
                Size = Size2,
                Position = Position2 - Unit2 * 0.2
            });
            v33 = v33 + function() -- Line: 174
                -- upvalues: u2 (ref), u53 (copy), u54 (copy)
                u2.Tween(u53, Random.new():NextNumber(0.35, 0.75), "Back", "InOut", {
                    Size = Vector3.new(0, 0, 0)
                });
                u2.Tween(u54, Random.new():NextNumber(0.35, 0.75), "Back", "InOut", {
                    Size = Vector3.new(0, 0, 0)
                });
            end;
        end;
    end;

    local u55 = v33 + function() -- Line: 191
        -- upvalues: u26 (copy)
        task.delay(1, function() -- Line: 192
            -- upvalues: u26 (ref)
            u26:Destroy();
        end);
    end;
    task.delay(Duration, function() -- Line: 197
        -- upvalues: u55 (ref)
        u55:Clean();
    end);
end;