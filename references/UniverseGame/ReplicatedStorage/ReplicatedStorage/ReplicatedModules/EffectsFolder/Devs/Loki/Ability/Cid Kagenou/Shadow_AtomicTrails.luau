  

 

local RunService = game:GetService("RunService");
local ParticleHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = Random.new();

local function Quad(p2, p3, p4, p5) -- Line: 6
    return (1 - p5) * ((1 - p5) * p2 + p5 * p3) + p5 * ((1 - p5) * p3 + p5 * p4);
end;

local function CreateTrail(p6) -- Line: 10
    -- upvalues: ParticleHandler (copy), u1 (copy), RunService (copy)
    local v7 = p6 or {};
    local Trail = v7.Trail;
    local Start = v7.Start;
    local Height = v7.Height;
    local Radius = v7.Radius;
    local v8 = game.Players:GetPlayerFromCharacter(v7.Character);

    if not Start then
        return;
    end;

    local u9 = Trail:Clone();
    u9.Parent = workspace.Effects;
    local u10 = 0;
    local u11 = math.random() * 3.141592653589793 * 2;
    local u12 = math.random(1, 2) == 2;
    local v13 = 0;

    if v8 and v8.Data.Skin:GetAttribute("UnusualHueId") then
        v13 = v13 + v8.Data.Skin:GetAttribute("UnusualHueId") * 5;
    end;

    if v13 > 0 then
        ParticleHandler.HSVShiftParticles(u9, {
            HueShift = v13
        });
    end;

    local u14 = u1:NextNumber(-0.5, 0.5);
    local u15 = u1:NextNumber(-0.5, 0.5);
    task.spawn(function() -- Line: 47
        -- upvalues: u10 (ref), Height (copy), Radius (copy), u11 (ref), u14 (copy), u15 (copy), u9 (copy), Start (copy), RunService (ref), u12 (ref)
        while u10 <= Height - Height / 10 do
            local v16 = Radius / 1.2;
            local v17 = u10 / Height;
            local v18 = (1 - v17) * ((1 - v17) * Radius + v17 * v16) + v17 * ((1 - v17) * v16 + v17 * (Radius / 10));
            local v19 = v18 * math.cos(u11);
            local v20 = v18 * math.sin(u11);
            local v21 = math.clamp(u10, 0, Height);
            local v22 = CFrame.new(v19 + u14, v21, v20 + u15);

            if u9 and u9.Parent then
                u9.CFrame = (typeof(Start) ~= "CFrame" and Start.CFrame * CFrame.new(0, -3.5, 0) or Start) * v22;
            end;

            local v23 = RunService.Heartbeat:Wait();
            local v24 = 6.283185307179586 / (Height / 15) * v23;
            local v25 = 1 + (math.random() - 0.5) * 0.1;
            local v26;

            if u12 then
                v26 = u11 - v24 * v25;
            else
                v26 = u11 + v24 * v25;
            end;

            u11 = v26;
            u10 = math.clamp(u10 + 15 * v23, 0, Height);
        end;
    end);
    task.delay(1, u9.Destroy, u9);
end;

return function(p27) -- Line: 74
    -- upvalues: CreateTrail (copy)
    local Character = p27.Character;

    repeat
        task.wait(0.0875);
        CreateTrail(p27);
    until not (Character.Parent and Character:GetAttribute("AtomicTrails"));
end;