 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local _ = Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 12
    -- upvalues: SfxManager (copy), Debris (copy), Essentials (copy), VfxManager (copy), TweenService (copy)
    local TimeSent = p2.TimeSent;
    local _ = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local Torso = Character:FindFirstChild("Torso");

    if Character:GetAttribute("Invis") then
        return;
    end;

    local u3 = SfxManager:playSound({
        Sound = "AscendantShoot",
        Parent = HumanoidRootPart
    });
    local v4 = script.Aura:Clone();
    v4.Parent = Debris;
    v4.CFrame = Torso.CFrame;
    Essentials:Weld(v4, Torso);
    VfxManager.DestroyEffect(v4, 0.75);
    VfxManager.Enable(v4, true);
    local u5 = {};

    for _, descendant in v4:GetDescendants() do
        if descendant:IsA("Trail") then
            table.insert(u5, descendant);
        end;
    end;

    task.delay(0.5, function() -- Line: 40
        -- upvalues: u3 (copy), TweenService (ref), u5 (copy), VfxManager (ref)
        if u3 then
            TweenService:Create(u3, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Volume = 0
            }):Play();
        end;

        local NumberValue = Instance.new("NumberValue");
        NumberValue.Value = 0.5;
        NumberValue.Changed:Connect(function() -- Line: 47
            -- upvalues: u5 (ref), NumberValue (copy)
            for _, v in u5 do
                v.Transparency = NumberSequence.new(NumberValue.Value);
            end;
        end);
        TweenService:Create(NumberValue, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Value = 1
        }):Play();
        VfxManager.DestroyEffect(NumberValue, 0.25);
    end);

    if p2.ZoneColor then
        local ZoneColor = p2.ZoneColor;
        local v6 = ZoneColor == "" and Color3.fromHSV(1, 0, 1) or Color3.fromHex(ZoneColor);
        v4.att2.Trail.Color = ColorSequence.new(v6);
    end;

    local u7 = { Character:FindFirstChild("BALL", true), Character:FindFirstChild("PlrBall") };

    for _, descendant in v4:GetDescendants() do
        if descendant:IsA("Trail") then
            table.insert(u7, descendant);
        end;
    end;

    task.spawn(function() -- Line: 74
        -- upvalues: Essentials (ref), Character (copy), u7 (copy)
        Essentials:HideCharacter(Character, u7, nil, 0.05);
        task.wait(0.05);
        Essentials:UnhideCharacter(Character, u7, nil, 0.05);
        task.wait(0.05);
        Essentials:HideCharacter(Character, u7, nil, 0.05);
        task.wait(0.05);
        Essentials:UnhideCharacter(Character, u7, nil, 0.05);
        task.wait(0.05);
        Essentials:HideCharacter(Character, u7, nil, 0.05);
        task.wait(0.05);
        Essentials:UnhideCharacter(Character, u7, nil, 0.05);
        task.wait(0.05);
        Essentials:HideCharacter(Character, u7, nil, 0.05);
        task.wait(0.05);
        Essentials:UnhideCharacter(Character, u7, nil, 0.05);
        task.wait(0.05);
        Essentials:HideCharacter(Character, u7, nil, 0.05);
        task.wait(0.05);
        Essentials:UnhideCharacter(Character, u7, nil, 0.05);
    end);
    local v8 = tick();

    repeat
        task.wait(0.05);
        local v9 = Essentials:CreateClone(Character, 0.1);
        VfxManager.DestroyEffect(v9, 0.1);
    until tick() - v8 > 0.5;
end;