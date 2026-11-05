  

 

local clock = os.clock;
local u1 = nil;
local u2 = nil;
local u3 = nil;
local LocalPlayer = game:GetService("Players").LocalPlayer;

function DiscretePulse(p4, p5, p6, p7, p8, p9, p10)
    local v11 = p6 / (2 * p7) - math.abs((p4 - p8 * p5 + 0.5 * p6) / p7);

    return math.clamp(v11, p9, p10);
end;

function NoiseBetween(p12, p13, p14, p15, p16)
    return p15 + (p16 - p15) * (math.noise(p12, p13, p14) + 0.5);
end;

function CubicBezier(p17, p18, p19, p20, p21)
    return p17 * (1 - p21) ^ 3 + p18 * 3 * p21 * (1 - p21) ^ 2 + p19 * 3 * (1 - p21) * p21 ^ 2 + p20 * p21 ^ 3;
end;

local ImageHandleAdornment = Instance.new("ImageHandleAdornment");
ImageHandleAdornment.Name = "BoltAdorn";
ImageHandleAdornment.Image = "http://www.roblox.com/asset/?id=4955566540";
ImageHandleAdornment.Transparency = 1;
ImageHandleAdornment.Color3 = Color3.new(1, 1, 1);
ImageHandleAdornment.ZIndex = 0;
ImageHandleAdornment.Size = Vector2.new(0, 0);
Random.new();
local u22 = {};
local u23 = {};
u23.__index = u23;

function u23.new(p24, p25, p26) -- Line: 49
    -- upvalues: u23 (copy), u3 (ref), LocalPlayer (copy), u1 (ref), u2 (ref), ImageHandleAdornment (copy), clock (copy), u22 (copy)
    local v27 = setmetatable({}, u23);
    v27.Enabled = true;
    v27.Attachment0 = p24;
    v27.Attachment1 = p25;
    v27.CurveSize0 = 0;
    v27.CurveSize1 = 0;
    v27.MinRadius = 0;
    v27.MaxRadius = 2.4;
    v27.Frequency = 1;
    v27.AnimationSpeed = 7;
    v27.Thickness = 2;
    v27.MinThicknessMultiplier = 0.2;
    v27.MaxThicknessMultiplier = 1;
    v27.MinTransparency = 0;
    v27.MaxTransparency = 1;
    v27.PulseSpeed = 2;
    v27.PulseLength = 1000000;
    v27.FadeLength = 0.2;
    v27.ContractFrom = 0.5;
    v27.Color = Color3.new(1, 1, 1);
    v27.ColorOffsetSpeed = 3;
    v27.Parts = {};
    u3 = workspace.CurrentCamera;

    if LocalPlayer.PlayerGui:FindFirstChild("LightningBeams") == nil then
        u1 = Instance.new("ScreenGui");
        u1.Name = "LightningBeams";
        u1.ResetOnSpawn = false;
        u1.Parent = LocalPlayer.PlayerGui;
        u2 = Instance.new("Part");
        u2.Anchored = true;
        u2.Locked = true;
        u2.CanCollide = false;
        u2.CFrame = CFrame.new();
        u2.Size = Vector3.new(0, 0, 0);
        u2.Transparency = 1;
        u2.Parent = u1;
        u2.Name = "AdorneePart";
    end;

    local v28 = u1;
    local WorldPosition = p24.WorldPosition;
    local v29 = p24.WorldPosition + p24.WorldAxis * v27.CurveSize0;
    local v30 = p25.WorldPosition - p25.WorldAxis * v27.CurveSize1;
    local WorldPosition2 = p25.WorldPosition;
    local v31 = p26 or 30;
    local v32 = WorldPosition;

    for i = 1, v31 do
        local v33 = CubicBezier(WorldPosition, v29, v30, WorldPosition2, i / v31);
        local v34;

        if i == v31 then
            v34 = v33;
        else
            v34 = CFrame.lookAt(v32, v33).Position or v33;
        end;

        local v35 = ImageHandleAdornment:Clone();
        v35.Parent = v28;
        v35.Adornee = u2;
        v27.Parts[i] = v35;
        v32 = v33;
    end;

    v27.PartsHidden = false;
    v27.DisabledTransparency = 1;
    v27.StartT = clock();
    v27.RanNum = math.random() * 100;
    v27.RefIndex = #u22 + 1;
    u22[v27.RefIndex] = v27;

    return v27;
end;

function u23.DestroyDissipate(u36, p37, p38) -- Line: 127
    -- upvalues: clock (copy)
    local u39 = p37 or 0.2;
    local u40 = p38 or 0.5;
    local u41 = clock();
    local MinTransparency = u36.MinTransparency;
    local ContractFrom = u36.ContractFrom;
    local u42 = u36.ContractFrom + 1 / (#u36._Parts * u36.FadeLength);
    local MaxRadius = u36.MaxRadius;
    local MinThicknessMultiplier = u36.MinThicknessMultiplier;
    local u43 = nil;
    u43 = game:GetService("RunService").Heartbeat:Connect(function() -- Line: 137
        -- upvalues: clock (ref), u41 (copy), u36 (copy), MinThicknessMultiplier (copy), u39 (ref), MinTransparency (copy), ContractFrom (copy), u42 (copy), MaxRadius (copy), u40 (ref), u43 (ref)
        local v44 = clock() - u41;
        u36.MinThicknessMultiplier = MinThicknessMultiplier + (-2 - MinThicknessMultiplier) * v44 / u39;

        if v44 < u39 * 0.4 then
            u36.MinTransparency = MinTransparency + (ContractFrom - MinTransparency) * (v44 / (u39 * 0.4));

            return;
        end;

        if v44 >= u39 then
            if clock() - u36._StartT < (u36.PulseLength + 1) / u36.PulseSpeed then
                u36:Destroy();
            end;

            u43:Disconnect();
            u43 = nil;

            return;
        end;

        local v45 = (v44 - u39 * 0.4) / (u39 * 0.6);
        u36.MinTransparency = ContractFrom + (u42 - ContractFrom) * v45;
        u36.MaxRadius = MaxRadius * (1 + u40 * v45);
        u36.MinRadius = u36.MinRadius + (u36.MaxRadius - u36.MinRadius) * v45;
    end);
end;

function u23.Destroy(p46) -- Line: 165
    -- upvalues: u22 (copy)
    u22[p46.RefIndex] = nil;

    for i = 1, #p46.Parts do
        p46.Parts[i]:Destroy();

        if i % 100 == 0 then
            wait();
        end;
    end;
end;

local Cross = Vector3.new().Cross;
game:GetService("RunService").Heartbeat:Connect(function() -- Line: 180
    -- upvalues: u22 (copy), clock (copy), Cross (copy), u3 (ref)
    for _, v in pairs(u22) do
        if v.Enabled == true then
            v.PartsHidden = false;
            local v47 = 1 - v.MaxTransparency;
            local v48 = 1 - v.MinTransparency;
            local MinRadius = v.MinRadius;
            local MaxRadius = v.MaxRadius;
            local Thickness = v.Thickness;
            local Parts = v.Parts;
            local v49 = #Parts;
            local RanNum = v.RanNum;
            local StartT = v.StartT;
            local AnimationSpeed = v.AnimationSpeed;
            local Frequency = v.Frequency;
            local MinThicknessMultiplier = v.MinThicknessMultiplier;
            local MaxThicknessMultiplier = v.MaxThicknessMultiplier;
            local Attachment0 = v.Attachment0;
            local Attachment1 = v.Attachment1;
            local WorldPosition = Attachment0.WorldPosition;
            local v50 = Attachment0.WorldPosition + Attachment0.WorldAxis * v.CurveSize0;
            local v51 = Attachment1.WorldPosition - Attachment1.WorldAxis * v.CurveSize1;
            local WorldPosition2 = Attachment1.WorldPosition;
            local v52 = clock() - StartT;
            local PulseLength = v.PulseLength;
            local PulseSpeed = v.PulseSpeed;
            local FadeLength = v.FadeLength;
            local Color = v.Color;
            local ColorOffsetSpeed = v.ColorOffsetSpeed;
            local v53 = 1 - v.ContractFrom;

            if v52 < (PulseLength + 1) / PulseSpeed then
                local v54 = WorldPosition;
                local v55 = v54;
                local v56 = v54;
                v54 = v55;
                v56 = v55;

                for i = 1, v49 do
                    local v57 = Parts[i];
                    local v58 = i / v49;
                    local v59 = DiscretePulse(v58, PulseSpeed, PulseLength, FadeLength, v52, v47, v48);
                    local v60 = CubicBezier(WorldPosition, v50, v51, WorldPosition2, v58);
                    local v61 = -v52;
                    local v62 = AnimationSpeed * v61 + Frequency * 10 * v58 - 0.2 + RanNum * 4;
                    local v63 = 5 * (AnimationSpeed * 0.01 * v61 / 10 + Frequency * v58) + RanNum * 4;
                    local v64 = NoiseBetween(5 * v62, 1.5, 1 * v63, 0, 0.6283185307179586) + NoiseBetween(0.5 * v62, 1.5, 0.1 * v63, 0, 5.654866776461628);
                    local v65 = NoiseBetween(3.4, v63, v62, MinRadius, MaxRadius) * math.exp((v58 - 0.5) ^ 10 * -5000);
                    local v66 = NoiseBetween(2.3, v63, v62, MinThicknessMultiplier, MaxThicknessMultiplier);
                    local v67;

                    if i == v49 then
                        v67 = v60;
                    else
                        local v68 = CFrame.new(v54, v60) * CFrame.Angles(0, 0, v64);
                        local Angles = CFrame.Angles;
                        local v69 = NoiseBetween(v63, v62, 2.7, 6.123233995736766e-17, 1);
                        local v70 = math.clamp(v69, -1, 1);
                        v67 = (v68 * Angles(math.acos(v70), 0, 0) * CFrame.new(0, 0, -v65)).Position or v60;
                    end;

                    local v71 = v67 - v55;

                    if v53 < v59 then
                        v57.Size = Vector2.new(Thickness * v66 * v59, v71.Magnitude + Thickness * v66 * v59 * 0.2);
                        local v72 = 0.5 * (v55 + v67);
                        local Unit = v71.Unit;
                        local Unit2 = Cross(u3.CFrame.Position - v72, Unit).Unit;
                        v57.CFrame = CFrame.fromMatrix(v72, Unit2, Unit);
                        v57.Transparency = 1 - v59;
                    elseif v53 - 1 / (v49 * FadeLength) < v59 then
                        local v73 = (1 - (v59 - (v53 - 1 / (v49 * FadeLength))) * v49 * FadeLength) * (v58 < v52 * PulseSpeed - 0.5 * PulseLength and 1 or -1);
                        v57.Size = Vector2.new(Thickness * v66 * v59, (1 - math.abs(v73)) * v71.Magnitude + Thickness * v66 * v59 * 0.2);
                        local v74 = v55 + (v67 - v55) * (math.max(0, v73) + (1 - math.abs(v73)) * 0.5);
                        local Unit = v71.Unit;
                        local Unit2 = Cross(u3.CFrame.Position - v74, Unit).Unit;
                        v57.CFrame = CFrame.fromMatrix(v74, Unit2, Unit);
                        v57.Transparency = 1 - v59;
                    else
                        v57.Transparency = 1;
                    end;

                    if typeof(Color) == "Color3" then
                        v57.Color3 = Color;
                    else
                        local v75 = (RanNum + v58 - v52 * ColorOffsetSpeed) % 1;
                        local Keypoints = Color.Keypoints;

                        for i2 = 1, #Keypoints - 1 do
                            if Keypoints[i2].Time < v75 and v75 < Keypoints[i2 + 1].Time then
                                v57.Color3 = Keypoints[i2].Value:lerp(Keypoints[i2 + 1].Value, (v75 - Keypoints[i2].Time) / (Keypoints[i2 + 1].Time - Keypoints[i2].Time));
                                break;
                            end;
                        end;
                    end;

                    v54 = v60;
                    v55 = v67;
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

return u23;