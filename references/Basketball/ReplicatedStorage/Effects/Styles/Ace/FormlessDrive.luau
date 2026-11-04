 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.Network);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local LocalPlayer = game.Players.LocalPlayer;

local function HideCharacter(p1: userdata, p2: any) -- Line: 13
    -- upvalues: TweenService (copy)
    p1:SetAttribute("Invis", true);

    for _, descendant in p1:GetDescendants() do
        if (descendant:IsA("BasePart") or descendant:IsA("Decal")) and descendant ~= p2 then
            TweenService:Create(descendant, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Transparency = descendant.Transparency + 1
            }):Play();
        end;
    end;
end;

local function UnhideCharacter(p3: userdata, p4: any) -- Line: 25
    -- upvalues: TweenService (copy)
    p3:SetAttribute("Invis", nil);

    for _, descendant in p3:GetDescendants() do
        if (descendant:IsA("BasePart") or descendant:IsA("Decal")) and descendant ~= p4 then
            TweenService:Create(descendant, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Transparency = descendant.Transparency - 1
            }):Play();
        end;
    end;
end;

local function createClone(p5: userdata) -- Line: 37
    -- upvalues: TweenService (copy)
    local v6 = p5:Clone();
    v6.Parent = workspace.Debris;

    for _, descendant in v6:GetDescendants() do
        if descendant:IsA("Script") or (descendant:IsA("LocalScript") or (descendant:IsA("Highlight") or descendant:IsA("Sound"))) then
            descendant:Destroy();
        elseif descendant:IsA("BasePart") or descendant:IsA("MeshPart") then
            descendant.Anchored = true;
            descendant.CanCollide = false;
            descendant.CanTouch = false;
            descendant.CanQuery = false;

            if v6:GetAttribute("Invis") and descendant.Name ~= "BALL" then
                descendant.Transparency = 0;
            else
                TweenService:Create(descendant, TweenInfo.new(0.5), {
                    Transparency = 1
                }):Play();
            end;
        elseif descendant:IsA("Humanoid") then
            descendant.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
        end;
    end;

    return v6;
end;

local function clonePlayerCharacter(p7) -- Line: 63
    local v8 = p7:Clone();

    for _, descendant in v8:GetDescendants() do
        if descendant:IsA("Script") or (descendant:IsA("Highlight") or descendant:IsA("Sound")) then
            descendant:Destroy();
        elseif descendant:IsA("BasePart") then
            descendant.Anchored = true;
            descendant.CanCollide = false;
            descendant.CanTouch = false;
            descendant.CanQuery = false;
            descendant.Transparency = 1;
        elseif descendant:IsA("Humanoid") then
            descendant.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
        end;
    end;

    return v8;
end;

local function getCharacterLimbs(p9) -- Line: 93
    return {
        p9:FindFirstChild("Right Arm"),
        p9:FindFirstChild("Right Leg"),
        p9:FindFirstChild("Left Arm"),
        p9:FindFirstChild("Left Leg"),
        p9:FindFirstChild("Torso"),
        p9:FindFirstChild("Head")
    };
end;

local function getCharacterAccessories(p10) -- Line: 104
    local v11 = {};

    for _, child in p10:GetChildren() do
        if child:IsA("Accessory") then
            table.insert(v11, child);
        end;
    end;

    return v11;
end;

local function alignClonedCharacterToCharacter(p12, p13, p14) -- Line: 116
    for _, v in p13 do
        local v15 = p12[v.Name];
        v15.CFrame = v.CFrame;
        v15.Transparency = 0;
    end;

    for _, v in p14 do
        local Handle = p12[v.Name].Handle;
        Handle.CFrame = v.Handle.CFrame;
        Handle.Transparency = 0;
    end;
end;

return function(p16, p17) -- Line: 132
    -- upvalues: SfxManager (copy), VfxManager (copy), LocalPlayer (copy), TweenService (copy), getCharacterLimbs (copy), getCharacterAccessories (copy), clonePlayerCharacter (copy), RunService (copy), alignClonedCharacterToCharacter (copy)
    local TimeSent = p17.TimeSent;
    local v18 = workspace:GetServerTimeNow() - TimeSent;
    local Char = p17.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char.Archivable = true;
    SfxManager:playSound({
        Sound = "FormlessDrive",
        Duration = 4,
        Parent = HumanoidRootPart
    });
    local u19 = script.VFX:Clone();
    u19.Parent = Char;

    for _, child in u19.Welds:GetChildren() do
        local v20 = u19:FindFirstChild(child.Name);

        if v20 then
            child.Part0 = HumanoidRootPart;
            child.Part1 = v20;
        end;
    end;

    local u21 = script.Head.Eyes:Clone();
    u21.Parent = Char:FindFirstChild("Head");
    local u22 = {};

    for _, child in script.Attachments:GetChildren() do
        local v23 = child:Clone();
        v23.Parent = HumanoidRootPart;
        u22[v23.Name] = v23;
    end;

    local function Bounce(p24: number) -- Line: 165
        -- upvalues: u19 (copy), u22 (copy), VfxManager (ref)
        local v25 = u19:FindFirstChild("Bounce" .. p24);

        if not v25 then
            return;
        end;

        local v26 = u22["Bounce" .. p24];

        if not v26 then
            return;
        end;

        VfxManager.Emit(v25);
        VfxManager.Emit(v26);
    end;

    task.delay(0.1 - v18, Bounce, 1);
    task.delay(0.3 - v18, Bounce, 2);
    task.delay(0.8 - v18, Bounce, 3);
    task.delay(1.08 - v18, Bounce, 4);
    task.delay(1.35 - v18, Bounce, 5);
    task.delay(1.51 - v18, Bounce, 6);
    task.delay(1.96 - v18, Bounce, 7);
    task.delay(1.883 - v18, function() -- Line: 185
        -- upvalues: u22 (copy), VfxManager (ref)
        local Spin = u22.Spin;

        if not Spin then
            return;
        end;

        VfxManager.Emit(Spin);
    end);
    task.delay(2.2 - v18, function() -- Line: 192
        -- upvalues: LocalPlayer (ref), HumanoidRootPart (copy)
        local v27 = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - HumanoidRootPart.Position;

        if HumanoidRootPart.AssemblyLinearVelocity.Magnitude > 5 then
            local _ = v27.Magnitude <= 30;
        end;
    end);
    task.delay(5, function() -- Line: 198
        -- upvalues: u19 (copy), u22 (copy), u21 (copy), TweenService (ref)
        u19:Destroy();

        for _, v in u22 do
            v:Destroy();
        end;

        for _, child in u21:GetChildren() do
            if child:IsA("Trail") then
                TweenService:Create(child, TweenInfo.new(0.5), {
                    Lifetime = 0
                }):Play();
            end;
        end;

        task.wait(0.5);
        u21:Destroy();
    end);

    if v18 >= 2.2 then
        Char.Archivable = false;

        return;
    end;

    local v28 = 0 + task.wait(0.03333333333333333);
    local u29 = getCharacterLimbs(Char);
    local v30 = v28 + task.wait(0.03333333333333333);
    local u31 = getCharacterAccessories(Char);
    local v32 = v30 + task.wait(0.03333333333333333);
    local u33 = clonePlayerCharacter(Char);
    u33.Parent = workspace.Debris;
    local v34 = v32 + task.wait(0.03333333333333333);
    local u35 = u33:Clone();
    u35.Parent = workspace.Debris;
    local v36 = v34 + task.wait(0.03333333333333333);
    local u37 = u33:Clone();
    u37.Parent = workspace.Debris;
    Char.Archivable = false;

    if v36 < 0.2 then
        task.wait(0.2 - v36);
    end;

    local v43 = RunService.Heartbeat:Connect(function(p38) -- Line: 255
        -- upvalues: u29 (ref), u33 (ref), u35 (ref), u37 (ref), u31 (ref)
        local v39 = 2 * p38;

        for _, v in u29 do
            local Name = v.Name;
            local v40 = u33[Name];
            v40.Transparency = v40.Transparency + v39;
            local v41 = u35[Name];
            v41.Transparency = v41.Transparency + v39;
            local v42 = u37[Name];
            v42.Transparency = v42.Transparency + v39;
        end;

        for _, v in u31 do
            local Name = v.Name;
            local Handle = u33[Name].Handle;
            Handle.Transparency = Handle.Transparency + v39;
            local Handle2 = u35[Name].Handle;
            Handle2.Transparency = Handle2.Transparency + v39;
            local Handle3 = u37[Name].Handle;
            Handle3.Transparency = Handle3.Transparency + v39;
        end;
    end);
    local v44 = 0;

    while v18 < 2 do
        local v45 = v44 + 1;
        v44 = v45 > 3 and 1 or v45;
        local v46;

        if v44 == 1 then
            v46 = u33;
        elseif v44 == 2 then
            v46 = u35;
        else
            v46 = u37;
        end;

        alignClonedCharacterToCharacter(v46, u29, u31);
        v18 = v18 + task.wait(0.15);
    end;

    v43:Disconnect();
    task.spawn(function() -- Line: 298
        -- upvalues: u33 (ref), u35 (ref), u37 (ref)
        u33:Destroy();
        task.wait();
        u35:Destroy();
        task.wait();
        u37:Destroy();
    end);
end;