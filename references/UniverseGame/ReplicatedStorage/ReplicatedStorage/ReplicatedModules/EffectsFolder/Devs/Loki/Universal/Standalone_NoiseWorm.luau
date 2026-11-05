  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local RunService = game:GetService("RunService");
local ParticleHandler = require(PathShortcuts.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local Petal = _G.Petal;
Petal("New");
local u1 = Petal("Util");
CFn = CFrame.new;
V3n = Vector3.new;
Ang = CFrame.Angles;
Rad = math.rad;
Noise = math.noise;
Clamp = math.clamp;

function Rng(p2, p3)
    return Random.new():NextNumber(p2, p3);
end;

local Heartbeat = RunService.Heartbeat;
local u4 = {
    Resolution = 1,
    NoiseIntensity = 1,
    TravelDistance = 15,
    MaxAngle = 0,
    Smoothen = 0.8,
    Object = "",
    Return = false,
    Drag = 1,
    Amount = 1,
    Part = "",
    HueShift = 0,
    Player = "",
    ReturnDuration = 0,
    Origin = Vector3.new(),
    Color = Color3.new()
};

local function Lerp(p5, p6, p7) -- Line: 39
    return p5:Lerp(p6, p7);
end;

local function Quad(p8, p9, p10, p11) -- Line: 43
    -- upvalues: Lerp (copy)
    return Lerp(p8:Lerp(p9, p11), p9:Lerp(p10, p11), p11);
end;

local function Cubic(p12, p13, p14, p15, p16) -- Line: 47
    -- upvalues: Quad (copy)
    return Quad(p12:Lerp(p13, p16):Lerp(p13:Lerp(p14, p16), p16), p13:Lerp(p14, p16):Lerp(p14:Lerp(p15, p16), p16), p12:Lerp(p14, p16):Lerp(p14:Lerp(p15, p16), p16), p16);
end;

return function(p17) -- Line: 51
    -- upvalues: u4 (copy), u1 (copy), ParticleHandler (copy), Heartbeat (copy)
    local v18 = {};

    for i, v in next, u4 do
        if p17[i] then
            if typeof(p17[i]) == "table" then
                v18[i] = Rng(p17[i][1], p17[i][2]);
            else
                v18[i] = p17[i];
            end;
        else
            v18[i] = v;
        end;
    end;

    local v19;

    if v18.Player == "" then
        v19 = nil;
    else
        v19 = v18.Player;
    end;

    local v20 = v19 and (v19.Data.Skin:GetAttribute("UnusualHueId") and v19.Data.Skin:GetAttribute("UnusualHueId") * 5) or (v18.HueShift or 0);

    for _ = 1, v18.Amount do
        local u21 = u1.tableMerge(v18, {});

        for i, v in next, p17 do
            if typeof(v) == "table" then
                u21[i] = Rng(v[1], v[2]);
            end;
        end;

        local u22 = Rng(1, 100000000);
        local Resolution = u21.Resolution;
        local u23;

        if u21.Object == "" then
            u23 = script.Base:Clone();
        else
            u23 = u21.Object:Clone();
        end;

        ParticleHandler.HSVShiftParticles(u23, {
            HueShift = v20
        });

        if typeof(u21.Origin) == "Vector3" then
            u23.Position = u21.Origin;
        else
            u23.CFrame = u21.Part ~= "" and u21.Part.CFrame * u21.Origin or u21.Origin;
        end;

        task.spawn(function() -- Line: 97
            -- upvalues: u21 (copy), u23 (ref), Heartbeat (ref), Resolution (ref), u22 (copy)
            local v24;

            if u21.Part == "" then
                v24 = u21.Origin * Ang(Rad(Rng(-u21.MaxAngle, u21.MaxAngle)), Rad(Rng(-u21.MaxAngle, u21.MaxAngle)), Rad(Rng(-u21.MaxAngle, u21.MaxAngle)));
            else
                v24 = u21.Part.CFrame * u21.Origin * Ang(Rad(Rng(-u21.MaxAngle, u21.MaxAngle)), Rad(Rng(-u21.MaxAngle, u21.MaxAngle)), Rad(Rng(-u21.MaxAngle, u21.MaxAngle)));
            end;

            u23.CFrame = v24;
            u23.Parent = workspace.Effects;

            for i = 1, u21.TravelDistance do
                Heartbeat:Wait();
                local v25 = Noise(v24.X / Resolution + 0.1, u22);
                local v26 = Noise(v24.Y / Resolution + 0.1, u22);
                local v27 = Noise(v24.Z / Resolution + 0.1, u22);
                local Position = v24.Position;
                v24 = v24 * Ang(v25 * u21.NoiseIntensity, v26 * u21.NoiseIntensity, v27 * u21.NoiseIntensity) * CFn(0, 0, -Resolution);
                local _ = (Position - v24.Position).Unit;
                u23.CFrame = u23.CFrame:Lerp(CFn(v24.p), u21.Smoothen);
                Resolution = math.clamp(Resolution - (u21.Drag - 1), 0, 100);

                if u21.TravelDistance - 5 < i and u21.Return then
                    break;
                end;
            end;

            if u21.Return then
                local CFrame2 = u23.CFrame;
                local v28 = CFn(CFrame2.Position + v24.RightVector * Rng(-30, 30) + v24.UpVector * Rng(-30, 30));
                local v29 = v28 + V3n(Rng(-20, 20), Rng(-20, 20), Rng(-20, 20));
                local ReturnDuration = u21.ReturnDuration;

                for i = 1, ReturnDuration do
                    Heartbeat:Wait();

                    if u21.Part == "" then
                        local Origin = u21.Origin;
                        local v30 = i / ReturnDuration;
                        u23.CFrame = CFrame2:Lerp(v28, v30):Lerp(v28:Lerp(Origin, v30), v30);
                    else
                        local v31 = u21.Part.CFrame * u21.Origin;
                        local v32 = u21.Part.CFrame * u21.Origin;
                        local v33 = i / ReturnDuration;
                        local v34 = v31:Lerp(v28, v33):Lerp(v28:Lerp(v29, v33), v33);
                        local v35 = v28:Lerp(v29, v33):Lerp(v29:Lerp(v32, v33), v33);
                        local v36 = v31:Lerp(v29, v33):Lerp(v29:Lerp(v32, v33), v33);
                        u23.CFrame = v34:Lerp(v35, v33):Lerp(v35:Lerp(v36, v33), v33);
                    end;
                end;
            end;

            task.delay(0.5, function() -- Line: 145
                -- upvalues: u23 (ref)
                u23:Destroy();
            end);
        end);
    end;
end;