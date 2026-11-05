  

 

game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
local SoundGroups = require(ReplicatedStorage.ReplicatedModules:WaitForChild("SoundGroups"));
local ChaosEmerald = PathShortcuts.ClientAssets["Soul Survivor"].Metallix.ChaosEmerald;
local u1 = Random.new();
local u2 = {
    Color3.fromRGB(248, 35, 0),
    Color3.fromRGB(20, 196, 249),
    Color3.fromRGB(3, 0, 248),
    Color3.fromRGB(0, 211, 34),
    Color3.fromRGB(248, 233, 0),
    Color3.fromRGB(185, 185, 185),
    Color3.fromRGB(248, 0, 236)
};

return function(u3) -- Line: 27
    -- upvalues: Trove (copy), u2 (copy), ChaosEmerald (copy), u1 (copy), ParticleHandler (copy), SoundGroups (copy), TweenService (copy), EffectsHandler (copy)
    local u4 = u3.Character and u3.Character:FindFirstChild("HumanoidRootPart");

    if not u4 or (u3.Character:GetAttribute("_EmeraldHook") or not u3.Character:GetAttribute("Posing")) then
        return;
    end;

    u3.Character:SetAttribute("_EmeraldHook", true);
    local u5 = Trove.new();
    u5:AttachToInstance(u3.Character);
    local v6 = u3.Character:GetAttribute("HyperForm");

    for _, v in u2 do
        if not u3.Character:GetAttribute("Posing") then
            u5:Destroy();
            break;
        end;

        local u7 = false;
        local Model = Instance.new("Model");
        Model.Parent = workspace.Effects;
        local u8 = ChaosEmerald:Clone();
        u8.Parent = Model;
        local v9;

        if v6 then
            Model:ScaleTo(1.825);
            v9 = 1.5;
        else
            v9 = 1;
        end;

        u8.SurfaceAppearance.Color = v;
        u8.Light.SpotLight.Color = v;
        u8.Trail.Color = ColorSequence.new(v:Lerp(Color3.new(0, 0, 0), 0.3));
        u8.Star.Color = ColorSequence.new(v:Lerp(Color3.new(0, 0, 0), 0.1));
        local v10 = ColorSequence.new(v:Lerp(Color3.new(1, 1, 1), 0.25));

        for _, child in u8.Middle:GetChildren() do
            child.Color = v10;
        end;

        u8.Specs.Color = u8.Star.Color;
        u8.CFrame = u4.CFrame * CFrame.new((2.75 + u1:NextNumber(0, 3.25)) * (u1:NextInteger(1, 2) == 1 and -1 or 1) * v9, u1:NextNumber(-3.25, 3.25) + (v6 and 2 or 0), u1:NextNumber(-5.75, 5.75) * v9);
        local u11 = ParticleHandler.AttachTo(u8, {
            Part = u4,
            Offset = u8.CFrame:ToObjectSpace(u4.CFrame)
        });
        local Position = u4.Position;
        local SFX = u8.SFX;
        SoundGroups:AssignSoundTag(SFX);
        SFX.Volume = u3.Volume or SFX.Volume;
        SFX:Play();
        u8.Star:Emit(3);
        u8.Trail.Enabled = false;
        u8.Star.Enabled = true;
        local u12 = TweenService:Create(u11, TweenInfo.new(u1:NextNumber(1, 2.5), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            C1 = CFrame.new(0, u1:NextNumber(1, 2.25) * (u1:NextInteger(1, 2) == 1 and -1 or 1), 0)
        });
        local u13 = TweenService:Create(u11, TweenInfo.new(u12.TweenInfo.Time, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            C1 = CFrame.identity
        });
        task.spawn(function() -- Line: 89
            -- upvalues: EffectsHandler (ref), u1 (ref), u3 (copy), u12 (copy), u7 (ref), u13 (copy)
            EffectsHandler.Wait(u1:NextNumber(0, 0.3));

            if not u3.Character:GetAttribute("Posing") then
                return;
            end;

            u12:Play();
            u12.Completed:Connect(function() -- Line: 93
                -- upvalues: u7 (ref), u13 (ref)
                if u7 then
                    return;
                end;

                u13:Play();
            end);
            u13.Completed:Connect(function() -- Line: 97
                -- upvalues: u7 (ref), u12 (ref)
                if u7 then
                    return;
                end;

                u12:Play();
            end);
        end);
        u5:Add(function() -- Line: 103
            -- upvalues: u3 (copy), u11 (copy), Model (copy), u4 (copy), Position (copy), u8 (copy), u7 (ref), u12 (copy), u13 (copy), TweenService (ref), u1 (ref), ParticleHandler (ref), EffectsHandler (ref)
            if not (u3.Character and u11) then
                Model:Destroy();

                return;
            end;

            local LookVector = CFrame.lookAt(u4 and u4.Position or Position, u8.Position).LookVector;
            u7 = true;
            u12:Cancel();
            u13:Cancel();
            u11:Destroy();
            u8.Anchored = true;
            local v14 = TweenService:Create(u8, TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                CFrame = u8.CFrame + LookVector * u1:NextNumber(60, 125)
            });
            v14:Play();
            v14.Completed:Once(function() -- Line: 120
                -- upvalues: u8 (ref), ParticleHandler (ref), EffectsHandler (ref), Model (ref)
                if u8 then
                    u8.Transparency = 1;
                    ParticleHandler.EnableAllParticles(u8, false);
                    u8.Light.SpotLight.Enabled = false;
                    EffectsHandler.Wait(1);
                    Model:Destroy();
                end;
            end);
        end);
        task.wait(u1:NextNumber(0, 0.2));
    end;

    u5:Connect(u3.Character:GetAttributeChangedSignal("Posing"), function() -- Line: 135
        -- upvalues: u3 (copy), u5 (copy)
        if not u3.Character:GetAttribute("Posing") then
            u3.Character:SetAttribute("_EmeraldHook", nil);
            u5:Destroy();
        end;
    end);

    if not u3.Character:GetAttributeChangedSignal("Posing") then
        u3.Character:SetAttribute("_EmeraldHook", nil);
        u5:Destroy();
    end;
end;