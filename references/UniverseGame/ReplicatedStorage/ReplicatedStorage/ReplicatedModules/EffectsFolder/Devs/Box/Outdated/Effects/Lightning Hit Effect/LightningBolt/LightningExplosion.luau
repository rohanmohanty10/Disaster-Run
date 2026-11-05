  

 

local Parent = require(script.Parent);
local LightningSparks = require(script.Parent.LightningSparks);
local u1 = Random.new();
local clock = os.clock;

function RandomVectorOffsetBetween(p2, p3, p4)
    -- upvalues: u1 (copy)
    local v5 = CFrame.lookAt(Vector3.new(), p2) * CFrame.Angles(0, 0, u1:NextNumber(0, 6.283185307179586));
    local Angles = CFrame.Angles;
    local v6 = u1:NextNumber(math.cos(p4), (math.cos(p3)));

    return (v5 * Angles(math.acos(v6), 0, 0)).LookVector;
end;

local u7 = {};
local u8 = {};
u8.__index = u8;

function u8.new(p9, p10, p11, p12, p13, p14) -- Line: 20
    -- upvalues: u8 (copy), u1 (copy), Parent (copy), LightningSparks (copy), clock (copy), u7 (copy)
    local v15 = setmetatable({}, u8);
    v15.Size = p10 or 1;
    v15.NumBolts = p11 or 6;
    v15.Color = p12 or ColorSequence.new(Color3.new(1, 0, 0), Color3.new(0, 0, 1));
    v15.BoltColor = p13 or Color3.new(0.3, 0.3, 1);
    v15.UpVector = p14 or Vector3.new(0, 1, 0);
    local CurrentCamera = workspace.CurrentCamera;
    local Part = Instance.new("Part");
    Part.Name = "LightningExplosion";
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.Locked = true;
    Part.CastShadow = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(0.05, 0.05, 0.05);
    Part.CFrame = CFrame.lookAt(p9 + Vector3.new(0, 0.5, 0), p9 + Vector3.new(0, 0.5, 0) + v15.UpVector) * CFrame.lookAt(Vector3.new(), Vector3.new(0, 1, 0)):inverse();
    Part.Parent = CurrentCamera;
    local Attachment = Instance.new("Attachment");
    Attachment.Parent = Part;
    Attachment.CFrame = CFrame.new();
    local v16 = script.ExplosionBrightspot:Clone();
    local v17 = script.GlareEmitter:Clone();
    local v18 = script.PlasmaEmitter:Clone();
    local v19 = math.clamp(v15.Size, 0, 1);
    v17.Size = NumberSequence.new(v19 * 30);
    v18.Size = NumberSequence.new(v19 * 18);
    v18.Speed = NumberRange.new(v19 * 100);
    v16.Parent = Attachment;
    v17.Parent = Attachment;
    v18.Parent = Attachment;
    local Color = v15.Color;

    if typeof(Color) == "Color3" then
        local v20 = ColorSequence.new(Color);
        local v21 = ColorSequence.new(Color);
        v17.Color = v20;
        v18.Color = v21;
        local v22, _, v23 = Color3.toHSV(Color);
        v16.Color = ColorSequence.new(Color3.fromHSV(v22, 0.5, v23));
    else
        v17.Color = Color;
        v18.Color = Color;
        local Keypoints = Color.Keypoints;

        for i = 1, #Keypoints do
            local v24, _, v25 = Color3.toHSV(Keypoints[i].Value);
            Keypoints[i] = ColorSequenceKeypoint.new(Keypoints[i].Time, Color3.fromHSV(v24, 0.5, v25));
        end;

        v16.Color = ColorSequence.new(Keypoints);
    end;

    v16.Enabled = true;
    v17.Enabled = true;
    v18.Enabled = true;
    local v26 = {};

    for _ = 1, v15.NumBolts do
        local v27 = {};
        local v28 = {};
        local WorldPosition = Attachment.WorldPosition;
        local v29 = RandomVectorOffsetBetween(v15.UpVector, 1.1344640137963142, 1.3962634015954636);
        v27.WorldPosition = WorldPosition;
        v27.WorldAxis = v29;
        local v30 = Attachment.WorldPosition + v27.WorldAxis * u1:NextNumber(20, 40) * 1.4 * v19;
        local v31 = RandomVectorOffsetBetween(-v15.UpVector, 1.2217304763960306, 1.9198621771937625);
        v28.WorldPosition = v30;
        v28.WorldAxis = v31;
        local v32 = Parent.new(v27, v28, 10);
        v32.AnimationSpeed = 0;
        v32.Thickness = 1;
        v32.Color = v15.BoltColor;
        v32.PulseLength = 0.8;
        v32.ColorOffsetSpeed = 20;
        v32.Frequency = 2;
        v32.MinRadius = 0;
        v32.MaxRadius = v19 * 4;
        v32.FadeLength = 0.4;
        v32.PulseSpeed = 4;
        v32.MinThicknessMultiplier = 0.7;
        v32.MaxThicknessMultiplier = 1;
        local v33 = LightningSparks.new(v32, 5);
        v33.MinDistance = 7.5;
        v33.MaxDistance = 10;
        v32.Velocity = (v28.WorldPosition - v27.WorldPosition).Unit * 0.1 * v19;
        v26[#v26 + 1] = v32;
    end;

    v15.Bolts = v26;
    v15.Attachment = Attachment;
    v15.Part = Part;
    v15.StartT = clock();
    v15.RefIndex = #u7 + 1;
    u7[v15.RefIndex] = v15;

    return v15;
end;

function u8.Destroy(p34) -- Line: 122
    -- upvalues: u7 (copy)
    u7[p34.RefIndex] = nil;
    p34.Part:Destroy();

    for i = 1, #p34.Bolts do
        p34.Bolts[i] = nil;
    end;
end;

game:GetService("RunService").Heartbeat:Connect(function() -- Line: 133
    -- upvalues: u7 (copy), clock (copy)
    for _, v in pairs(u7) do
        local v35 = clock() - v.StartT;
        local Attachment = v.Attachment;

        if v35 < 0.7 then
            if v35 > 0.2 then
                local GlareEmitter = Attachment.GlareEmitter;
                local PlasmaEmitter = Attachment.PlasmaEmitter;
                Attachment.ExplosionBrightspot.Enabled = false;
                GlareEmitter.Enabled = false;
                PlasmaEmitter.Enabled = false;
            end;

            for i = 1, #v.Bolts do
                local v36 = v.Bolts[i];
                v36.Attachment1.WorldPosition = v36.Attachment1.WorldPosition + v36.Velocity;
            end;
        else
            v:Destroy();
        end;
    end;
end);

return u8;