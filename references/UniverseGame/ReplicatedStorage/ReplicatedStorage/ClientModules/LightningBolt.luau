  

 

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
local FXHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.FXHandler);

function u21.new(p22, p23, p24, p25) -- Line: 52
    -- upvalues: u21 (copy), FXHandler (copy), Part (copy), u19 (copy), clock (copy), u20 (copy)
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
    local v27 = typeof(p25) == "Instance" and p25 and p25 or workspace.CurrentCamera;
    local WorldPosition = p22.WorldPosition;
    local v28 = p22.WorldPosition + p22.WorldAxis * v26.CurveSize0;
    local v29 = p23.WorldPosition - p23.WorldAxis * v26.CurveSize1;
    local WorldPosition2 = p23.WorldPosition;
    local v30 = p24 or 30;
    local v31 = v30 * (FXHandler.GetQualityLevel() / FXHandler.GetQualityScale() * 1.75);
    local v32 = math.ceil(v31);
    local v33 = math.clamp(v32, 3, v30);
    local v34 = WorldPosition;
    local v35 = v34;
    local v36 = v34;
    v34 = v35;
    v36 = v35;

    for i = 1, v33 do
        local v37 = CubicBezier(WorldPosition, v28, v29, WorldPosition2, i / v33);
        local v38;

        if i == v33 then
            v38 = v37;
        else
            v38 = CFrame.lookAt(v34, v37).Position or v37;
        end;

        local v39 = Part:Clone();
        v39.Size = Vector3.new((v38 - v35).Magnitude, 0, 0);
        v39.CFrame = CFrame.lookAt(0.5 * (v35 + v38), v38) * u19;
        v39.Parent = v27;
        v39.Locked = true;
        v39.CastShadow = false;
        v26.Parts[i] = v39;
        v34 = v37;
        v35 = v38;
    end;

    v26.PartsHidden = false;
    v26.DisabledTransparency = 1;
    v26.StartT = clock();
    v26.RanNum = math.random() * 100;
    v26.RefIndex = #u20 + 1;
    u20[v26.RefIndex] = v26;

    return v26;
end;

function u21.Destroy(p40) -- Line: 120
    -- upvalues: u20 (copy)
    u20[p40.RefIndex] = nil;

    for i = 1, #p40.Parts do
        p40.Parts[i]:Destroy();

        if i % 100 == 0 then
            wait();
        end;
    end;
end;

game:GetService("RunService").Heartbeat:Connect(function() -- Line: 134
    -- upvalues: u20 (copy), clock (copy), u19 (copy)
    for _, v in pairs(u20) do
        if v.Enabled == true then
            v.PartsHidden = false;
            local v41 = 1 - v.MaxTransparency;
            local v42 = 1 - v.MinTransparency;
            local MinRadius = v.MinRadius;
            local MaxRadius = v.MaxRadius;
            local Thickness = v.Thickness;
            local Parts = v.Parts;
            local v43 = #Parts;
            local RanNum = v.RanNum;
            local StartT = v.StartT;
            local AnimationSpeed = v.AnimationSpeed;
            local Frequency = v.Frequency;
            local MinThicknessMultiplier = v.MinThicknessMultiplier;
            local MaxThicknessMultiplier = v.MaxThicknessMultiplier;
            local Attachment0 = v.Attachment0;
            local Attachment1 = v.Attachment1;
            local WorldPosition = Attachment0.WorldPosition;
            local v44 = Attachment0.WorldPosition + Attachment0.WorldAxis * v.CurveSize0;
            local v45 = Attachment1.WorldPosition - Attachment1.WorldAxis * v.CurveSize1;
            local WorldPosition2 = Attachment1.WorldPosition;
            local v46 = clock() - StartT;
            local PulseLength = v.PulseLength;
            local PulseSpeed = v.PulseSpeed;
            local FadeLength = v.FadeLength;
            local Color = v.Color;
            local ColorOffsetSpeed = v.ColorOffsetSpeed;
            local v47 = 1 - v.ContractFrom;

            if v46 < (PulseLength + 1) / PulseSpeed then
                local v48 = WorldPosition;
                local v49 = v48;
                local v50 = v48;
                v48 = v49;
                v50 = v49;

                for i = 1, v43 do
                    local v51 = Parts[i];
                    local v52 = i / v43;
                    local v53 = DiscretePulse(v52, PulseSpeed, PulseLength, FadeLength, v46, v41, v42);
                    local v54 = CubicBezier(WorldPosition, v44, v45, WorldPosition2, v52);
                    local v55 = -v46;
                    local v56 = AnimationSpeed * v55 + Frequency * 10 * v52 - 0.2 + RanNum * 4;
                    local v57 = 5 * (AnimationSpeed * 0.01 * v55 / 10 + Frequency * v52) + RanNum * 4;
                    local v58 = NoiseBetween(5 * v56, 1.5, 1 * v57, 0, 0.6283185307179586) + NoiseBetween(0.5 * v56, 1.5, 0.1 * v57, 0, 5.654866776461628);
                    local v59 = NoiseBetween(3.4, v57, v56, MinRadius, MaxRadius) * math.exp((v52 - 0.5) ^ 10 * -5000);
                    local v60 = NoiseBetween(2.3, v57, v56, MinThicknessMultiplier, MaxThicknessMultiplier);
                    local v61;

                    if i == v43 then
                        v61 = v54;
                    else
                        local v62 = CFrame.new(v48, v54) * CFrame.Angles(0, 0, v58);
                        local Angles = CFrame.Angles;
                        local v63 = NoiseBetween(v57, v56, 2.7, 6.123233995736766e-17, 1);
                        local v64 = math.clamp(v63, -1, 1);
                        v61 = (v62 * Angles(math.acos(v64), 0, 0) * CFrame.new(0, 0, -v59)).Position or v54;
                    end;

                    if v47 < v53 then
                        v51.Size = Vector3.new((v61 - v49).Magnitude, Thickness * v60 * v53, Thickness * v60 * v53);
                        v51.CFrame = CFrame.lookAt(0.5 * (v49 + v61), v61) * u19;
                        v51.Transparency = 1 - v53;
                    elseif v47 - 1 / (v43 * FadeLength) < v53 then
                        local v65 = (1 - (v53 - (v47 - 1 / (v43 * FadeLength))) * v43 * FadeLength) * (v52 < v46 * PulseSpeed - 0.5 * PulseLength and 1 or -1);
                        local v66 = (1 - math.abs(v65)) * (v61 - v49).Magnitude;
                        v51.Size = Vector3.new(v66, Thickness * v60 * v53, Thickness * v60 * v53);
                        v51.CFrame = CFrame.lookAt(v49 + (v61 - v49) * (math.max(0, v65) + (1 - math.abs(v65)) * 0.5), v61) * u19;
                        v51.Transparency = 1 - v53;
                    else
                        v51.Transparency = 1;
                    end;

                    if typeof(Color) == "Color3" then
                        v51.Color = Color;
                    else
                        local v67 = (RanNum + v52 - v46 * ColorOffsetSpeed) % 1;
                        local Keypoints = Color.Keypoints;

                        for i2 = 1, #Keypoints - 1 do
                            if Keypoints[i2].Time < v67 and v67 < Keypoints[i2 + 1].Time then
                                v51.Color = Keypoints[i2].Value:lerp(Keypoints[i2 + 1].Value, (v67 - Keypoints[i2].Time) / (Keypoints[i2 + 1].Time - Keypoints[i2].Time));
                                break;
                            end;
                        end;
                    end;

                    v48 = v54;
                    v49 = v61;
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