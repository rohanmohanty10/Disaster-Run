  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);

return function(p1) -- Line: 10
    -- upvalues: ParticleHandler (copy), AssetHandler (copy), EffectsHandler (copy), RunService (copy), TweenService (copy)
    local u2 = p1 or {};
    local u3 = u2.HSVData or ParticleHandler.GetUnusualHSVData({
        Player = u2.Player or u2.AttackerPlayer,
        Character = u2.Character or u2.Attacker
    });
    local Origin = u2.Origin;
    local u4 = u2.Duration or 4;
    local u5 = u2.Radius or 20;
    local u6 = AssetHandler.GetAbilityData(u2.Character or u2.Player);
    local u7 = AssetHandler.CloneAsset("Particles/DeepDive/Zone", u6);
    u7.Parent = workspace.Effects;
    u7:PivotTo(Origin);
    ParticleHandler.Unusualify(u7, {
        HSVData = u3
    });
    ParticleHandler.EnableAllParticles(u7, true);
    ParticleHandler.EnableAllParticles(u7, true);
    EffectsHandler.CallEffect("FadeBeams", u7, {
        Time = 0.45,
        FadeIn = true
    });
    task.spawn(function() -- Line: 33
        -- upvalues: AssetHandler (ref), u6 (copy), ParticleHandler (ref), u3 (copy), u2 (ref), u5 (copy), Origin (copy), RunService (ref), u4 (copy), TweenService (ref), u7 (copy)
        local u8 = AssetHandler.CloneAsset("Models/The Deep", u6);
        ParticleHandler.Unusualify(u8, {
            HSVData = u3
        });
        u8.Parent = workspace.Effects;
        local u9 = u8.PrimaryPart or u8:FindFirstChild("HumanoidRootPart");

        if not u9 then
            return;
        end;

        local Animator = u8:WaitForChild("AnimationController"):WaitForChild("Animator");
        local Animation = Instance.new("Animation");
        Animation.AnimationId = u2.Animation;
        Animation.Parent = u8;
        local v10 = Animator:LoadAnimation(Animation);
        v10.Looped = true;
        v10:Play();
        local u11 = u5 * 0.8;
        local u12 = math.random() * 3.141592653589793 * 2;
        u9.CFrame = Origin * CFrame.new(math.cos(u12) * u11, -14, math.sin(u12) * u11);
        local u13 = os.clock();
        local u14 = nil;
        u14 = RunService.RenderStepped:Connect(function(p15) -- Line: 61
            -- upvalues: u13 (copy), u4 (ref), u9 (copy), u14 (ref), u12 (ref), TweenService (ref), u11 (copy), Origin (ref), u7 (ref)
            local v16 = os.clock() - u13;

            if u4 <= v16 or not u9.Parent then
                u14:Disconnect();

                return;
            end;

            u12 = u12 + -4.71238898038469 * p15;
            local v17 = 0;

            if v16 < 0.6 then
                v17 = -14 * (1 - TweenService:GetValue(v16 / 0.6, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out));
            elseif u4 - 0.6 < v16 then
                v17 = -14 * TweenService:GetValue((v16 - (u4 - 0.6)) / 0.6, Enum.EasingStyle.Cubic, Enum.EasingDirection.In);
            end;

            local v18 = math.cos(u12) * u11;
            local v19 = math.sin(u12) * u11;
            local v20 = Vector3.new(v18, v17 + 1.5, v19);
            local v21 = -math.sin(u12);
            local v22 = math.cos(u12);
            local v23 = Vector3.new(v21, 0, v22);
            u9.CFrame = CFrame.lookAt(Origin * v20, Origin * (v20 + v23), Origin.UpVector) * CFrame.Angles(0, 3.141592653589793, 0);

            if u7:FindFirstChild("Rotate") then
                u7.Rotate.CFrame = Origin * CFrame.Angles(0, -u12, 0);
            end;
        end);
        task.delay(u4 - 0.6, function() -- Line: 94
            -- upvalues: u8 (copy), TweenService (ref)
            for _, descendant in u8:GetDescendants() do
                if descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture")) then
                    TweenService:Create(descendant, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                        Transparency = 1
                    }):Play();
                end;
            end;
        end);
        task.delay(u4 + 0.25, u8.Destroy, u8);
    end);
    task.delay(u4, function() -- Line: 106
        -- upvalues: ParticleHandler (ref), u7 (copy), EffectsHandler (ref)
        ParticleHandler.EnableVFX(u7, false, { "ParticleEmitter", "Trail" });
        EffectsHandler.CallEffect("FadeBeams", u7, {
            Time = 0.5
        });
        ParticleHandler.DestroyEmit(u7);
    end);
end;