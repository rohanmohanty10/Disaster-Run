  

 

game:GetService("TweenService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TextChatService = game:GetService("TextChatService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.AnimationHandler);
local u1 = Random.new();
local _ = workspace.CurrentCamera;
local _ = Players.LocalPlayer;
local u2 = {};
local u3 = { "Caw! Caw! A new task awaits you!", "CAW CAW! Your next mission is ready!", "Cawww... a new task has been given you.", "CAW! CAW CAW! Check your quests!", "Cawww caw... a new task is available to you!" };

return function(p4) -- Line: 31
    -- upvalues: u2 (copy), TextChatService (copy), u3 (copy), u1 (copy), Trove (copy), AssetHandler (copy), RunService (copy)
    local v5 = p4 or {};
    local _ = v5.Player;
    local Character = v5.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;

    if v5.Quest then
        local v6 = u2[Character];

        if v6 then
            TextChatService:DisplayBubble(v6.Model.PrimaryPart, u3[u1:NextInteger(1, #u3)]);

            return;
        end;

        print("return");

        return;
    end;

    if u2[Character] then
        return;
    end;

    local u7 = Trove.new();
    u7:AttachToInstance(Character);
    local v8 = u7:Add(AssetHandler.CloneAsset("Universal/QuestAssets/Demon Slayer/Crow"));
    local PrimaryPart = v8.PrimaryPart;
    PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(-10, 10, 25);
    v8.Parent = workspace.Effects;
    u2[Character] = {
        Trove = u7,
        Model = v8
    };
    u7:Add(function() -- Line: 67
        -- upvalues: u2 (ref), Character (copy)
        u2[Character] = nil;
    end);
    local v9 = u7:Construct(Instance, "Attachment");
    v9.Parent = PrimaryPart;
    local u10 = u7:Construct(Instance, "Attachment");
    u10.Position = Vector3.new(0.75, 1, 0);
    u10.Parent = workspace.Terrain;
    local AlignPosition = Instance.new("AlignPosition");
    AlignPosition.Attachment0 = v9;
    AlignPosition.Attachment1 = u10;
    AlignPosition.MaxForce = 10000;
    AlignPosition.MaxVelocity = 20;
    AlignPosition.Responsiveness = 10;
    AlignPosition.Parent = v9;
    local AlignOrientation = Instance.new("AlignOrientation");
    AlignOrientation.Attachment0 = v9;
    AlignOrientation.Attachment1 = u10;
    AlignOrientation.MaxTorque = 10000;
    AlignOrientation.MaxAngularVelocity = 10;
    AlignOrientation.Responsiveness = 10;
    AlignOrientation.Parent = v9;
    local u11 = nil;

    local function PlayAnimation(p12) -- Line: 97
        -- upvalues: u11 (ref)
        if u11 == p12 then
            return;
        end;

        u11 = p12;
    end;

    u11 = u11 ~= "Flying" and "Flying" or u11;
    local Position = HumanoidRootPart.Position;
    u7:Add(RunService.Heartbeat:Connect(function(p13) -- Line: 107
        -- upvalues: PrimaryPart (copy), HumanoidRootPart (copy), Position (ref), u10 (copy), u11 (ref)
        if not (PrimaryPart and PrimaryPart.Parent) then
            return;
        end;

        local Position2 = HumanoidRootPart.Position;
        local v14 = (Position2 - Position) / p13;
        Position = Position2;
        local Magnitude = v14.Magnitude;
        local v15 = Magnitude > 0.5 and v14.Unit or HumanoidRootPart.CFrame.LookVector;
        local v16 = math.clamp(Magnitude / 28, 0, 1);
        local v17 = Vector3.new(0, v16 * 3, 0);
        u10.WorldPosition = Position2 + Vector3.new(0.75, 1, 0) + -v15 * (v16 * 6) + v17;
        local v18 = (PrimaryPart.Position - u10.WorldPosition).Magnitude <= 4 and "Idle" or "Flying";

        if u11 == v18 then
            return;
        end;

        u11 = v18;
    end));
    local u19 = false;
    local u20 = nil;
    u7:Add(Character:GetAttributeChangedSignal("SlayerCrow"):Connect(function() -- Line: 130
        -- upvalues: Character (copy), u19 (ref), AlignPosition (copy), AlignOrientation (copy), u20 (ref), u7 (copy), HumanoidRootPart (copy), u1 (ref), u10 (copy)
        if Character:GetAttribute("SlayerCrow") then
            if not u19 then
                return;
            end;

            u19 = false;

            if u20 then
                u20:Destroy();
                u20 = nil;
            end;

            AlignPosition.Attachment1 = u10;
            AlignOrientation.Attachment1 = u10;

            return;
        end;

        if u19 then
            return;
        end;

        u19 = true;
        AlignPosition.Attachment1 = nil;
        AlignOrientation.Attachment1 = nil;
        u20 = u7:Extend();
        local v21 = u20:Construct(Instance, "Attachment");
        local Position2 = HumanoidRootPart.Position;
        local v22 = u1:NextNumber(-10, 10);
        v21.WorldPosition = Position2 + Vector3.new(v22, 30, u1:NextNumber(-10, 10));
        v21.Parent = workspace.Terrain;
        AlignPosition.Attachment1 = v21;
        AlignOrientation.Attachment1 = v21;
        u20:Add(task.delay(2, u7.Destroy, u7));
    end));
end;