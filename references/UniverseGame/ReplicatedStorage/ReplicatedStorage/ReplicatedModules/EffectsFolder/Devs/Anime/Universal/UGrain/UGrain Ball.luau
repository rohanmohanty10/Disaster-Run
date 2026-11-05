  

 

local TweenService = game:GetService("TweenService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
local u1 = Random.new();
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local _ = Players.LocalPlayer;

return function(p2) -- Line: 19
    -- upvalues: AssetHandler (copy), u1 (copy), RunService (copy), TweenService (copy), EffectsHandler (copy)
    local v3 = p2 or {};
    local Character = v3.Character;
    local u4 = v3.Duration or 0.9333333333333333;
    local _ = Character.HumanoidRootPart;
    local v5 = AssetHandler.GetAbilityData(Character);
    local u6 = AssetHandler.CloneAsset("Models/Ball", v5);
    u6.Parent = workspace.Effects;
    local u7 = os.clock();
    local u8 = os.clock();
    local u9 = u6:IsA("BasePart") and u6 and u6 or u6:FindFirstChildWhichIsA("BasePart", true);
    local u10 = {};

    for _, descendant in u6:GetDescendants() do
        if descendant:IsA("Bone") then
            u10[descendant] = {
                Speed = Vector3.new(40, 40, 40),
                Original = descendant.Transform,
                TimeOffset = math.random() * 3.141592653589793 * 2,
                Amplitude = Vector3.new(1, 1, 1) * u1:NextNumber(1, 1.2)
            };
        end;
    end;

    local function WaveOffset(p11, p12, p13, p14) -- Line: 50
        return math.sin(p11 * p13 + p12) * p14;
    end;

    local function GetScale() -- Line: 54
        -- upvalues: u9 (copy)
        return u9 and math.clamp(u9.Size.Magnitude / 20, 0.5, 2) or 1;
    end;

    local v15 = Character["Right Arm"].CFrame * CFrame.new(0, -2.25, 0);
    local u16 = {};
    local u17 = false;

    for i = 1, 7 do
        local v18 = AssetHandler.CloneAsset("Particles/Awaken/Orb", v5);
        local v19 = i / 10 * 3.141592653589793 * 2;
        local v20 = CFrame.Angles(u1:NextNumber(-3.141592653589793, 3.141592653589793), u1:NextNumber(-3.141592653589793, 3.141592653589793), u1:NextNumber(-3.141592653589793, 3.141592653589793));
        v18.CFrame = v15 * v20 * CFrame.new(math.cos(v19) * 6, 0, math.sin(v19) * 6);
        v18.Parent = workspace.Effects;
        u16[i] = {
            Part = v18,
            Angle = v19,
            Orbit = v20
        };
    end;

    local u21 = nil;
    u21 = RunService.RenderStepped:Connect(function(p22) -- Line: 78
        -- upvalues: Character (copy), u7 (copy), u4 (copy), u21 (ref), u6 (copy), u16 (copy), u17 (ref), u10 (copy), u9 (copy), TweenService (ref), u8 (ref), u1 (ref), EffectsHandler (ref)
        if not Character or (not Character.Parent or u4 <= os.clock() - u7) then
            u21:Disconnect();
            u21 = nil;
            u6:Destroy();

            for _, v in u16 do
                v.Part:Destroy();
            end;

            return;
        end;

        local v23 = Character["Right Arm"].CFrame * CFrame.new(0, -2.25, 0);
        u6:PivotTo(v23);

        if not u17 then
            for i, v in u10 do
                local v24 = tick();
                local TimeOffset = v.TimeOffset;
                local X = v.Speed.X;
                local v25 = v.Amplitude.X * (u9 and math.clamp(u9.Size.Magnitude / 20, 0.5, 2) or 1);
                local v26 = math.sin(v24 * X + TimeOffset) * v25;
                local v27 = tick();
                local v28 = v.TimeOffset + 1;
                local Y = v.Speed.Y;
                local v29 = v.Amplitude.Y * (u9 and math.clamp(u9.Size.Magnitude / 20, 0.5, 2) or 1);
                local v30 = math.sin(v27 * Y + v28) * v29;
                local v31 = tick();
                local v32 = v.TimeOffset + 2;
                local Z = v.Speed.Z;
                local v33 = v.Amplitude.Z * (u9 and math.clamp(u9.Size.Magnitude / 20, 0.5, 2) or 1);
                local v34 = math.sin(v31 * Z + v32) * v33;
                local v35 = Vector3.new(v26, v30, v34);
                i.Transform = v.Original * CFrame.new(v35);
            end;
        end;

        if not u17 and os.clock() - u7 >= 0.92 * u4 then
            u17 = true;
            task.spawn(function() -- Line: 108
                -- upvalues: u4 (ref), u10 (ref), u6 (ref), TweenService (ref)
                local v36 = u4 * 0.04;
                local v37 = tick();

                while tick() - v37 < v36 do
                    local v38 = (tick() - v37) / v36;

                    for i, v in u10 do
                        local v39 = math.noise(tick(), 0, 0);
                        local v40 = math.noise(0, tick(), 0);
                        local v41 = Vector3.new(v39, v40, math.noise(0, 0, tick()));
                        i.Transform = v.Original * CFrame.new(v41.Unit * 22 * (1 - v38));
                    end;

                    task.wait();
                end;

                for _, descendant in u6:GetDescendants() do
                    if descendant:IsA("BasePart") then
                        TweenService:Create(descendant, TweenInfo.new(0.08, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                            Size = descendant.Size * 10
                        }):Play();
                    end;
                end;

                if u6:IsA("BasePart") then
                    TweenService:Create(u6, TweenInfo.new(0.08, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                        Size = u6.Size * 10
                    }):Play();
                end;
            end);
        end;

        local v42 = (os.clock() - u7) / u4;
        local v43 = math.clamp(v42, 0, 1);
        local v44 = math.lerp(6, 0, v43);
        local v45 = math.lerp(0.5, 5, v43);

        for _, v in u16 do
            v.Angle = v.Angle + v45 * 3.141592653589793 * 2 * p22;
            v.Part.CFrame = v23 * v.Orbit * CFrame.new(math.cos(v.Angle) * v44, 0, math.sin(v.Angle) * v44);
        end;

        if os.clock() - u8 > 0.04 then
            u8 = os.clock();
            local v46 = Vector3.new(1, 1, 1) * u1:NextNumber(2.4, 3);
            EffectsHandler.CallEffect("Bubble Distortion", {
                Time = 0.08,
                Origin = v23,
                StartSize = v46,
                EndSize = v46 * u1:NextNumber(1.15, 1.5),
                Transparency = u1:NextNumber(5, 10)
            });
        end;
    end);
end;