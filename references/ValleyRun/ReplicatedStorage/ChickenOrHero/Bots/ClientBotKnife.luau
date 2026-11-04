 

 

local Parent = script.Parent.Parent;
local DaggerConfig = require(Parent.Weapons.DaggerConfig);
local DaggerGrip = require(Parent.Weapons.DaggerGrip);
local WeaponEffects = require(Parent.Weapons.WeaponEffects);
local DaggerAnimation = require(Parent.Animation.DaggerAnimation);
local KnifeVisibility = require(Parent.Weapons.KnifeVisibility);
local DualWield = require(Parent.Weapons.DualWield);
local KnifeChains = require(Parent.Weapons.KnifeChains);
local EmotePieces = require(Parent.Emotes.EmotePieces);
local Models = Parent.Weapons.Models;
local u1 = {};
u1.__index = u1;

local function usable(p2) -- Line: 19
    local v3;

    if p2 then
        v3 = p2:FindFirstChild("Handle");
    else
        v3 = p2;
    end;

    local v4;

    if p2 then
        v4 = p2:FindFirstChild("Blade");
    else
        v4 = p2;
    end;

    local v5;

    if p2 then
        v5 = p2:FindFirstChild("StowedBlade");
    else
        v5 = p2;
    end;

    local v6;

    if v3 then
        v6 = v3:FindFirstChild("BladeWeld");
    else
        v6 = v3;
    end;

    local v7;

    if v3 == nil then
        v7 = false;
    else
        v7 = v3:IsA("BasePart");

        if v7 then
            if v4 == nil then
                v7 = false;
            else
                v7 = v4:IsA("BasePart");

                if v7 then
                    if v5 == nil then
                        v7 = false;
                    else
                        v7 = v5:IsA("BasePart");

                        if v7 then
                            if v6 == nil then
                                v7 = false;
                            else
                                v7 = v6:IsA("JointInstance");

                                if v7 then
                                    if v6.Part0 == v3 and (v6.Part1 == v4 and typeof(p2:GetAttribute("GripC1")) == "CFrame") then
                                        v7 = typeof(p2:GetAttribute("StowedOffset")) == "CFrame";
                                    else
                                        v7 = false;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;

    return v7;
end;

u1.usable = usable;

function u1.new(p8, p9, p10) -- Line: 41
    -- upvalues: u1 (copy), usable (copy), EmotePieces (copy), DualWield (copy), KnifeVisibility (copy), KnifeChains (copy)
    local v11 = setmetatable({
        character = p8
    }, u1);
    local v12 = p8:FindFirstChild("Right Arm");

    if v12 then
        v12 = v12:FindFirstChild("Handle");
    end;

    if p9 and (v12 and (v12:IsA("Motor6D") and (v12.Part1 == p9:FindFirstChild("Handle") and usable(p9)))) then
        EmotePieces.strip(p9);
        v11.weapon = p9;
        v11.motor = v12;
        v11.blade = p9.Blade;
        v11.stowed = p9.StowedBlade;
        v11.skin = p10;
        v11.held = p9.Blade.Transparency < 0.5;
        v11.left = DualWield.attach(p9, p8:FindFirstChild("Left Arm"));

        if v11.left then
            KnifeVisibility.set(v11.left, v11.held);
        end;

        v11.leftStowed = DualWield.stow(p9, p8:FindFirstChild("Torso"));

        if v11.leftStowed then
            KnifeVisibility.set(v11.leftStowed, not v11.held);
        end;

        v11.chain = KnifeChains.attach(p9, p8);

        if v11.chain then
            v11.held = nil;
            KnifeChains.show(v11.chain, true);

            return v11;
        end;
    else
        if p9 then
            p9:Destroy();
        end;

        if v12 and v12:IsA("Motor6D") then
            v12:Destroy();
        end;
    end;

    return v11;
end;

function u1.remove(p13) -- Line: 78
    if p13.controller then
        p13.controller:destroy();
        p13.controller = nil;
    end;

    if p13.motor then
        p13.motor:Destroy();
    end;

    if p13.weapon then
        p13.weapon:Destroy();
    end;

    p13.weapon = nil;
    p13.motor = nil;
    p13.blade = nil;
    p13.stowed = nil;
    p13.left = nil;
    p13.chain = nil;
    p13.leftStowed = nil;
    p13.skin = nil;
    p13.held = nil;
    p13.drawAt = nil;
end;

function u1.create(p14, p15) -- Line: 94
    -- upvalues: Models (copy), usable (copy), DaggerConfig (copy), DualWield (copy), KnifeChains (copy), KnifeVisibility (copy), DaggerGrip (copy), WeaponEffects (copy)
    local character = p14.character;
    local v16 = character:FindFirstChildOfClass("Humanoid");
    local v17 = character:FindFirstChild("Right Arm");
    local Torso = character:FindFirstChild("Torso");

    if not (v16 and (v16.RigType == Enum.HumanoidRigType.R6 and (v17 and Torso))) then
        return false;
    end;

    local v18 = Models:FindFirstChild(p15);

    if not usable(v18) then
        p15 = DaggerConfig.DefaultSkin;
        v18 = Models:FindFirstChild(p15);
    end;

    if not usable(v18) then
        return false;
    end;

    local Handle = v17:FindFirstChild("Handle");

    if Handle and Handle:IsA("JointInstance") then
        Handle:Destroy();
    end;

    local v19 = v18:Clone();
    v19.Name = "EquippedDagger";
    local Handle2 = v19.Handle;
    local Blade = v19.Blade;
    local StowedBlade = v19.StowedBlade;

    for _, descendant in v19:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = false;
            descendant.CanCollide = false;
            descendant.CanTouch = false;
            descendant.CanQuery = false;
            descendant.Massless = true;
            descendant.CollisionGroup = Torso.CollisionGroup;
        end;
    end;

    local v20 = DualWield.attach(v19, character:FindFirstChild("Left Arm"));
    local v21 = DualWield.stow(v19, Torso);
    local v22 = KnifeChains.attach(v19, character);
    Handle2.Transparency = 1;
    KnifeVisibility.set(Blade, false);
    KnifeVisibility.set(StowedBlade, v22 == nil and true or v20 ~= nil);

    if v21 then
        KnifeVisibility.set(v21, true);
    end;

    if v20 then
        KnifeVisibility.set(v20, false);
    end;

    if v22 then
        KnifeChains.show(v22, true);
    end;

    local Motor6D = Instance.new("Motor6D");
    Motor6D.Name = "Handle";
    Motor6D.Part0 = v17;
    Motor6D.Part1 = Handle2;
    Motor6D.C0 = DaggerGrip.c0(v19);
    Motor6D.C1 = v19:GetAttribute("GripC1");
    Handle2.CFrame = v17.CFrame * Motor6D.C0 * Motor6D.C1:Inverse();
    local BladeWeld = Handle2:FindFirstChild("BladeWeld");
    Blade.CFrame = Handle2.CFrame * BladeWeld.C0 * BladeWeld.C1:Inverse();
    StowedBlade.CFrame = Torso.CFrame * v19:GetAttribute("StowedOffset");
    local Weld = Instance.new("Weld");
    Weld.Name = "StowedDagger";
    Weld.Part0 = Torso;
    Weld.Part1 = StowedBlade;
    Weld.C0 = v19:GetAttribute("StowedOffset");
    Weld.Parent = StowedBlade;
    WeaponEffects.position(v19);
    v19.Parent = character;
    Motor6D.Parent = v17;
    p14.weapon = v19;
    p14.motor = Motor6D;
    p14.blade = Blade;
    p14.stowed = StowedBlade;
    p14.left = v20;
    p14.chain = v22;
    p14.leftStowed = v21;
    p14.skin = p15;
    p14.held = false;
    p14.drawAt = nil;

    return true;
end;

function u1.show(p23, p24, p25) -- Line: 169
    -- upvalues: KnifeChains (copy), KnifeVisibility (copy)
    if p23.chain then
        p23.held = p24;

        if KnifeChains.hold(p23.chain, p24, p25) and p23.controller then
            p23.controller:restartStow();
        end;

        KnifeChains.show(p23.chain, true);

        if p23.left then
            KnifeVisibility.set(p23.left, p24 == true);
            KnifeVisibility.set(p23.stowed, p24 ~= true);
        end;

        return;
    end;

    if p23.held == p24 then
        return;
    end;

    p23.held = p24;
    KnifeVisibility.set(p23.blade, p24);
    KnifeVisibility.set(p23.stowed, not p24);

    if p23.leftStowed then
        KnifeVisibility.set(p23.leftStowed, not p24);
    end;

    if p23.left then
        KnifeVisibility.set(p23.left, p24);
    end;
end;

function u1.hide(p26) -- Line: 200
    -- upvalues: KnifeChains (copy), KnifeVisibility (copy)
    if p26.blade then
        p26.held = nil;

        if p26.chain then
            KnifeChains.show(p26.chain, false);

            if p26.left then
                KnifeVisibility.set(p26.left, false);
                KnifeVisibility.set(p26.stowed, false);
            end;

            return;
        end;

        KnifeVisibility.set(p26.blade, false);
        KnifeVisibility.set(p26.stowed, false);

        if p26.leftStowed then
            KnifeVisibility.set(p26.leftStowed, false);
        end;

        if p26.left then
            KnifeVisibility.set(p26.left, false);
        end;
    end;
end;

function u1.update(p27, p28, p29) -- Line: 222
    -- upvalues: DaggerConfig (copy), DaggerAnimation (copy)
    local character = p27.character;
    local v30 = character:GetAttribute("DaggerEquipped") == true;

    if v30 then
        p27.seen = true;
    elseif p27.seen or not p27.weapon then
        if p27.weapon then
            p27:remove();
        end;

        return;
    end;

    local Attribute = character:GetAttribute("DaggerState");
    local Attribute2 = character:GetAttribute("DaggerDrawStartedAt");
    local Attribute3 = character:GetAttribute("DaggerSkin");

    if type(Attribute3) ~= "string" then
        Attribute3 = DaggerConfig.DefaultSkin;
    end;

    if p27.weapon then
        if p27.skin == nil and v30 then
            p27.skin = Attribute3;
        elseif p27.skin ~= Attribute3 and (v30 and (Attribute ~= "Held" and Attribute ~= "Drawing")) then
            p27:remove();
        end;
    end;

    if not (p27.weapon or p27:create(Attribute3)) then
        return;
    end;

    if Attribute == "Drawing" and (type(Attribute2) == "number" and p28 < Attribute2) then
        return;
    end;

    local v31 = Attribute == nil and not (p27.seen or (character:GetAttribute("CloneStartsHeld") ~= true or character:GetAttribute("GameRole") ~= "Catcher")) and true or (Attribute == "Drawing" and true or Attribute == "Held");
    local v32;

    if Attribute == "Drawing" and type(Attribute2) == "number" then
        v32 = p28 - Attribute2 < DaggerConfig.DrawDuration;
    else
        v32 = false;
    end;

    if v32 then
        p27:show(p27.chain ~= nil and true or p28 - Attribute2 >= DaggerConfig.DrawTransfer);
    else
        p27:show(v31);
    end;

    if not p29 then
        return;
    end;

    local controller = p27.controller;

    if not controller then
        controller = DaggerAnimation.new(character);
        p27.controller = controller;
        p27.reset = character:GetAttribute("MovementReset");
    end;

    local Attribute4 = character:GetAttribute("MovementReset");

    if Attribute4 ~= p27.reset then
        p27.reset = Attribute4;
        controller:reset();
        controller.attackAt = character:GetAttribute("ReachStartedAt");
    end;

    if v32 and Attribute2 ~= p27.drawAt then
        p27.drawAt = Attribute2;
        controller:draw(p28);
    end;

    controller:update(p28, v31, v32, false);
end;

function u1.destroy(p33) -- Line: 286
    if p33.controller then
        p33.controller:destroy();
        p33.controller = nil;
    end;
end;

return u1;