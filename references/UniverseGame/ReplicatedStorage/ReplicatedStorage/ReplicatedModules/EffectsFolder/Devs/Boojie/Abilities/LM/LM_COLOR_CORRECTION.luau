  

 

local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
local Players = game:GetService("Players");

local function Lerp(p1, p2, p3) -- Line: 6
    if typeof(p1) == "Color3" then
        return p1:Lerp(p2, p3);
    end;

    return p1 + (p2 - p1) * p3;
end;

local function GetColorValue(p4) -- Line: 14
    return math.max(p4.R, p4.G, p4.B);
end;

local function IsDarkColor(p5, p6) -- Line: 18
    return (p6 or 0.18) >= math.max(p5.R, p5.G, p5.B);
end;

local function ClampDarkTint(p7, p8) -- Line: 23
    local v9 = p8 or 0.35;
    local v10 = math.max(p7.R, p7.G, p7.B);

    if v10 <= 0 then
        return Color3.new(v9, v9, v9);
    end;

    if v9 <= v10 then
        return p7;
    end;

    local v11 = v9 / v10;

    return Color3.new(math.clamp(p7.R * v11, 0, 1), math.clamp(p7.G * v11, 0, 1), (math.clamp(p7.B * v11, 0, 1)));
end;

return function(p12) -- Line: 45
    -- upvalues: Players (copy), RunService (copy), ClampDarkTint (copy), Lighting (copy), TweenService (copy)
    local LocalPlayer = Players.LocalPlayer;

    if LocalPlayer then
        LocalPlayer = LocalPlayer.Character;
    end;

    local u13;

    if LocalPlayer then
        u13 = LocalPlayer:FindFirstChild("HumanoidRootPart");
    else
        u13 = LocalPlayer;
    end;

    if RunService:IsRunning() then
        if not LocalPlayer then
            return;
        end;

        if not u13 then
            return;
        end;
    end;

    local v14 = p12 or {};
    local Origin = v14.Origin;
    local u15 = v14.StartDistance or 32;
    local u16 = v14.EndDistance or 48;
    local u17 = v14.TweenTime or 1;
    local v18 = v14.Time or 5;
    local v19 = v14.EndInfo and TweenInfo.new(unpack(v14.EndInfo)) or TweenInfo.new(1);
    local v20 = v14.DarkTintMinimum or 0.35;
    local v21 = v14.DarkTintThreshold or 0.18;
    local v22 = v14.DarkEffectMultiplier or 0.35;
    local u23 = {
        Brightness = v14.Brightness or 0,
        Contrast = v14.Contrast or 0,
        Saturation = v14.Saturation or 0,
        TintColor = v14.TintColor or Color3.fromRGB(255, 255, 255)
    };
    local TintColor = u23.TintColor;

    if (v21 or 0.18) >= math.max(TintColor.R, TintColor.G, TintColor.B) then
        u23.TintColor = ClampDarkTint(u23.TintColor, v20);
        u23.Brightness = u23.Brightness * v22;
        u23.Contrast = u23.Contrast * v22;
        u23.Saturation = u23.Saturation * v22;
    end;

    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Brightness = 0;
    ColorCorrectionEffect.Contrast = 0;
    ColorCorrectionEffect.Saturation = 0;
    ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255);
    ColorCorrectionEffect.Parent = Lighting;

    local function GetOrigin() -- Line: 96
        -- upvalues: Origin (copy)
        if typeof(Origin) == "Instance" and (Origin:GetAttribute("Effect") ~= false and Origin:IsDescendantOf(game)) then
            if Origin:IsA("BasePart") then
                return Origin.Position;
            end;

            if Origin:IsA("Attachment") then
                return Origin.WorldPosition;
            end;
        end;

        if typeof(Origin) == "Vector3" then
            return Origin;
        end;
    end;

    local function GetPosition() -- Line: 110
        -- upvalues: u13 (copy)
        if u13 then
            return u13.Position;
        end;

        local CurrentCamera = workspace.CurrentCamera;

        if CurrentCamera then
            return CurrentCamera.CFrame.Position;
        end;
    end;

    local function IsValid() -- Line: 121
        -- upvalues: GetOrigin (copy), u13 (copy)
        local v24;

        if GetOrigin() == nil then
            v24 = false;
        else
            local v25;

            if u13 then
                v25 = u13.Position;
            else
                local CurrentCamera = workspace.CurrentCamera;

                if CurrentCamera then
                    v25 = CurrentCamera.CFrame.Position;
                else
                    v25 = nil;
                end;
            end;

            v24 = v25 ~= nil;
        end;

        return v24;
    end;

    local u26 = {
        Brightness = 0,
        Contrast = 0,
        Saturation = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    };
    local u27 = os.clock();
    local v38 = RunService.RenderStepped:Connect(function() -- Line: 135
        -- upvalues: GetOrigin (copy), u13 (copy), u27 (copy), u17 (copy), u15 (copy), u16 (copy), u26 (copy), u23 (copy), ColorCorrectionEffect (copy)
        local v28;

        if GetOrigin() == nil then
            v28 = false;
        else
            local v29;

            if u13 then
                v29 = u13.Position;
            else
                local CurrentCamera = workspace.CurrentCamera;

                if CurrentCamera then
                    v29 = CurrentCamera.CFrame.Position;
                else
                    v29 = nil;
                end;
            end;

            v28 = v29 ~= nil;
        end;

        if not v28 then
            return;
        end;

        local v30 = (os.clock() - u27) / u17;
        local v31 = math.clamp(v30, 0, 1);
        local v32 = GetOrigin();
        local v33;

        if u13 then
            v33 = u13.Position;
        else
            local CurrentCamera = workspace.CurrentCamera;

            if CurrentCamera then
                v33 = CurrentCamera.CFrame.Position;
            else
                v33 = nil;
            end;
        end;

        local v34 = v31 * (1 - math.clamp(((v32 - v33).Magnitude - u15) / (u16 - u15), 0, 1));
        local v35 = math.clamp(v34, 0, 1);

        for i, v in pairs(u26) do
            local v36 = u23[i];

            if v36 ~= nil then
                local v37;

                if typeof(v) == "Color3" then
                    v37 = v:Lerp(v36, v35);
                else
                    v37 = v + (v36 - v) * v35;
                end;

                ColorCorrectionEffect[i] = v37;
            end;
        end;
    end);

    while os.clock() - u27 < v18 do
        local v39;

        if GetOrigin() == nil then
            v39 = false;
        else
            local v40;

            if u13 then
                v40 = u13.Position;
            else
                local CurrentCamera = workspace.CurrentCamera;

                if CurrentCamera then
                    v40 = CurrentCamera.CFrame.Position;
                else
                    v40 = nil;
                end;
            end;

            v39 = v40 ~= nil;
        end;

        if not v39 then
            break;
        end;

        task.wait();
    end;

    if v38 then
        v38:Disconnect();
    end;

    TweenService:Create(ColorCorrectionEffect, v19, u26):Play();
    task.delay(v19.Time + 0.1, function() -- Line: 168
        -- upvalues: ColorCorrectionEffect (copy)
        if ColorCorrectionEffect then
            ColorCorrectionEffect:Destroy();
        end;
    end);
end;