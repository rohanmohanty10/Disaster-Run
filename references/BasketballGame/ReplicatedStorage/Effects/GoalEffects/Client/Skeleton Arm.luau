 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local LocalPlayer = game.Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");
local u1 = { 0.03, 0.14 };
local u2 = { 0.8, 1.1 };
local u3 = { 8.5, 12 };
local u4 = { 1.3, 2.4 };
local u5 = { 1, 7 };

local function ghost(p6, p7, p8, p9, p10, p11) -- Line: 28
    -- upvalues: u4 (copy), u3 (copy), u5 (copy), u2 (copy), RunService (copy)
    local u12 = p11 or 1;
    local u13 = p6:Clone();

    if u12 ~= 1 then
        for _, descendant in ipairs(u13:GetDescendants()) do
            if descendant:IsA("Attachment") then
                descendant.Position = descendant.Position * u12;
            end;
        end;
    end;

    u13.Name = "Ghost";
    u13.Anchored = true;
    u13.CanCollide = false;
    u13.CanQuery = false;
    u13.CanTouch = false;
    u13.CastShadow = false;
    local u14 = u13:FindFirstChildWhichIsA("Trail", true);

    if u14 then
        u14.Enabled = false;
    end;

    local u15 = (p8 - 1) / 3 * 3.141592653589793 * 2 + p9:NextNumber(-0.9, 0.9) * 1;
    local u16 = p9:NextNumber(u4[1], u4[2]) * 3.141592653589793 * 2 * p10;
    local u17 = p9:NextNumber(u3[1], u3[2]) * u12;
    local u18 = u5[2] * p9:NextNumber(0.7, 1.15) * u12;
    local u19 = p9:NextNumber(u2[1], u2[2]) * (1 + (u12 - 1) * 0.15);
    local u20 = p9:NextNumber(0, 1000);
    local v21 = p9:NextNumber(-1, 1);
    local u22 = Vector3.new(v21, 0, p9:NextNumber(-1, 1)) * 1.6 * 1 * u12;
    local u23 = p7 + Vector3.new(0, -1.5 * u12, 0);

    local function posAt(p24) -- Line: 47
        -- upvalues: u15 (copy), u16 (copy), u20 (copy), u5 (ref), u12 (ref), u18 (copy), u17 (copy), u23 (copy), u22 (copy)
        local v25 = u15 + u16 * (p24 + math.noise(u20, p24 * 1.1) * 0.07 * 1);
        local v26 = (u5[1] * u12 + (u18 - u5[1] * u12) * p24 ^ 0.8) * (1 + math.noise(u20 + 11, p24 * 1.4) * 0.28 * 1);
        local v27 = (u17 + 4 * u12) * p24 ^ 0.9 + math.noise(u20 + 23, p24 * 1.5) * 0.7 * 1 * p24 * u12;
        local math_noise_ret = math.noise(u20 + 37, p24 * 0.9);
        local v28 = Vector3.new(math_noise_ret, 0, math.noise(u20 + 53, p24 * 0.9)) * 2.2 * 1 * p24 * u12;
        local v29 = math.cos(v25) * v26;
        local v30 = math.sin(v25) * v26;

        return u23 + u22 * p24 + v28 + Vector3.new(v29, v27, v30);
    end;

    local u31 = nil;

    local function frameAt(p32, p33) -- Line: 56
        -- upvalues: u23 (copy), u31 (ref)
        local Vector3_new_ret = Vector3.new(p32.X - u23.X, 0, p32.Z - u23.Z);
        local v34 = Vector3_new_ret.Magnitude > 0.001 and Vector3_new_ret.Unit or Vector3.new(1, 0, 0);
        local v35;

        if u31 then
            v35 = u31:Lerp(v34, 0.35) or v34;
        else
            v35 = v34;
        end;

        u31 = v35;

        if u31.Magnitude > 0.001 then
            v34 = u31.Unit or v34;
        end;

        local v36 = v34:Dot(p33.Unit);
        local v37 = math.abs(v36) > 0.98 and Vector3.new(0, 1, 0) or v34;

        return CFrame.lookAt(p32, p32 + p33, v37);
    end;

    local function at(p38) -- Line: 64
        -- upvalues: posAt (copy), frameAt (copy)
        local v39 = posAt(p38);
        local v40 = posAt((math.min(1, p38 + 0.01))) - posAt((math.max(0, p38 - 0.01)));
        local v41 = v40.Magnitude < 0.001 and Vector3.new(0, 1, 0) or v40;

        return frameAt(v39, v41), v39, v41;
    end;

    local v42 = posAt(0);
    local v43 = posAt(0.01) - posAt(0);
    u13.CFrame = frameAt(v42, v43.Magnitude < 0.001 and Vector3.new(0, 1, 0) or v43);
    u13.Parent = workspace;

    if u14 then
        u14.Enabled = true;
    end;

    local u44;

    if u14 then
        u44 = u14.Transparency;
    else
        u44 = u14;
    end;

    local function setFade(p45) -- Line: 74
        -- upvalues: u14 (copy), u44 (copy)
        if not u14 then
            return;
        end;

        local v46 = {};

        for _, v in ipairs(u44.Keypoints) do
            table.insert(v46, NumberSequenceKeypoint.new(v.Time, v.Value + (1 - v.Value) * p45, v.Envelope));
        end;

        u14.Transparency = NumberSequence.new(v46);
    end;

    local os_clock_ret = os.clock();
    local u47 = nil;
    local u48 = nil;
    local u49 = nil;
    local u50 = nil;
    u50 = RunService.RenderStepped:Connect(function(p51) -- Line: 85
        -- upvalues: os_clock_ret (copy), u19 (copy), u47 (ref), posAt (copy), frameAt (copy), u48 (ref), u49 (ref), u13 (copy), setFade (copy), u50 (ref), u14 (copy)
        local os_clock_ret2 = os.clock();
        local math_min_ret = math.min(1, (os_clock_ret2 - os_clock_ret) / u19);

        if u47 then
            local math_min_ret2 = math.min(1, (os_clock_ret2 - u47) / 0.4);
            u49 = (u49 or Vector3.new(0, 10, 0)) * math.exp(-p51 * 4);
            u13.CFrame = frameAt(u13.Position + u49 * p51, u49.Magnitude > 0.001 and u49 or Vector3.new(0, 1, 0));
            setFade(math_min_ret2 * math_min_ret2 * (3 - math_min_ret2 * 2));

            if math_min_ret2 >= 1 then
                u50:Disconnect();

                if u14 then
                    u14.Enabled = false;
                end;

                game:GetService("Debris"):AddItem(u13, 0.1);
            end;
        else
            local v52 = math_min_ret * (2 - math_min_ret) * 0.35 + math_min_ret * 0.65;
            local v53 = posAt(v52);
            local v54 = posAt((math.min(1, v52 + 0.01))) - posAt((math.max(0, v52 - 0.01)));
            local v55 = frameAt(v53, v54.Magnitude < 0.001 and Vector3.new(0, 1, 0) or v54);

            if u48 and p51 > 0 then
                u49 = (v53 - u48) / p51;
            end;

            u48 = v53;
            u13.CFrame = v55;

            if math_min_ret >= 1 then
                u47 = os_clock_ret2;
            end;
        end;
    end);
end;

local function releaseGhosts(p56, p57) -- Line: 110
    -- upvalues: u1 (copy), ghost (copy)
    local v58 = script:FindFirstChild("Ghost Trail");

    if not v58 then
        return;
    end;

    local Random_new_ret = Random.new();
    local v59 = Random_new_ret:NextNumber() < 0.5 and -1 or 1;

    for i = 1, 3 do
        task.delay((i - 1) * Random_new_ret:NextNumber(u1[1], u1[2]) * 1.5, ghost, v58, p56, i, Random_new_ret, v59, p57);
        local _ = i;
    end;
end;

return function(p60, p61) -- Line: 120
    -- upvalues: Debris (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), TweenService (copy), VfxManager (copy), releaseGhosts (copy)
    local u62 = script.Model:Clone();
    u62.Parent = Debris;
    u62:PivotTo(p61.CFrame);

    if p61.Preview then
        local Attachment = Instance.new("Attachment");
        Attachment.Parent = workspace.Terrain;
        Attachment.WorldPosition = p61.CFrame.Position;
        SfxManager:playSound({
            Sound = "Skeleton ArmSFX",
            Parent = Attachment
        }).Ended:Once(function() -- Line: 190
            -- upvalues: Attachment (copy)
            Attachment:Destroy();
        end);
        u62:ScaleTo(0.3333333333333333);
    else
        SfxManager:playSound({
            Sound = "Skeleton ArmSFX",
            Parent = workspace
        });
        local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
        local u63 = script.Vignette:Clone();
        u63.Parent = PlayerGui;
        u63.Enabled = true;
        local _ = u63.Vignette;
        local Vignette1 = u63.Vignette1;
        task.delay(1.2166666666666668, function() -- Line: 136
            -- upvalues: u63 (copy)
            u63:Destroy();
        end);
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
        ColorCorrectionEffect.Name = "CCAddon";
        ColorCorrectionEffect.Parent = Lighting;
        ColorCorrectionEffect.Enabled = true;
        task.delay(1.4666666666666668, function() -- Line: 145
            -- upvalues: ColorCorrectionEffect (copy)
            ColorCorrectionEffect:Destroy();
        end);
        Vignette1.ImageColor3 = Color3.fromRGB(39, 255, 145);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        }):Play();
        u63.Vignette2.ImageTransparency = 0;
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.5);
        ColorCorrectionEffect.Brightness = 0.45;
        ColorCorrectionEffect.TintColor = Color3.fromRGB(39, 255, 145);
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.75, Enum.EasingStyle.Sine), {
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            Brightness = 0
        }):Play();
        task.delay(0.7166666666666667, function() -- Line: 166
            -- upvalues: Vignette1 (copy), TweenService (ref), u63 (copy), Lighting (ref), VfxManager (ref), ColorCorrectionEffect (copy)
            Vignette1.ImageColor3 = Color3.fromRGB(39, 255, 145);
            Vignette1.ImageTransparency = 0;
            TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                ImageTransparency = 1
            }):Play();
            TweenService:Create(u63.Vignette2, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                ImageTransparency = 1
            }):Play();
            local BlurEffect2 = Instance.new("BlurEffect", Lighting);
            BlurEffect2.Size = 15;
            TweenService:Create(BlurEffect2, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Size = 0
            }):Play();
            VfxManager.DestroyEffect(BlurEffect2, 0.5);
            ColorCorrectionEffect.Brightness = 0.45;
            ColorCorrectionEffect.TintColor = Color3.fromRGB(39, 255, 145);
            TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.75, Enum.EasingStyle.Sine), {
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
                Brightness = 0
            }):Play();
        end);
    end;

    u62["Skeleton Arm"].AnimationController:LoadAnimation(script.Animation):Play();
    local v64 = p61.Preview and 1.6666666666666667 or 5;
    task.delay(0.03, releaseGhosts, u62.Spawn.Position - Vector3.new(0, 2 * v64, 0), v64);
    VfxManager.Emit(u62.Spawn);
    task.delay(0.7166666666666667, function() -- Line: 205
        -- upvalues: VfxManager (ref), u62 (copy)
        VfxManager.Enable(u62, false);
        VfxManager.Emit(u62.Spawn);

        for _, child in u62["Skeleton Arm"]:GetChildren() do
            if child:IsA("MeshPart") then
                child.Transparency = 1;
            end;
        end;
    end);
end;