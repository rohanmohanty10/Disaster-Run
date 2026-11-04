 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Knit = require(ReplicatedStorage.Packages.Knit);
local _ = game.Players.LocalPlayer;
local u1 = nil;

function EnableVFX(p2: userdata, p3: boolean?)
    for _, v in next, p2:GetDescendants() do
        if v.ClassName == "ParticleEmitter" then
            v.Enabled = p3 or false;
        end;
    end;
end;

function EmitAll(p4: table)
    local v5 = 0;

    for _, v in next, p4 do
        if v.ClassName == "ParticleEmitter" then
            if v:GetAttribute("EmitDelay") then
                task.delay(v:GetAttribute("EmitDelay"), function() -- Line: 29
                    -- upvalues: v (copy)
                    v:Emit(v:GetAttribute("EmitCount"));
                end);
            else
                v:Emit(v:GetAttribute("EmitCount"));
            end;

            local v6 = (v:GetAttribute("EmitDelay") or 0) + v.Lifetime.Max;
            v5 = math.max(v5, v6);
        end;
    end;

    return v5;
end;

local function Destroy_Effect(u7: userdata, p8: number) -- Line: 43
    task.delay(p8, function() -- Line: 44
        -- upvalues: u7 (copy)
        u7:Destroy();
    end);
end;

return function(p9, p10) -- Line: 49
    -- upvalues: u1 (ref), Knit (copy), TweenService (copy), VfxManager (copy)
    u1 = Knit.GetController("CameraController");
    local Player = p10.Player;

    if not (Player or (p10.Locker or p10.Preview)) then
        warn("No plr for Energy beam");

        return;
    end;

    p10.CFrame = p10.CFrame * CFrame.Angles(0, -1.5707963267948966, 0);

    if p10.Preview then
        p10.CFrame = p10.CFrame * CFrame.Angles(0, -1.5707963267948966, 0);
    end;

    local u11 = script.SLOT:Clone();
    local PrimaryPart = u11.PrimaryPart;
    u11.Parent = workspace;
    u11:PivotTo(p10.CFrame * CFrame.new(0, 60, 0));
    task.delay(6.5, function() -- Line: 44
        -- upvalues: u11 (copy)
        u11:Destroy();
    end);

    if p10.Preview then
        for _, descendant in u11:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                local v12 = descendant;
                local v13 = {};

                for _, v in descendant.Size.Keypoints do
                    local v14;

                    if v.Envelope then
                        v14 = v.Envelope / 5 or nil;
                    else
                        v14 = nil;
                    end;

                    if v14 ~= v14 then
                        v14 = nil;
                    end;

                    table.insert(v13, NumberSequenceKeypoint.new(v.Time, v.Value / 5, v14));
                end;

                v12.Size = NumberSequence.new(v13);
                v12.Speed = NumberRange.new(v12.Speed.Min / 5, v12.Speed.Max / 5);
            elseif descendant:IsA("Attachment") then
                descendant.Position = descendant.Position / 5;

                if descendant.Position ~= descendant.Position then
                    descendant.Position = Vector3.new(0, 0, 0);
                end;
            elseif descendant:IsA("BasePart") then
                descendant.Position = p10.CFrame.Position + (descendant.Position - p10.CFrame.Position) / 5;

                if descendant.Position ~= descendant.Position then
                    descendant.Position = p10.CFrame.Position;
                end;

                descendant.Size = descendant.Size / 5;

                if descendant.Size ~= descendant.Size then
                    descendant.Size = Vector3.new(0, 0, 0);
                end;
            elseif descendant:IsA("Beam") then
                descendant.Width0 = descendant.Width0 / 5;
                descendant.Width1 = descendant.Width1 / 5;
            end;
        end;
    end;

    local _ = PrimaryPart.CFrame * CFrame.new(0, -67, 0);
    TweenService:Create(PrimaryPart, TweenInfo.new(0.155, Enum.EasingStyle.Linear), {
        CFrame = p10.CFrame
    }):Play();
    task.wait(0.155);
    local _ = p10.Preview;
    local u15 = script.FXJackpot:Clone();
    u15.Parent = workspace;
    u15:PivotTo(p10.CFrame);
    task.delay(6.5, function() -- Line: 44
        -- upvalues: u15 (copy)
        u15:Destroy();
    end);

    if p10.Preview then
        for _, descendant in u15:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                local v16 = descendant;
                local v17 = {};

                for _, v in descendant.Size.Keypoints do
                    local v18;

                    if v.Envelope then
                        v18 = v.Envelope / 5 or nil;
                    else
                        v18 = nil;
                    end;

                    if v18 ~= v18 then
                        v18 = nil;
                    end;

                    table.insert(v17, NumberSequenceKeypoint.new(v.Time, v.Value / 5, v18));
                end;

                v16.Size = NumberSequence.new(v17);
                v16.Speed = NumberRange.new(v16.Speed.Min / 5, v16.Speed.Max / 5);
            elseif descendant:IsA("Attachment") then
                descendant.Position = descendant.Position / 5;

                if descendant.Position ~= descendant.Position then
                    descendant.Position = Vector3.new(0, 0, 0);
                end;
            elseif descendant:IsA("BasePart") then
                descendant.Position = p10.CFrame.Position + (descendant.Position - p10.CFrame.Position) / 5;

                if descendant.Position ~= descendant.Position then
                    descendant.Position = p10.CFrame.Position;
                end;

                descendant.Size = descendant.Size / 5;

                if descendant.Size ~= descendant.Size then
                    descendant.Size = Vector3.new(0, 0, 0);
                end;
            elseif descendant:IsA("Beam") then
                descendant.Width0 = descendant.Width0 / 5;
                descendant.Width1 = descendant.Width1 / 5;
            end;
        end;
    end;

    for _, child in u11:GetChildren() do
        if child:IsA("MeshPart") then
            TweenService:Create(child, TweenInfo.new(0.155, Enum.EasingStyle.Bounce), {
                Size = child.Size * 1.05
            }):Play();
        end;
    end;

    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.OutlineColor = Color3.new(1, 1, 1);
    Highlight.OutlineTransparency = 0;
    Highlight.FillColor = Color3.new(0, 0, 0);
    Highlight.FillTransparency = 0;
    Highlight.Parent = u11;
    TweenService:Create(Highlight, TweenInfo.new(0.075, Enum.EasingStyle.Sine), {
        FillTransparency = 0.5,
        FillColor = Color3.fromRGB(82, 255, 111)
    }):Play();
    task.delay(0.125, function() -- Line: 192
        -- upvalues: TweenService (ref), Highlight (copy)
        TweenService:Create(Highlight, TweenInfo.new(2.5, Enum.EasingStyle.Linear), {
            FillTransparency = 1
        }):Play();
    end);
    VfxManager.Emit(u15.LandingFX);
    VfxManager.Emit(u15.AppearEffect);
    VfxManager.Enable(u11.EnablingDollars, true);

    if Player then
        local _ = Player.Team.Name == "Home";
    end;

    task.wait(0.317);
    VfxManager.Emit(u11["Plane.005"].FirstEmit);
    local game_Lighting = game.Lighting;
    local u19 = game_Lighting.DepthOfField:Clone();
    u19.Name = "OriginalDepthOfField";
    local u20 = game_Lighting.Atmosphere:Clone();
    u20.Name = "OriginalAtmo";
    local Atmosphere = game_Lighting.Atmosphere;
    local DepthOfField = game_Lighting.DepthOfField;

    if not p10.Preview then
        local Atmosphere2 = game_Lighting.Atmosphere;
        local DepthOfField2 = game_Lighting.DepthOfField;
        Atmosphere2.Density = 0.33;
        Atmosphere2.Color = Color3.fromRGB(85, 255, 133);
        Atmosphere2.Decay = Color3.fromRGB(255, 25, 25);
        Atmosphere2.Glare = 2.33;
        Atmosphere2.Haze = 9.71;
        DepthOfField2.FarIntensity = 1;
        TweenService:Create(Atmosphere2, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Density = 0.282,
            Glare = 2.33,
            Haze = 9.71,
            Color = Color3.fromRGB(85, 255, 133),
            Decay = Color3.fromRGB(240, 255, 107)
        }):Play();
    end;

    task.wait(1.4);
    local _ = p10.Preview;
    VfxManager.Enable(u11.EnablingDollars, false);
    u11["Plane.005"].Transparency = 1;
    u11.Light0.Transparency = 1;
    u11.Light1.Transparency = 1;
    VfxManager.Enable(u15.Enabling, true);
    VfxManager.Enable(u11, false);
    VfxManager.Emit(u11["Plane.005"].Impact);

    if not p10.Preview then
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Parent = game_Lighting;
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        task.delay(0.755, function() -- Line: 44
            -- upvalues: BlurEffect (copy)
            BlurEffect:Destroy();
        end);
    end;

    task.wait(2.05);
    VfxManager.Enable(u15.Enabling, false);

    if not p10.Preview then
        DepthOfField.FarIntensity = u19.FarIntensity;
        TweenService:Create(Atmosphere, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Density = u20.Density,
            Color = u20.Color,
            Decay = u20.Decay,
            Glare = u20.Glare,
            Haze = u20.Haze
        }):Play();
    end;

    task.delay(2, function() -- Line: 310
        -- upvalues: u20 (copy), u19 (copy)
        u20:Destroy();
        u19:Destroy();
    end);
end;