  

 

local clock = os.clock;

function DiscretePulse(p1, p2, p3, p4, p5, p6, p7)
    local v8 = p3 / (2 * p4) - math.abs((p1 - p5 * p2 + 0.5 * p3) / p4);

    return math.clamp(v8, p6, p7);
end;

function NoiseBetween(p9, p10, p11, p12, p13)
    return p12 + (p13 - p12) * (math.noise(p9, p10, p11) + 0.5);
end;

function CubicBezier(p14, p15, p16, p17, p18)
    return p14 * (1 - p18) ^ 3 + p15 * 3 * p18 * (1 - p18) ^ 2 + p16 * 3 * (1 - p18) * p18 ^ 2 + p17 * p18 ^ 3;
end;

local Part = Instance.new("Part");
Part.TopSurface = 0;
Part.BottomSurface = 0;
Part.Anchored = true;
Part.CanCollide = false;
Part.Shape = "Cylinder";
Part.Name = "BoltPart";
Part.Material = Enum.Material.Neon;
Part.Color = Color3.new(1, 1, 1);
Part.Transparency = 1;
Random.new();
local u19 = CFrame.lookAt(Vector3.new(), Vector3.new(1, 0, 0)):inverse();
local u20 = {};
local u21 = {};
u21.__index = u21;

function u21.new(p22, p23, p24, p25) -- Line: 51
    -- upvalues: u21 (copy), Part (copy), u19 (copy), clock (copy), u20 (copy)
    local v26 = setmetatable({}, u21);
    v26.Enabled = true;
    v26.Attachment0 = p22;
    v26.Attachment1 = p23;
    v26.CurveSize0 = 0;
    v26.CurveSize1 = 0;
    v26.MinRadius = 0;
    v26.MaxRadius = 2.4;
    v26.Frequency = 1;
    v26.AnimationSpeed = 7;
    v26.Thickness = 1;
    v26.MinThicknessMultiplier = 0.2;
    v26.MaxThicknessMultiplier = 1;
    v26.MinTransparency = 0;
    v26.MaxTransparency = 1;
    v26.PulseSpeed = 2;
    v26.PulseLength = 1000000;
    v26.FadeLength = 0.2;
    v26.ContractFrom = 0.5;
    v26.Color = Color3.new(1, 1, 1);
    v26.ColorOffsetSpeed = 3;
    v26.Parts = {};
    local Effects = workspace.Effects;
    local WorldPosition = p22.WorldPosition;
    local v27 = p22.WorldPosition + p22.WorldAxis * v26.CurveSize0;
    local v28 = p23.WorldPosition - p23.WorldAxis * v26.CurveSize1;
    local WorldPosition2 = p23.WorldPosition;
    local v29 = p24 or 30;
    local v30 = WorldPosition;
    local v31 = v30;
    local v32 = v30;
    v30 = v31;
    v32 = v31;
    local v33 = p25 or "Neon";

    for i = 1, v29 do
        local v34 = CubicBezier(WorldPosition, v27, v28, WorldPosition2, i / v29);
        local v35;

        if i == v29 then
            v35 = v34;
        else
            v35 = CFrame.lookAt(v30, v34).Position or v34;
        end;

        local v36 = Part:Clone();
        v36.Material = Enum.Material[v33];
        v36.Size = Vector3.new((v35 - v31).Magnitude, 0, 0);
        v36.CFrame = CFrame.lookAt(0.5 * (v31 + v35), v35) * u19;
        v36.Parent = Effects;
        v36.Locked = true;
        v36.CastShadow = false;
        v26.Parts[i] = v36;
        v30 = v34;
        v31 = v35;
    end;

    v26.PartsHidden = false;
    v26.A0 = p22;
    v26.A1 = p23;
    v26.DisabledTransparency = 1;
    v26.StartT = clock();
    v26.RanNum = math.random() * 100;
    v26.RefIndex = #u20 + 1;
    u20[v26.RefIndex] = v26;

    return v26;
end;

function u21.Destroy(p37) -- Line: 119
    -- upvalues: u20 (copy)
    u20[p37.RefIndex] = nil;

    for i = 1, #p37.Parts do
        p37.Parts[i]:Destroy();

        if i % 100 == 0 then
            wait();
        end;
    end;
end;

game:GetService("RunService").Heartbeat:Connect(function() -- Line: 133
    -- upvalues: u20 (copy), clock (copy), u19 (copy)
    for _, v in pairs(u20) do
        if v.Enabled == true then
            v.PartsHidden = false;
            local v38 = 1 - v.MaxTransparency;
            local v39 = 1 - v.MinTransparency;
            local MinRadius = v.MinRadius;
            local MaxRadius = v.MaxRadius;
            local Thickness = v.Thickness;
            local Parts = v.Parts;
            local v40 = #Parts;
            local RanNum = v.RanNum;
            local StartT = v.StartT;
            local AnimationSpeed = v.AnimationSpeed;
            local Frequency = v.Frequency;
            local MinThicknessMultiplier = v.MinThicknessMultiplier;
            local MaxThicknessMultiplier = v.MaxThicknessMultiplier;
            local Attachment0 = v.Attachment0;
            local Attachment1 = v.Attachment1;
            local WorldPosition = Attachment0.WorldPosition;
            local v41 = Attachment0.WorldPosition + Attachment0.WorldAxis * v.CurveSize0;
            local v42 = Attachment1.WorldPosition - Attachment1.WorldAxis * v.CurveSize1;
            local WorldPosition2 = Attachment1.WorldPosition;
            local v43 = clock() - StartT;
            local PulseLength = v.PulseLength;
            local PulseSpeed = v.PulseSpeed;
            local FadeLength = v.FadeLength;
            local Color = v.Color;
            local ColorOffsetSpeed = v.ColorOffsetSpeed;
            local v44 = 1 - v.ContractFrom;

            if v43 < (PulseLength + 1) / PulseSpeed then
                local v45 = WorldPosition;
                local v46 = v45;
                local v47 = v45;
                v45 = v46;
                v47 = v46;

                for i = 1, v40 do
                    local v48 = Parts[i];
                    local v49 = i / v40;
                    local v50 = DiscretePulse(v49, PulseSpeed, PulseLength, FadeLength, v43, v38, v39);
                    local v51 = CubicBezier(WorldPosition, v41, v42, WorldPosition2, v49);
                    local v52 = -v43;
                    local v53 = AnimationSpeed * v52 + Frequency * 10 * v49 - 0.2 + RanNum * 4;
                    local v54 = 5 * (AnimationSpeed * 0.01 * v52 / 10 + Frequency * v49) + RanNum * 4;
                    local v55 = NoiseBetween(5 * v53, 1.5, 1 * v54, 0, 0.6283185307179586) + NoiseBetween(0.5 * v53, 1.5, 0.1 * v54, 0, 5.654866776461628);
                    local v56 = NoiseBetween(3.4, v54, v53, MinRadius, MaxRadius) * math.exp((v49 - 0.5) ^ 10 * -5000);
                    local v57 = NoiseBetween(2.3, v54, v53, MinThicknessMultiplier, MaxThicknessMultiplier);
                    local v58;

                    if i == v40 then
                        v58 = v51;
                    else
                        local v59 = CFrame.new(v45, v51) * CFrame.Angles(0, 0, v55);
                        local Angles = CFrame.Angles;
                        local v60 = NoiseBetween(v54, v53, 2.7, 6.123233995736766e-17, 1);
                        local v61 = math.clamp(v60, -1, 1);
                        v58 = (v59 * Angles(math.acos(v61), 0, 0) * CFrame.new(0, 0, -v56)).Position or v51;
                    end;

                    if v44 < v50 then
                        v48.Size = Vector3.new((v58 - v46).Magnitude, Thickness * v57 * v50, Thickness * v57 * v50);
                        v48.CFrame = CFrame.lookAt(0.5 * (v46 + v58), v58) * u19;
                        v48.Transparency = 1 - v50;
                    elseif v44 - 1 / (v40 * FadeLength) < v50 then
                        local v62 = (1 - (v50 - (v44 - 1 / (v40 * FadeLength))) * v40 * FadeLength) * (v49 < v43 * PulseSpeed - 0.5 * PulseLength and 1 or -1);
                        local v63 = (1 - math.abs(v62)) * (v58 - v46).Magnitude;
                        v48.Size = Vector3.new(v63, Thickness * v57 * v50, Thickness * v57 * v50);
                        v48.CFrame = CFrame.lookAt(v46 + (v58 - v46) * (math.max(0, v62) + (1 - math.abs(v62)) * 0.5), v58) * u19;
                        v48.Transparency = 1 - v50;
                    else
                        v48.Transparency = 1;
                    end;

                    if typeof(Color) == "Color3" then
                        v48.Color = Color;
                    else
                        local v64 = (RanNum + v49 - v43 * ColorOffsetSpeed) % 1;
                        local Keypoints = Color.Keypoints;

                        for i2 = 1, #Keypoints - 1 do
                            if Keypoints[i2].Time < v64 and v64 < Keypoints[i2 + 1].Time then
                                v48.Color = Keypoints[i2].Value:lerp(Keypoints[i2 + 1].Value, (v64 - Keypoints[i2].Time) / (Keypoints[i2 + 1].Time - Keypoints[i2].Time));
                                break;
                            end;
                        end;
                    end;

                    v45 = v51;
                    v46 = v58;
                end;
            else
                v:Destroy();
            end;
        elseif v.PartsHidden == false then
            v.PartsHidden = true;
            local DisabledTransparency = v.DisabledTransparency;

            for i = 1, #v.Parts do
                v.Parts[i].Transparency = DisabledTransparency;
            end;
        end;
    end;
end);

return u21;