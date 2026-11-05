  

 

local u1 = game.ReplicatedStorage["Client Assets"];
local TweenService = game:GetService("TweenService");
game:GetService("Debris");
local Angles = CFrame.Angles;
local _ = math.rad;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);
local Sequence_V2 = require(game.ReplicatedStorage.ReplicatedModules.Classes.Sequence_V2);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u2 = EffectsHandler.GetEffect("Emit Particle V3");

local function Lerp(p3, p4, p5) -- Line: 14
    return (p4 - p3) * p5 + p3;
end;

local function GetColor(p6, p7) -- Line: 18
    -- upvalues: ParticleHandler (copy)
    local v8 = Color3.new(0, 1, 1);
    local v9 = ParticleHandler.GetSkinInfo(p6);

    if type(v9) == "table" then
        local v10 = (v9.GrandDescension or {}).HSVShift or (v9.Metadata or {}).HSVShift;

        if v10 then
            v8 = ParticleHandler.HSVShift(v8, v10);
        end;
    end;

    if p7 then
        v8 = ParticleHandler.HSVShiftColor(v8, p7);
    end;

    return v8;
end;

return function(u11) -- Line: 39
    -- upvalues: Sequence_V2 (copy), AssetHandler (copy), ParticleHandler (copy), Angles (copy), GetColor (copy), TweenService (copy), u2 (copy), u1 (copy)
    local Character = u11.Character;
    local Stand = u11.Stand;
    local Stats = u11.Stats;
    local Goal = u11.Goal;
    local Speed = u11.Speed;
    local u12 = u11.HueShift and {
        HueShift = u11.HueShift
    } or nil;

    if not (Character and Character:IsDescendantOf(workspace)) then
        return;
    end;

    if not (Stand and Stand:IsDescendantOf(workspace)) then
        return;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local u13 = Sequence_V2.new();
    local u14 = u13:GetTrove();
    local u15 = {};
    local wait = task.wait;
    local u16 = Stats.Offset or Vector3.new(0, 50, 100);
    local u17 = Goal * CFrame.new(u16);
    local Magnitude = (u17.Position - Goal.Position).Magnitude;
    local u18 = u14:Add(AssetHandler.CloneAsset("Comet", {
        AbilityName = "Dawn",
        SkinName = u11.SkinName
    }));
    local u19 = u14:Add(AssetHandler.CloneAsset("Symbol", {
        AbilityName = "Dawn",
        SkinName = u11.SkinName
    }));
    local u20 = u14:Clone(Stand);
    local v21 = ParticleHandler.GetSkinInfo(u11.SkinName);
    local v22 = type(v21) == "table" and ((v21.Comet or {}).HSVShift or (v21.Metadata or {}).HSVShift);

    if v22 then
        ParticleHandler.HSVShiftParticles(u18, v22);
    end;

    if u12 then
        ParticleHandler.HSVShiftParticles(u18, u12);
    end;

    for _, descendant in ipairs(u18:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = true;
        end;
    end;

    for _, descendant in ipairs(u20:GetDescendants()) do
        if descendant:IsA("Motor6D") then
            descendant:Destroy();
        end;
    end;

    local Handle = u20:FindFirstChild("Handle");

    if not Handle then
        u13:Destroy();

        return;
    end;

    Handle.Anchored = true;
    Handle.CFrame = CFrame.new(u17.Position, Goal.Position) * Angles(0, 0, 1.5707963267948966);
    local u23 = Handle.CFrame * CFrame.new(0, 0, -Magnitude / 2) * Angles(0, -3.141592653589793, 0);
    local u24 = Handle.CFrame * CFrame.new(0, 0, -Magnitude + 4) * Angles(0, -6.283185307179586, 0);
    u13:AddFrame(0, function(p25) -- Line: 106
        -- upvalues: Character (copy), u15 (copy), u19 (copy), Goal (copy), GetColor (ref), u11 (copy), u12 (copy), TweenService (ref), Angles (ref), u20 (copy)
        for _, descendant in ipairs(Character:GetDescendants()) do
            if descendant:IsA("BasePart") and descendant.Transparency == 0 then
                table.insert(u15, descendant);
                descendant.Transparency = 1;
            elseif descendant.ClassName == "ParticleEmitter" and descendant.Enabled then
                table.insert(u15, descendant);
                descendant.Enabled = false;
            end;
        end;

        u19.CFrame = Goal * CFrame.new(0, 0.5, 0);
        u19.Color = GetColor(u11.SkinName, u12);
        u19.Parent = workspace.Effects;
        TweenService:Create(u19, TweenInfo.new(0.5 / p25:GetSpeed(), Enum.EasingStyle.Sine), {
            Transparency = 0,
            CFrame = u19.CFrame * Angles(0, 4.71238898038469, 0),
            Size = u19.Size * 3
        }):Play();
        u20.Parent = workspace.Effects;
    end);
    u13:AddFrame(0, function(p26) -- Line: 125
        -- upvalues: u14 (copy), AssetHandler (ref), u11 (copy), HumanoidRootPart (copy), GetColor (ref), u12 (copy), TweenService (ref), Angles (ref)
        local v27 = u14.new();
        task.delay(1.5, v27.Destroy, v27);

        for i = 1, 2 do
            local v28 = v27:Clone(AssetHandler.GetAsset("slam/Heavy", {
                AbilityName = "Dawn",
                SkinName = u11.SkinName
            }));
            local Size = v28.Size;
            local v29 = Vector3.new(Size.X, 1.5, Size.Z);
            v28.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, i, 0);
            v28.Size = Vector3.new(0, 0, 0);
            v28.Color = GetColor(u11.SkinName, u12);
            v28.Parent = workspace.Effects;
            TweenService:Create(v28, TweenInfo.new(1 / p26:GetSpeed(), Enum.EasingStyle.Sine), {
                Transparency = 1,
                Size = v29 * i,
                CFrame = v28.CFrame * Angles(0, 3.141592653589793, 0)
            }):Play();
        end;
    end);
    u13:AddFrame(0, function(p30) -- Line: 140
        -- upvalues: u18 (copy), HumanoidRootPart (copy), wait (copy), TweenService (ref)
        local u31 = u18:Clone();
        u31.CFrame = HumanoidRootPart.CFrame;
        u31.Parent = workspace.Effects;
        wait(0.1 / p30:GetSpeed());
        local v32 = TweenService:Create(u31, TweenInfo.new(0.4 / p30:GetSpeed(), Enum.EasingStyle.Sine), {
            CFrame = u31.CFrame * CFrame.new(0, 50, 0)
        });
        v32.Completed:Once(function() -- Line: 146
            -- upvalues: u31 (copy)
            u31:Destroy();
        end);
        v32:Play();
    end);
    u13:AddFrame(30, function(u33) -- Line: 152
        -- upvalues: TweenService (ref), Handle (copy), u23 (copy), u24 (copy)
        local v34 = TweenService:Create(Handle, TweenInfo.new(0.1 / u33:GetSpeed(), Enum.EasingStyle.Sine), {
            CFrame = u23
        });
        v34.Completed:Once(function() -- Line: 154
            -- upvalues: TweenService (ref), Handle (ref), u33 (copy), u24 (ref)
            TweenService:Create(Handle, TweenInfo.new(0.1 / u33:GetSpeed(), Enum.EasingStyle.Sine), {
                CFrame = u24
            }):Play();
        end);
        v34:Play();
    end);
    u13:AddFrame(60, function(p35) -- Line: 161
        -- upvalues: u18 (copy), u17 (copy), Goal (copy), TweenService (ref), u16 (copy)
        u18.CFrame = CFrame.lookAt(u17.Position, Goal.Position);
        u18.Parent = workspace.Effects;
        TweenService:Create(u18, TweenInfo.new(0.5 / p35:GetSpeed(), Enum.EasingStyle.Sine), {
            CFrame = u18.CFrame * CFrame.new(0, 0, -u16.Magnitude)
        }):Play();
    end);
    u13:AddFrame(90, function(p36) -- Line: 167
        -- upvalues: u15 (copy), u13 (copy), u2 (ref), u11 (copy), u1 (ref), Goal (copy)
        for _, v in ipairs(u15) do
            if v.ClassName == "ParticleEmitter" then
                v.Enabled = true;
            else
                v.Transparency = 0;
            end;
        end;

        u13:Destroy();
        u2({
            Path = "Dawn Slam",
            Player = u11.Player,
            PathFolder = u1,
            Origin = Goal,
            SkinName = u11.SkinName
        });
    end);
    u13:SetSpeed(Speed);
    u13:Play();
end;