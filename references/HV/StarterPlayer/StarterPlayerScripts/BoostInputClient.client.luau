 

 

local ContextActionService = game:GetService("ContextActionService");
local RunService = game:GetService("RunService");
local TouchActionButton = require(game.ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Presentation"):WaitForChild("TouchActionButton"));
local LocalPlayer = game.Players.LocalPlayer;
local BoostInput = require(game.ReplicatedStorage:WaitForChild("ChickenOrHero").Movement:WaitForChild("BoostInput"));
local BoostButton = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("HUD"):WaitForChild("BoostButton");
local Session = game.ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Game"):WaitForChild("Session");

local function bladeBall() -- Line: 13
    -- upvalues: Session (copy)
    return Session:GetAttribute("AdminMatchMode") == "BladeBall";
end;

local u1 = {
    [Enum.KeyCode.LeftShift] = true,
    [Enum.KeyCode.RightShift] = true,
    [Enum.KeyCode.ButtonL1] = true
};
local BossCombat = require(game.ReplicatedStorage.ChickenOrHero.Game:WaitForChild("BossCombat"));
local TacklePrediction = require(game.ReplicatedStorage.ChickenOrHero.Game:WaitForChild("TacklePrediction"));
local u2 = {
    [Enum.KeyCode.Space] = true,
    [Enum.KeyCode.ButtonR2] = true,
    [Enum.KeyCode.ButtonA] = true
};

local function bossFighter() -- Line: 23
    -- upvalues: BossCombat (copy), LocalPlayer (copy)
    local v3 = BossCombat.fighting();

    if v3 then
        if LocalPlayer:GetAttribute("GameRole") == "Runner" then
            v3 = LocalPlayer:GetAttribute("RunState") == "Active";
        else
            v3 = false;
        end;
    end;

    return v3;
end;

local function bossPress() -- Line: 28
    -- upvalues: BoostInput (copy), LocalPlayer (copy), TacklePrediction (copy)
    if BoostInput.turning and BoostInput.turning() then
        if BoostInput.available(LocalPlayer) then
            BoostInput.request();
        end;

        return;
    end;

    local Character = LocalPlayer.Character;

    if Character and (not Character:GetAttribute("TackleActive") and TacklePrediction.remaining() <= 0.02) then
        TacklePrediction.request();
    end;
end;

ContextActionService:BindAction("CoHBoost", function(p4, p5, p6) -- Line: 47
    -- upvalues: u2 (copy), BossCombat (copy), LocalPlayer (copy), bossPress (copy), BoostInput (copy), Session (copy), u1 (copy)
    if p6 then
        p6 = p6.KeyCode;
    end;

    if u2[p6] then
        local v7 = BossCombat.fighting();

        if v7 then
            if LocalPlayer:GetAttribute("GameRole") == "Runner" then
                v7 = LocalPlayer:GetAttribute("RunState") == "Active";
            else
                v7 = false;
            end;
        end;

        if v7 then
            if p5 == Enum.UserInputState.Begin then
                bossPress();
            end;

            return Enum.ContextActionResult.Sink;
        end;
    end;

    if p6 == Enum.KeyCode.ButtonA then
        return Enum.ContextActionResult.Pass;
    end;

    if not BoostInput.available(LocalPlayer) or Session:GetAttribute("AdminMatchMode") == "BladeBall" ~= (u1[p6] == true) then
        return Enum.ContextActionResult.Pass;
    end;

    if p5 == Enum.UserInputState.Begin and BoostInput.available(LocalPlayer) then
        BoostInput.request(nil);
    end;

    return Enum.ContextActionResult.Sink;
end, false, Enum.KeyCode.Space, Enum.KeyCode.ButtonR2, Enum.KeyCode.ButtonA, Enum.KeyCode.LeftShift, Enum.KeyCode.RightShift, Enum.KeyCode.ButtonL1);
local u9 = TouchActionButton.bind(BoostButton, function(p8) -- Line: 40, Name: request
    -- upvalues: BoostInput (copy), LocalPlayer (copy)
    if not BoostInput.available(LocalPlayer) then
        return false;
    end;

    BoostInput.request(p8);

    return true;
end);
local u10 = 0;
local u15 = RunService.RenderStepped:Connect(function(p11) -- Line: 68
    -- upvalues: u10 (ref), BoostInput (copy), LocalPlayer (copy), TouchActionButton (copy), BoostButton (copy), Session (copy)
    u10 = u10 + p11;

    if u10 < 0.08 then
        return;
    end;

    u10 = 0;
    local v12 = BoostInput.available(LocalPlayer);
    local Character = LocalPlayer.Character;
    local v13 = (Character and Character:GetAttribute("DashCooldownUntil") or 0) - os.clock();
    local math_max_ret = math.max(0, v13);
    local update = TouchActionButton.update;

    if v12 then
        local v14 = Session:GetAttribute("AdminMatchMode") == "BladeBall";
        v12 = not v14;
    end;

    update(BoostButton, v12, math_max_ret, "DASH");
end);
script.Destroying:Connect(function() -- Line: 80
    -- upvalues: BoostInput (copy), ContextActionService (copy), u9 (copy), u15 (copy), BoostButton (copy)
    BoostInput.clear();
    ContextActionService:UnbindAction("CoHBoost");
    u9:Disconnect();
    u15:Disconnect();
    BoostButton.Visible = false;
end);