 

 

local ContextActionService = game:GetService("ContextActionService");
local RunService = game:GetService("RunService");
local LocalPlayer = game.Players.LocalPlayer;
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local ControlGate = require(ChickenOrHero:WaitForChild("Movement"):WaitForChild("ControlGate"));
local TacklePrediction = require(ChickenOrHero:WaitForChild("Game"):WaitForChild("TacklePrediction"));
local TouchActionButton = require(ChickenOrHero:WaitForChild("Presentation"):WaitForChild("TouchActionButton"));
local CatchButton = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("HUD"):WaitForChild("CatchButton");
local Session = ChickenOrHero:WaitForChild("Game"):WaitForChild("Session");
local BoostInput = require(ChickenOrHero:WaitForChild("Movement"):WaitForChild("BoostInput"));
local BossCombat = require(ChickenOrHero:WaitForChild("Game"):WaitForChild("BossCombat"));
local u1 = {
    [Enum.KeyCode.Space] = true,
    [Enum.KeyCode.E] = true,
    [Enum.KeyCode.ButtonR2] = true
};

local function bladeBall() -- Line: 19
    -- upvalues: Session (copy)
    return Session:GetAttribute("AdminMatchMode") == "BladeBall";
end;

local function jump() -- Line: 22
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChildOfClass("Humanoid");
    end;

    if Character and (Character.Health > 0 and (Character.FloorMaterial ~= Enum.Material.Air and Character:GetStateEnabled(Enum.HumanoidStateType.Jumping))) then
        Character:ChangeState(Enum.HumanoidStateType.Jumping);
    end;
end;

local function available() -- Line: 29
    -- upvalues: LocalPlayer (copy), BossCombat (copy), ControlGate (copy)
    local Character = LocalPlayer.Character;
    local v2;

    if Character then
        v2 = Character:FindFirstChildOfClass("Humanoid");
    else
        v2 = Character;
    end;

    local v3 = BossCombat.attacker(LocalPlayer);

    if v3 then
        if LocalPlayer:GetAttribute("RunState") == "Active" and (v2 ~= nil and v2.Health > 0) then
            v3 = not (v2.Sit or (v2.PlatformStand or Character:GetAttribute("MovementLocked"))) and ControlGate.reason(LocalPlayer) == nil;
        else
            v3 = false;
        end;
    end;

    return v3;
end;

local function remaining() -- Line: 41
    -- upvalues: TacklePrediction (copy)
    return TacklePrediction.remaining();
end;

local function request() -- Line: 44
    -- upvalues: available (copy), TacklePrediction (copy), LocalPlayer (copy)
    if not available() or TacklePrediction.remaining() > 0.02 then
        return;
    end;

    local Character = LocalPlayer.Character;
    local v4;

    if Character then
        v4 = Character:FindFirstChild("HumanoidRootPart");
    else
        v4 = Character;
    end;

    if not v4 or (v4.Anchored or Character:GetAttribute("TackleActive")) then
        return;
    end;

    TacklePrediction.request();
end;

ContextActionService:BindAction("CoHTackle", function(p5, p6, p7) -- Line: 55
    -- upvalues: Session (copy), available (copy), BossCombat (copy), u1 (copy), jump (copy), request (copy)
    local v8 = Session:GetAttribute("AdminMatchMode") == "BladeBall";

    if not available() or p7 and (p7.KeyCode == Enum.KeyCode.ButtonX and not v8) then
        return Enum.ContextActionResult.Pass;
    end;

    if p7 then
        p7 = p7.KeyCode;
    end;

    if BossCombat.fighting() then
        if u1[p7] then
            return Enum.ContextActionResult.Pass;
        end;
    elseif p7 == Enum.KeyCode.F then
        return Enum.ContextActionResult.Pass;
    end;

    if p6 == Enum.UserInputState.Begin then
        if v8 then
            jump();
        else
            request();
        end;
    end;

    return Enum.ContextActionResult.Sink;
end, false, Enum.KeyCode.Space, Enum.KeyCode.E, Enum.KeyCode.F, Enum.KeyCode.ButtonR2, Enum.KeyCode.ButtonX);
local u9 = TouchActionButton.bind(CatchButton, function() -- Line: 78
    -- upvalues: Session (copy), BoostInput (copy), LocalPlayer (copy), request (copy)
    if Session:GetAttribute("AdminMatchMode") == "BladeBall" then
        if BoostInput.available(LocalPlayer) then
            BoostInput.request(true);
        end;

        return;
    end;

    request();
end);
local u10 = 0;
local u13 = RunService.RenderStepped:Connect(function(p11) -- Line: 88
    -- upvalues: u10 (ref), Session (copy), LocalPlayer (copy), TouchActionButton (copy), CatchButton (copy), BoostInput (copy), available (copy), TacklePrediction (copy)
    u10 = u10 + p11;

    if u10 < 0.08 then
        return;
    end;

    u10 = 0;

    if Session:GetAttribute("AdminMatchMode") ~= "BladeBall" then
        TouchActionButton.update(CatchButton, available(), TacklePrediction.remaining(), "DIVE");

        return;
    end;

    local Character = LocalPlayer.Character;
    local v12 = (Character and Character:GetAttribute("DashCooldownUntil") or 0) - os.clock();
    local math_max_ret = math.max(0, v12);
    TouchActionButton.update(CatchButton, BoostInput.available(LocalPlayer), math_max_ret, "DASH");
end);
script.Destroying:Connect(function() -- Line: 103
    -- upvalues: ContextActionService (copy), u9 (copy), u13 (copy), CatchButton (copy)
    ContextActionService:UnbindAction("CoHTackle");
    u9:Disconnect();
    u13:Disconnect();
    CatchButton.Visible = false;
end);