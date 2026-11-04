 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

local function CloneCharacter(p1, p2, p3) -- Line: 13
    -- upvalues: Debris (copy)
    local Archivable = p1.Archivable;
    p1.Archivable = true;
    local v4 = p1:Clone();
    v4.Parent = p2 or Debris;
    v4.HumanoidRootPart.Anchored = true;
    v4.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
    v4.HumanoidRootPart.CFrame = p3 or p1.HumanoidRootPart.CFrame;

    for _, descendant in v4:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.CanCollide = false;
        elseif descendant:IsA("Highlight") or (descendant:IsA("Weld") or descendant:IsA("WeldConstraint")) and not descendant:FindFirstAncestorWhichIsA("Accessory") then
            descendant:Destroy();
        end;
    end;

    p1.Archivable = Archivable;

    return v4;
end;

return function(p5, p6) -- Line: 37
    -- upvalues: Debris (copy), CloneCharacter (copy), Lighting (copy), TweenService (copy), VfxManager (copy)
    local Player = p6.Player;
    local Character = Player.Character;

    if not Character then
        return;
    end;

    local Model = Instance.new("Model");
    Model.Parent = Debris;
    local Part = Instance.new("Part");
    Part.Parent = Model;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(1, 1, 1);
    Part.CFrame = p6.CFrame * (p6.Preview and CFrame.new(0, -2.8213333333333335, -3) * CFrame.Angles(0, 3.141592653589793, 0) or CFrame.new(-9, -8.464, 0) * CFrame.Angles(0, -1.5707963267948966, 0));
    Model.PrimaryPart = Part;
    task.delay(1.15, function() -- Line: 56
        -- upvalues: Model (copy)
        Model:Destroy();
    end);

    if p6.Preview then
        local v7 = script.Trophy:Clone();
        v7.Parent = Model;
        v7.Handle.Part0 = Part;
        v7:ScaleTo(2.5);
        v7.AnimationController.Animator:LoadAnimation(script.Animations.Trophy):Play();
        Model:ScaleTo(0.3333333333333333);

        return;
    end;

    local v8 = CloneCharacter(Character, Model, Part.CFrame);
    v8:ScaleTo(2.5);
    v8.Humanoid:LoadAnimation(script.Animations.Player0):Play();
    local v9 = {};

    for _, v in Player.Team:GetPlayers() do
        if v.Character and (v.Character:FindFirstChild("Humanoid") and (v.Character:FindFirstChild("HumanoidRootPart") and v ~= Player)) then
            local v10 = CloneCharacter(v.Character, Model, Part.CFrame);
            v10:ScaleTo(2.5);
            table.insert(v9, v10);
            v10.Humanoid:LoadAnimation(script.Animations[`Player{tostring(#v9)}`]):Play();

            if #v9 >= 3 then
                break;
            end;
        end;
    end;

    if #v9 < 3 then
        for i = #v9 + 1, 3 do
            local v11 = script.Rigs[`Player{tostring(i)}`]:Clone();
            v11:ScaleTo(2.5);
            v11.Parent = Model;
            table.insert(v9, v11);
            v11.HumanoidRootPart.CFrame = Part.CFrame;
            v11.Humanoid:LoadAnimation(script.Animations[`Player{tostring(i)}`]):Play();
            local _ = i;
        end;
    end;

    if not (v9[1] and (v9[2] and v9[3])) then
        Model:Destroy();

        return;
    end;

    local v12 = script.Trophy:Clone();
    v12.Parent = Model;
    v12.Handle.Part0 = v8.HumanoidRootPart;
    v12:ScaleTo(2.5);
    v12.AnimationController.Animator:LoadAnimation(script.Animations.Trophy):Play();
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u13 = ColorCorrection:Clone();
    u13.Name = "CC";
    u13.Parent = Lighting;
    u13.Enabled = true;
    task.delay(1.605, function() -- Line: 118
        -- upvalues: u13 (copy), Lighting (ref), ColorCorrection (copy)
        u13:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local BlurEffect = Instance.new("BlurEffect", Lighting);
    BlurEffect.Size = 15;
    TweenService:Create(BlurEffect, TweenInfo.new(0.6, Enum.EasingStyle.Linear), {
        Size = 0
    }):Play();
    VfxManager.DestroyEffect(BlurEffect, 0.6);
    u13.Brightness = 1;
    u13.TintColor = Color3.fromRGB(255, 155, 55);
    TweenService:Create(u13, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
        Brightness = ColorCorrection.Brightness,
        TintColor = ColorCorrection.TintColor
    }):Play();
    task.delay(1.15, function() -- Line: 134
        -- upvalues: Model (copy), Lighting (ref), TweenService (ref), VfxManager (ref), u13 (copy), ColorCorrection (copy)
        Model:Destroy();
        local BlurEffect2 = Instance.new("BlurEffect", Lighting);
        BlurEffect2.Size = 15;
        TweenService:Create(BlurEffect2, TweenInfo.new(0.6, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect2, 0.6);
        u13.Brightness = 1;
        u13.TintColor = Color3.fromRGB(255, 155, 55);
        TweenService:Create(u13, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            TintColor = ColorCorrection.TintColor
        }):Play();
    end);
end;