  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.GenericModule);
local _ = PathShortcuts.ClientAssets;
local PathShortcuts2 = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
require(PathShortcuts2.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(PathShortcuts2.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(Knit.Util.Trove);
local Petal = _G.Petal;
Petal("New");
local u1 = Petal("Util");
local u2 = Petal("Extensions");
local Plane = script.Plane;

local function CreateSquare(u3, p4, u5, u6, u7, u8, u9, p10, p11) -- Line: 23
    -- upvalues: Plane (copy), ParticleHandler (copy), u1 (copy), RunService (copy), TweenService (copy)
    local u12 = 1.618033988749895 * p4;
    local u13 = {
        Vector3.new(1, 0, 1) * u12,
        Vector3.new(-1, 0, 1) * u12,
        Vector3.new(-1, 0, -1) * u12,
        Vector3.new(1, 0, -1) * u12,
        Vector3.new(1, 0, 1) * u12
    };
    local u14 = Plane:Clone();

    if p11 then
        ParticleHandler.Unusualify(u14, {
            HSVData = p11
        });

        if p11.Chroma then
            ParticleHandler.Chromaify(u14, {
                Character = u3:FindFirstAncestorWhichIsA("Model")
            });
        end;
    end;

    u14.Parent = workspace.Terrain;
    local u15 = {};

    for _, child in u14:GetChildren() do
        u15[#u15 + 1] = child;
    end;

    table.sort(u15, function(p16, p17) -- Line: 46
        return string.byte(p16.Name) < string.byte(p17.Name);
    end);

    for _, child in u15[1]:GetChildren() do
        if child:IsA("Beam") then
            child.Width0 = p10 or 0.2;
            child.Width1 = p10 or 0.2;
        end;
    end;

    for i = 1, #u15 do
        u15[i].Position = u13[1];
        task.spawn(function() -- Line: 59
            -- upvalues: u13 (copy), i (copy), u1 (ref), u15 (copy), u5 (copy)
            for i2 = 1, #u13 do
                if i < i2 then
                    break;
                end;

                u1.Tween(u15[i], u5 / #u13, "Linear", "Out", {
                    Position = u13[i2]
                });
                task.wait(u5 / #u13);

                if i2 < #u15 then
                    u15[1]:FindFirstChild(i2).Enabled = true;
                end;
            end;
        end);
    end;

    local u18 = CFrame.Angles(0, 0, 0);
    local u19 = u6;
    local u20 = 0;
    task.spawn(function() -- Line: 79
        -- upvalues: u3 (copy), u7 (copy), u20 (ref), u8 (copy), RunService (ref), u6 (ref), u19 (copy), TweenService (ref), u18 (ref), u9 (copy), u14 (copy), u15 (copy), u1 (ref), u12 (ref)
        while u3 and u3.Parent do
            if u7 then
                if u7 <= u20 then
                    break;
                end;
            elseif u8 and not u8:IsDescendantOf(workspace) then
                break;
            end;

            local v21 = RunService.Heartbeat:Wait();
            local v22 = v21 * 60;

            if u7 then
                u6 = u19:Lerp(u19 * 0.1, TweenService:GetValue(u20 / u7, Enum.EasingStyle.Quad, Enum.EasingDirection.In));
            end;

            u20 = u20 + v21;
            u18 = u18 * CFrame.Angles(math.rad(u6.X * v22), math.rad(u6.Y * v22), (math.rad(u6.Z * v22)));

            if u9 then
                u14.CFrame = CFrame.new(u3.Position) * u18;
            else
                u14.CFrame = u3.CFrame * u18;
            end;
        end;

        for _, child in u15[1]:GetChildren() do
            if child:IsA("Beam") then
                u1.Tween(child, u12 / 10, "Quad", "InOut", {
                    Width0 = 0,
                    Width1 = 0
                });
            end;
        end;

        task.delay(u12 / 5, function() -- Line: 111
            -- upvalues: u14 (ref), u15 (ref)
            u14:Destroy();
            table.clear(u15);
        end);
    end);
end;

return function(p23) -- Line: 118
    -- upvalues: CreateSquare (copy), u2 (copy)
    local AttachPart = p23.AttachPart;
    local v24 = p23.RotationStrength or 3;

    if AttachPart == nil then
        return;
    end;

    for i = 1, p23.Count or 3 do
        local v25;

        if p23.Reference then
            v25 = nil;
        elseif p23.Time then
            v25 = p23.Time + i / 7.5;
        else
            v25 = i / 7.5 + 2;
        end;

        local v26 = i * (not p23.Scale and 1 or p23.Scale);
        local v27 = math.log(i + 1, 3);
        local v28 = u2.Rng(-v24, v24);
        local v29 = u2.Rng(-v24, v24);
        CreateSquare(AttachPart, v26, v27, Vector3.new(v28, v29, u2.Rng(-v24, v24)), v25, p23.Reference, p23.WorldSpace, p23.Thickness, p23.HSVData);
    end;
end;