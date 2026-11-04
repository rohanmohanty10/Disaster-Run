 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local ContextActionService = game:GetService("ContextActionService");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local ContactCatchConfig = require(ChickenOrHero.Game:WaitForChild("ContactCatchConfig"));
local CombatPrediction = require(ChickenOrHero.Game:WaitForChild("CombatPrediction"));
CombatPrediction.start();
local ControlGate = require(ChickenOrHero.Movement.ControlGate);
local TouchActionButton = require(ChickenOrHero.Presentation.TouchActionButton);
local TouchCombatLayout = require(ChickenOrHero.Presentation:WaitForChild("TouchCombatLayout"));
local BossCombat = require(ChickenOrHero.Game:WaitForChild("BossCombat"));
local MeleeEvent = ChickenOrHero.Game:WaitForChild("MeleeEvent");
local MeleeInputMode = ChickenOrHero.Game:WaitForChild("MeleeInputMode");
local u1 = UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(function() -- Line: 16, Name: reportInput
    -- upvalues: MeleeInputMode (copy), UserInputService (copy)
    MeleeInputMode:FireServer(UserInputService.PreferredInput == Enum.PreferredInput.Touch);
end);
MeleeInputMode:FireServer(UserInputService.PreferredInput == Enum.PreferredInput.Touch);
script.Destroying:Connect(function() -- Line: 21
    -- upvalues: u1 (copy)
    u1:Disconnect();
end);
local HUD = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("HUD");
local CatchButton = HUD:WaitForChild("CatchButton");
local u2 = CatchButton:Clone();
u2.Name = "MeleeButton";
u2.Visible = false;
u2.Label.Text = "MELEE";
u2.Parent = HUD;

for _, v in { u2, CatchButton, HUD:FindFirstChild("BoostButton") } do
    if v then
        for _, child in v:GetChildren() do
            if child:IsA("UISizeConstraint") then
                child:Destroy();
            end;
        end;
    end;
end;

local u3 = ContactCatchConfig.Windup + ContactCatchConfig.ActiveDuration + ContactCatchConfig.Recovery;
local u4 = 0;
local u5 = nil;
local u6 = 0;

local function available() -- Line: 42
    -- upvalues: LocalPlayer (copy), ContactCatchConfig (copy), BossCombat (copy), ControlGate (copy), ChickenOrHero (copy)
    local Character = LocalPlayer.Character;
    local v7;

    if Character then
        v7 = Character:FindFirstChildOfClass("Humanoid");
    else
        v7 = Character;
    end;

    local v8;

    if Character then
        v8 = Character:FindFirstChild("HumanoidRootPart");
    else
        v8 = Character;
    end;

    local Enabled = ContactCatchConfig.Enabled;

    if Enabled then
        if LocalPlayer:GetAttribute("InMatch") == true then
            local v9 = BossCombat.attacker(LocalPlayer);

            if v9 then
                if LocalPlayer:GetAttribute("RunState") == "Active" then
                    if v7 then
                        if v7.Health > 0 then
                            v7 = not v7.Sit and (not v7.PlatformStand and (v8 and not v8.Anchored) and not (Character:GetAttribute("MovementLocked") or Character:GetAttribute("Ragdolled")) and not (Character:GetAttribute("TackleActive") or ControlGate.reason(LocalPlayer) or (ChickenOrHero.Game.Session:GetAttribute("GlobalPaused") or ChickenOrHero.Game.Session:GetAttribute("MapChanging")))) and (not Character:GetAttribute("DaggerEquipped") or Character:GetAttribute("DaggerState") == "Held");
                        else
                            v7 = false;
                        end;
                    end;
                else
                    v7 = false;
                end;
            else
                v7 = v9;
            end;
        else
            v7 = false;
        end;
    else
        v7 = Enabled;
    end;

    return v7;
end;

local function remaining() -- Line: 65
    -- upvalues: LocalPlayer (copy), u4 (ref), CombatPrediction (copy), u3 (copy)
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:GetAttribute("ReachStartedAt");
    end;

    local v10 = u4 - workspace:GetServerTimeNow();
    local v11 = CombatPrediction.meleeRemaining();
    local v12 = type(Character) == "number" and (Character + u3 - workspace:GetServerTimeNow() or 0) or 0;

    return math.max(0, v10, v11, v12);
end;

local function dispatch() -- Line: 75
    -- upvalues: LocalPlayer (copy), u5 (ref), u4 (ref), u6 (ref), MeleeEvent (copy), CombatPrediction (copy), ContactCatchConfig (copy)
    local Character = LocalPlayer.Character;
    local v13;

    if Character then
        v13 = Character:FindFirstChild("HumanoidRootPart");
    else
        v13 = Character;
    end;

    if not v13 then
        return;
    end;

    local v14 = v13.CFrame.LookVector * Vector3.new(1, 0, 1);

    if v14.Magnitude < 0.01 then
        return;
    end;

    local Unit = v14.Unit;
    local ServerTimeNow = workspace:GetServerTimeNow();
    local v15 = game:GetService("HttpService"):GenerateGUID(false);
    u5 = v15;
    u4 = ServerTimeNow + 0.5;
    u6 = 0;
    MeleeEvent:FireServer({
        id = v15,
        at = ServerTimeNow,
        direction = Unit,
        position = v13.Position
    });
    CombatPrediction.begin({
        kind = "Melee",
        predicted = true,
        id = v15,
        character = Character,
        startedAt = ServerTimeNow,
        starts = ServerTimeNow + ContactCatchConfig.Windup,
        ends = ServerTimeNow + ContactCatchConfig.Windup + ContactCatchConfig.ActiveDuration,
        direction = Unit,
        box = CombatPrediction.meleeBox(Character)
    });
end;

local function request() -- Line: 104
    -- upvalues: available (copy), remaining (copy), dispatch (copy), u6 (ref)
    if not available() then
        return;
    end;

    if remaining() <= 0 then
        dispatch();

        return;
    end;

    if remaining() <= 0.18 then
        u6 = workspace:GetServerTimeNow() + 0.18;
    end;
end;

local u19 = MeleeEvent.OnClientEvent:Connect(function(p16, p17, p18) -- Line: 114
    -- upvalues: CombatPrediction (copy), u5 (ref), u4 (ref), u6 (ref)
    CombatPrediction.reconcile(p16, p17, p18);

    if p16 ~= u5 then
        return;
    end;

    u5 = nil;
    u4 = 0;

    if p17 then
        u6 = 0;
    end;
end);
local u20 = LocalPlayer.CharacterAdded:Connect(function() -- Line: 125
    -- upvalues: u5 (ref), u4 (ref), u6 (ref)
    u5 = nil;
    u4 = 0;
    u6 = 0;
end);
local u21 = TouchActionButton.bind(u2, request);
local u24 = UserInputService.InputBegan:Connect(function(p22, p23) -- Line: 129
    -- upvalues: UserInputService (copy), available (copy), remaining (copy), dispatch (copy), u6 (ref)
    if p22.UserInputType == Enum.UserInputType.MouseButton1 and (not p23 or UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter) then
        if not available() then
            return;
        end;

        if remaining() <= 0 then
            dispatch();

            return;
        end;

        if remaining() <= 0.18 then
            u6 = workspace:GetServerTimeNow() + 0.18;
        end;
    end;
end);
ContextActionService:BindAction("CoHMelee", function(p25, p26) -- Line: 137
    -- upvalues: UserInputService (copy), available (copy), remaining (copy), dispatch (copy), u6 (ref)
    if UserInputService:GetFocusedTextBox() or not available() then
        return Enum.ContextActionResult.Pass;
    end;

    if p26 == Enum.UserInputState.Begin and available() then
        if remaining() <= 0 then
            dispatch();
        elseif remaining() <= 0.18 then
            u6 = workspace:GetServerTimeNow() + 0.18;
        end;
    end;

    return Enum.ContextActionResult.Sink;
end, false, Enum.KeyCode.ButtonL2);
local u27 = {
    position = CatchButton.Position,
    size = CatchButton.Size,
    anchor = CatchButton.AnchorPoint
};
local BoostButton = HUD:FindFirstChild("BoostButton");
local u28 = BoostButton and {
    position = BoostButton.Position,
    size = BoostButton.Size,
    anchor = BoostButton.AnchorPoint
};
local u30 = RunService.RenderStepped:Connect(function() -- Line: 149
    -- upvalues: u5 (ref), u4 (ref), u6 (ref), available (copy), remaining (copy), dispatch (copy), ChickenOrHero (copy), LocalPlayer (copy), TouchActionButton (copy), u2 (copy), UserInputService (copy), TouchCombatLayout (copy), BossCombat (copy), CatchButton (copy), BoostButton (copy), u27 (copy), u28 (copy)
    local ServerTimeNow = workspace:GetServerTimeNow();

    if u5 and u4 <= ServerTimeNow then
        u5 = nil;
        u4 = 0;
    end;

    if u6 > 0 then
        if u6 < ServerTimeNow or not available() then
            u6 = 0;
        elseif remaining() <= 0 then
            dispatch();
        end;
    end;

    if ChickenOrHero.Game.Session:GetAttribute("AdminMatchMode") == "BladeBall" then
        local Attribute = LocalPlayer:GetAttribute("BladeHearts");
        local update = TouchActionButton.update;
        local v29;

        if type(Attribute) == "number" then
            v29 = Attribute > 0;
        else
            v29 = false;
        end;

        update(u2, v29, 0, "MELEE");
    else
        TouchActionButton.update(u2, available(), remaining(), "MELEE");
    end;

    if UserInputService.TouchEnabled then
        TouchCombatLayout.place("Melee", u2);
        TouchCombatLayout.place(BossCombat.fighting() and "Dive" or "Catch", CatchButton);

        if BoostButton then
            TouchCombatLayout.place("Catch", BoostButton);
        end;
    else
        CatchButton.Position = u27.position;
        CatchButton.Size = u27.size;
        CatchButton.AnchorPoint = u27.anchor;

        if BoostButton then
            BoostButton.Position = u28.position;
            BoostButton.Size = u28.size;
            BoostButton.AnchorPoint = u28.anchor;
        end;
    end;
end);
script.Destroying:Connect(function() -- Line: 187
    -- upvalues: ContextActionService (copy), u21 (copy), u24 (copy), u19 (copy), u20 (copy), u30 (copy), u2 (copy), CatchButton (copy), u27 (copy), BoostButton (copy), u28 (copy)
    ContextActionService:UnbindAction("CoHMelee");
    u21:Disconnect();
    u24:Disconnect();
    u19:Disconnect();
    u20:Disconnect();
    u30:Disconnect();
    u2:Destroy();
    CatchButton.Position = u27.position;
    CatchButton.Size = u27.size;
    CatchButton.AnchorPoint = u27.anchor;

    if BoostButton then
        BoostButton.Position = u28.position;
        BoostButton.Size = u28.size;
        BoostButton.AnchorPoint = u28.anchor;
    end;
end);