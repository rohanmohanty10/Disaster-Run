 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Knit = require(ReplicatedStorage.Packages.Knit);
local _ = game.Players.LocalPlayer;

function EnableVFX(p1: userdata, p2: boolean?)
    for _, v in next, p1:GetDescendants() do
        if v.ClassName == "ParticleEmitter" then
            v.Enabled = p2 or false;
        end;
    end;
end;

function EmitAll(p3: table)
    local v4 = 0;

    for _, v in next, p3 do
        if v.ClassName == "ParticleEmitter" then
            if v:GetAttribute("EmitDelay") then
                task.delay(v:GetAttribute("EmitDelay"), function() -- Line: 27
                    -- upvalues: v (copy)
                    v:Emit(v:GetAttribute("EmitCount"));
                end);
            else
                v:Emit(v:GetAttribute("EmitCount"));
            end;

            local v5 = (v:GetAttribute("EmitDelay") or 0) + v.Lifetime.Max;
            v4 = math.max(v4, v5);
        end;
    end;

    return v4;
end;

local function Destroy_Effect(u6: userdata, p7: number) -- Line: 41
    task.delay(p7, function() -- Line: 42
        -- upvalues: u6 (copy)
        u6:Destroy();
    end);
end;

return function(p8, p9) -- Line: 47
    -- upvalues: VfxManager (copy), TweenService (copy), SfxManager (copy), Essentials (copy), RunService (copy), Knit (copy)
    local Player = p9.Player;

    if not (Player or (p9.Locker or p9.Preview)) then
        warn("No plr for Energy beam");

        return;
    end;

    local u10 = script.EnergyBeam:Clone();
    u10.Parent = workspace.Debris;
    u10:PivotTo(p9.CFrame);

    if p9.Preview then
        for _, descendant in u10:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                local v11 = descendant;
                local v12 = {};

                for _, v in descendant.Size.Keypoints do
                    local v13;

                    if v.Envelope then
                        v13 = v.Envelope / 10 or nil;
                    else
                        v13 = nil;
                    end;

                    if v13 ~= v13 then
                        v13 = nil;
                    end;

                    table.insert(v12, NumberSequenceKeypoint.new(v.Time, v.Value / 10, v13));
                end;

                v11.Size = NumberSequence.new(v12);
                v11.Speed = NumberRange.new(v11.Speed.Min / 10, v11.Speed.Max / 10);
            elseif descendant:IsA("Attachment") then
                descendant.Position = descendant.Position / 10;

                if descendant.Position ~= descendant.Position then
                    descendant.Position = Vector3.new(0, 0, 0);
                end;
            elseif descendant:IsA("BasePart") then
                descendant.Position = p9.CFrame.Position + (descendant.Position - p9.CFrame.Position) / 10;

                if descendant.Position ~= descendant.Position then
                    descendant.Position = p9.CFrame.Position;
                end;

                descendant.Size = descendant.Size / 10;

                if descendant.Size ~= descendant.Size then
                    descendant.Size = Vector3.new(0, 0, 0);
                end;
            elseif descendant:IsA("Beam") then
                descendant.Width0 = descendant.Width0 / 10;
                descendant.Width1 = descendant.Width1 / 10;
            end;
        end;
    end;

    task.delay(4, function() -- Line: 42
        -- upvalues: u10 (copy)
        u10:Destroy();
    end);
    VfxManager.Enable(u10.Enables.PillarBeam.Start, true);

    for _, child in u10.Enables.PillarBeam.Start.SSJBeams:GetChildren() do
        if child:IsA("Beam") then
            local Width0 = child.Width0;
            local Width1 = child.Width1;
            child.Width0 = 0;
            child.Width1 = 0;
            TweenService:Create(child, TweenInfo.new(0.125, Enum.EasingStyle.Linear), {
                Width0 = Width0,
                Width1 = Width1
            }):Play();
        end;
    end;

    local v14 = u10.Enables.PillarBeam.Start.CFrame * CFrame.new(85 / (p9.Preview and 10 or 1), 0, 0);
    TweenService:Create(u10.Enables.PillarBeam.End, TweenInfo.new(0.125, Enum.EasingStyle.Linear), {
        CFrame = v14
    }):Play();
    task.wait(0.125);
    local v15, v16, u17;

    if p9.Locker or p9.Preview then
        v15 = nil;
        v16 = nil;
        u17 = nil;
    else
        local Character = Player.Character;
        v16 = Character:FindFirstChild("HumanoidRootPart");
        SfxManager:playSound({
            Sound = "Energy BeamAura",
            Parent = v16
        });
        u17 = script.AuraModel:Clone();
        u17:PivotTo(v16.CFrame);
        local Highlight = Instance.new("Highlight");
        Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
        Highlight.OutlineColor = Color3.new(1, 1, 1);
        Highlight.OutlineTransparency = 0;
        Highlight.FillColor = Color3.new(1, 0, 0);
        Highlight.FillTransparency = 0.5;
        Highlight.Parent = u17;
        u17.Parent = workspace;
        Essentials:Weld(u17.PrimaryPart, v16);
        VfxManager.Enable(u17, true);
        task.delay(3.5, function() -- Line: 42
            -- upvalues: u17 (copy)
            u17:Destroy();
        end);
        v15 = Character:FindFirstChild("Highlight");
        v15.OutlineColor = Color3.fromRGB(255, 255, 255);
        local game_Lighting = game.Lighting;
        local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
        local DepthOfField = game_Lighting.DepthOfField;
        TweenService:Create(DepthOfField, TweenInfo.new(0.355, Enum.EasingStyle.Quint), {
            FarIntensity = 1
        }):Play();
        local ColorCorrection = game_Lighting.ColorCorrection;
        local v18 = TweenService:Create(ColorCorrection, TweenInfo.new(0.067, Enum.EasingStyle.Linear), {
            Brightness = 0.2
        });
        v18:Play();
        v18.Completed:Connect(function() -- Line: 172
            -- upvalues: TweenService (ref), ColorCorrection (copy), DepthOfField (copy), Color3_fromRGB_ret (copy)
            TweenService:Create(ColorCorrection, TweenInfo.new(0.455, Enum.EasingStyle.Quint), {
                Brightness = 0.1,
                Saturation = 0.5,
                TintColor = Color3.fromRGB(169, 196, 255)
            }):Play();
            task.wait(1.2);
            TweenService:Create(DepthOfField, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
                FarIntensity = 0.1
            }):Play();
            TweenService:Create(ColorCorrection, TweenInfo.new(0.567, Enum.EasingStyle.Linear), {
                Brightness = -0.015,
                Saturation = 0.3,
                TintColor = Color3_fromRGB_ret
            }):Play();
        end);
        local Bloom = game_Lighting.Bloom;
        Bloom.Intensity = 2;
        Bloom.Threshold = 0.5;
        TweenService:Create(Bloom, TweenInfo.new(2.5, Enum.EasingStyle.Back), {
            Intensity = 0.2,
            Threshold = 2.35
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", game_Lighting);
        BlurEffect.Size = 12;
        TweenService:Create(BlurEffect, TweenInfo.new(0.855, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        task.delay(0.855, function() -- Line: 42
            -- upvalues: BlurEffect (copy)
            BlurEffect:Destroy();
        end);
    end;

    for _, child in u10.Enables.WindBeamsAndMeshes.WindBeams:GetChildren() do
        if child:IsA("Beam") then
            local Width0 = child.Width0;
            local Width1 = child.Width1;
            child.Width0 = 0;
            child.Width1 = 0;
            TweenService:Create(child, TweenInfo.new(0.125, Enum.EasingStyle.Linear), {
                Width0 = Width0,
                Width1 = Width1
            }):Play();
        end;
    end;

    VfxManager.Enable(u10.Enables, true);
    local u19 = 0;
    local os_clock_ret = os.clock();
    u10.Enables.WindBeamsAndMeshes.Meshes.Twirl.Transparency = 0;
    u10.Enables.WindBeamsAndMeshes.Meshes.Twirl2.Transparency = 0;
    u10.Enables.WindBeamsAndMeshes.Meshes.TwirlingBlack.Transparency = 0.5;
    local u20 = nil;
    u20 = RunService.Heartbeat:Connect(function() -- Line: 212
        -- upvalues: u10 (copy), u20 (ref), u19 (ref), os_clock_ret (copy), TweenService (ref)
        if not u10:FindFirstChild("Enables") then
            u20:Disconnect();

            return;
        end;

        u19 = os.clock() - os_clock_ret;
        local Twirl = u10.Enables.WindBeamsAndMeshes.Meshes.Twirl;
        Twirl.CFrame = Twirl.CFrame * CFrame.Angles(0, 0.17453292519943295, 0);
        local Twirl2 = u10.Enables.WindBeamsAndMeshes.Meshes.Twirl2;
        Twirl2.CFrame = Twirl2.CFrame * CFrame.Angles(0, 0.17453292519943295, 0);
        local TwirlingBlack = u10.Enables.WindBeamsAndMeshes.Meshes.TwirlingBlack;
        TwirlingBlack.CFrame = TwirlingBlack.CFrame * CFrame.Angles(0, 0.17453292519943295, 0);

        if u19 >= 1.5 then
            u20:Disconnect();

            for _, child in pairs(u10.Enables.WindBeamsAndMeshes.Meshes:GetChildren()) do
                if child:IsA("MeshPart") then
                    TweenService:Create(child, TweenInfo.new(0.05, Enum.EasingStyle.Linear), {
                        Transparency = 1
                    }):Play();
                end;
            end;
        end;
    end);
    task.wait(1.5);
    VfxManager.Emit(u10.Emits);
    VfxManager.Enable(u10.Enables, false);

    for _, child in u10.Enables.PillarBeam.Start.SSJBeams:GetChildren() do
        if child:IsA("Beam") then
            TweenService:Create(child, TweenInfo.new(0.455, Enum.EasingStyle.Linear), {
                Width0 = 0,
                Width1 = 0
            }):Play();
        end;
    end;

    if not (p9.Preview or p9.Locker) then
        if v15 then
            v15.OutlineColor = Color3.fromRGB(0, 0, 0);
        end;

        local u21 = script.AuraEmit:Clone();
        u21.CFrame = v16.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0);
        u21.Parent = workspace;
        task.delay(3, function() -- Line: 42
            -- upvalues: u21 (copy)
            u21:Destroy();
        end);
        VfxManager.Emit(u21);
        VfxManager.Enable(u17, false);
    end;

    Knit.GetController("LightingController"):ResetLighting(0.5);
end;