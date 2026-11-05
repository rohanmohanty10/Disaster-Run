  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local Petal = _G.Petal;
local u1 = Petal("New");
local u2 = Petal("Util");
local v3 = Petal("Extensions");
local RunService = game:GetService("RunService");
require(PathShortcuts.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local new = CFrame.new;
local new2 = Vector3.new;
local _ = v3.Rng;
local Vector4 = require(script.Vector4);

local function Lerp(p4, p5, p6) -- Line: 18
    return p4 + (p5 - p4) * p6;
end;

local function outBack(p7) -- Line: 22
    local v8 = p7 - 1;

    return 1 - v8 * v8 * v8 * v8;
end;

local function animateOutBack(p9, p10, p11) -- Line: 27
    local v12 = p11 - 1;

    return p9 + (p10 - p9) * (1 - v12 * v12 * v12 * v12);
end;

return function(p13) -- Line: 31
    -- upvalues: Trove (copy), u1 (copy), Vector4 (copy), ParticleHandler (copy), u2 (copy), RunService (copy), new2 (copy), new (copy)
    local Reference = p13.Reference;
    local Character = p13.Character;
    local _ = Character.HumanoidRootPart;
    local u14 = Trove.new();

    local function Norm(p15) -- Line: 43
        return p15 == 1 and 1 or (p15 == 2 and -1 or 1);
    end;

    local u16 = u1("Part")({
        Name = "Base",
        Anchored = true,
        CanCollide = false,
        Transparency = 1,
        Size = Vector3.new(1, 1, 1)
    });
    local u17 = script["VO??ID"]:Clone();
    u17.Parent = u16;
    u17.Enabled = false;
    local u18 = {};
    local u19 = {};
    local u20 = false;
    local u21 = false;
    local u22 = 1.25;

    for i = 1, 2 do
        for i2 = 1, 2 do
            for i3 = 1, 2 do
                for i4 = 1, 2 do
                    local v23 = Vector4.new(i == 1 and 1 or (i == 2 and -1 or 1), i2 == 1 and 1 or (i2 == 2 and -1 or 1), i3 == 1 and 1 or (i3 == 2 and -1 or 1), i4 == 1 and 1 or (i4 == 2 and -1 or 1));
                    u18[v23] = u1("Attachment")({
                        Name = `{v23.X} | {v23.Y} | {v23.Z} | {v23.W}`,
                        Parent = u16
                    });
                end;
            end;
        end;
    end;

    local v24 = game:GetService("Players"):GetPlayerFromCharacter(Character);

    for i, v in u18 do
        for i2, v2 in u18 do
            if i ~= i2 and (i - i2).Magnitude == 2 then
                local v25 = { u1("Part")({
                        Anchored = true,
                        CanCollide = false,
                        Material = "Neon",
                        Transparency = 1,
                        Parent = u16,
                        Name = i.X .. " | " .. i.Y .. " | " .. i.Z .. " | " .. i.W,
                        Color = Color3.fromRGB(182, 182, 182)
                    }), v, v2 };
                table.insert(u19, v25);
            end;
        end;
    end;

    if v24 then
        local v26 = not v24 and "" or v24.Data.Skin:GetAttribute("SkinName");
        local v27 = ParticleHandler.GetSkinInfo(v26);
        local v28 = 0;

        if v24 and v24.Data.Skin:GetAttribute("UnusualHueId") then
            v28 = v28 + v24.Data.Skin:GetAttribute("UnusualHueId") * 5;
        end;

        if v28 > 0 and (v27 and (v27.Metadata and v27.Metadata.SaturationThreshold)) then
            ParticleHandler.HSVShiftModel(u16, {
                SaturationThreshold = v27.Metadata.SaturationThreshold
            });
        end;

        if v28 > 0 then
            ParticleHandler.HSVShiftModel(u16, {
                HueShift = v28
            });
        end;
    end;

    u16.Parent = Character;

    for i, _ in u18 do
        i.X = i.X * 5;
        i.Y = i.Y * 5;
        i.Z = i.Z * 5;
        i.W = i.W * 5;
    end;

    local u29 = 0;
    local u30 = 0.015;
    local u31 = 1;

    local function End() -- Line: 169
        -- upvalues: u17 (copy), u19 (copy), u2 (ref), u16 (copy), RunService (ref), u31 (ref), u22 (ref), u30 (ref)
        u17.Enabled = false;

        for i = 1, #u19 do
            u2.Tween(u19[i][1], 1, "Quad", "Out", {
                Transparency = 1
            });
        end;

        u2.Tween(u16, 1, "Quad", "Out", {
            Position = u16.Position + Vector3.new(0, 1.5, 0)
        });
        local v32 = 0;

        while v32 < 110 do
            local v33 = v32 + RunService.Heartbeat:Wait() / 0.016666666666666666;
            v32 = math.min(v33, 110);
            local v34 = v32 / 110 - 1;
            u31 = 12 + 23 * (1 - v34 * v34 * v34 * v34);
            local v35 = v32 / 110 - 1;
            u22 = 1.25 + 5.75 * (1 - v35 * v35 * v35 * v35);
            local v36 = v32 / 110 - 1;
            u30 = 0.015 + -0.015 * (1 - v36 * v36 * v36 * v36);
        end;
    end;

    task.spawn(function() -- Line: 140, Name: Start
        -- upvalues: u19 (copy), u2 (ref), u21 (ref), Reference (ref), u17 (copy), RunService (ref), u31 (ref), u22 (ref), u30 (ref)
        task.delay(0.45, function() -- Line: 141
            -- upvalues: u19 (ref), u2 (ref), u21 (ref)
            for i = 1, #u19 do
                u2.Tween(u19[i][1], 0.4, "Quad", "Out", {
                    Transparency = 0
                });
            end;

            task.delay(0.39, function() -- Line: 146
                -- upvalues: u21 (ref)
                u21 = true;
            end);
        end);
        task.delay(0.5, function() -- Line: 151
            -- upvalues: Reference (ref), u17 (ref)
            if Reference then
                u17.Enabled = true;
            end;
        end);
        local v37 = 0;

        while v37 < 70 and Reference do
            local v38 = v37 + RunService.Heartbeat:Wait() / 0.016666666666666666;
            v37 = math.min(v38, 70);
            local v39 = v37 / 70 - 1;
            u31 = 1000 + -988 * (1 - v39 * v39 * v39 * v39);
            local v40 = v37 / 70 - 1;
            u22 = 0 + 1.25 * (1 - v40 * v40 * v40 * v40);
            local v41 = v37 / 70 - 1;
            u30 = 0 + 0.015 * (1 - v41 * v41 * v41 * v41);
        end;
    end);
    u14:Add(function() -- Line: 193
        -- upvalues: u20 (ref), u19 (copy), u16 (copy)
        u20 = true;
        task.delay(2, function() -- Line: 195
            -- upvalues: u19 (ref), u16 (ref)
            for i = 1, #u19 do
                local v42 = u19[i];
                local v43 = v42[2];
                v42[1]:Destroy();
                v43:Destroy();
                table.clear(v42);
                u19[i] = nil;
            end;

            u16:Destroy();
        end);
    end);
    local sin = math.sin;
    local cos = math.cos;
    task.spawn(function() -- Line: 213
        -- upvalues: u20 (ref), RunService (ref), Character (copy), u29 (ref), u22 (ref), Reference (ref), u16 (copy), sin (copy), cos (copy), new2 (ref), u18 (copy), u31 (ref), u19 (copy), new (ref), u30 (ref), u14 (copy), End (copy)
        local v44 = 0;

        while not u20 do
            local v45 = RunService.Heartbeat:Wait();
            v44 = v44 + v45;

            if v44 >= 0.016666666666666666 then
                if not Character.Parent then
                    break;
                end;

                v44 = 0;
                u29 = u29 + 0.04 * (v45 / 0.016666666666666666) * u22 % 360;

                if Reference then
                    u16.Position = Reference.WorldPosition + Reference.WorldCFrame.UpVector * -1.5 + new2(sin(u29 * 2) * 0.2, cos(u29 * 2) * 0.2, sin(u29 * 2) * 0.2);
                end;

                for i, v in u18 do
                    local v46 = i:Rotate_WZ_Y(u29, u29);
                    v.WorldPosition = u16.Position + v46:project3D(u31) + Vector3.new(0, 0, 0);
                end;

                for i = 1, #u19 do
                    local v47 = u19[i];
                    v47[1].CFrame = new(v47[2].WorldPosition:Lerp(v47[3].WorldPosition, 0.5), v47[3].WorldPosition);
                    v47[1].Size = new2(u30, u30, (v47[2].WorldPosition - v47[3].WorldPosition).Magnitude);
                end;
            end;
        end;

        Reference = nil;
        task.delay(1, function() -- Line: 253
            -- upvalues: u14 (ref)
            u14:Destroy();
        end);
        End();
    end);
    u14:Connect(Reference.AncestryChanged, function() -- Line: 292
        -- upvalues: Reference (ref), u14 (copy), End (copy)
        if not Reference.Parent then
            Reference = nil;
            task.delay(1, function() -- Line: 295
                -- upvalues: u14 (ref)
                u14:Destroy();
            end);
            End();
        end;
    end);
end;