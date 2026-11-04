  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.AbilityBalancing);
local LavinhoCMove = require(script.Parent.Parent.LavinhoCMove);

return function(u1, p2, p3) -- Line: 27
    -- upvalues: LavinhoCMove (copy), Popup (copy), ReplicatedStorage (copy)
    if u1.PossessionTime < 10 then
        LavinhoCMove(u1, p2, p3);

        return;
    end;

    if p2.Character.Values.HasBall.Value == false then
        return;
    end;

    if u1.AbilityOne > tick() then
        return;
    end;

    if u1.AbilityUsed > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    if (workspace.BallSpawn.Position - p3.HumanoidRootPart.Position).Magnitude > 100 then
        Popup.Popup(p2, "Must be near mid");

        return;
    end;

    u1.Camera.Cutscene = true;
    u1.InAbility = true;
    u1.StatesController.States.Ability = true;
    u1.ABC:Add(function() -- Line: 55
        -- upvalues: u1 (copy)
        u1.Camera.Cutscene = false;
        u1.InAbility = false;
        u1.StatesController.States.Ability = false;
    end);
    u1.ABC:Add(task.delay(30, function() -- Line: 61
        -- upvalues: u1 (copy)
        u1:AbilityCooldown("1", 150);
        u1.ABC:Clean();
    end));
    u1.ABC:Connect(u1.AbilityService.Ability, function(p4, p5) -- Line: 67
        -- upvalues: u1 (copy)
        u1:AbilityCooldown("1", 150);
        u1.ABC:Clean();
    end);
    print("Butterfly Dance Client");
    u1.AbilityService.Ability:Fire("ButterflyDance");
    local u6 = ReplicatedStorage.Assets.UI.ButterflyDanceUI:Clone();
    u6.Parent = p2.PlayerGui;
    u1.ABC:Add(u6);

    repeat
        task.wait();
    until u6.LeftArrow.Visible;

    local os_clock_ret = os.clock();

    local function sendChoice(p7, p8) -- Line: 91
        -- upvalues: ReplicatedStorage (ref), u6 (copy)
        print("Clicked: ", p7);
        ReplicatedStorage.ButterflyDanceChoiceRemote:FireServer(p7.Choice.Value, p8);

        for _, child in u6:GetChildren() do
            if child:IsA("ImageButton") then
                child:Destroy();
            end;
        end;
    end;

    local u9 = false;

    for _, child in u6:GetChildren() do
        if child:IsA("ImageButton") then
            child.InputBegan:Connect(function(p10) -- Line: 105
                -- upvalues: sendChoice (copy), child (copy), u9 (ref)
                if p10.UserInputType == Enum.UserInputType.MouseButton1 or (p10.UserInputType == Enum.UserInputType.Touch or p10.UserInputType == Enum.UserInputType.Gamepad1) then
                    sendChoice(child, false);
                    u9 = true;
                end;
            end);
        end;
    end;

    repeat
        task.wait();
    until u9 or os.clock() - os_clock_ret >= 3;

    if not u9 then
        for _, child in u6:GetChildren() do
            if child:IsA("ImageButton") then
                child:Destroy();
            end;
        end;

        ReplicatedStorage.ButterflyDanceChoiceRemote:FireServer(1);
    end;

    repeat
        task.wait();
    until u6:FindFirstChild("Buttons") and u6.Buttons.Visible or not u6:FindFirstChild("Buttons");

    local os_clock_ret2 = os.clock();
    local u11 = false;

    for _, child in u6.Buttons.Holder:GetChildren() do
        if child:IsA("ImageButton") then
            child.InputBegan:Connect(function(p12) -- Line: 143
                -- upvalues: sendChoice (copy), child (copy), u11 (ref), u6 (copy)
                if p12.UserInputType == Enum.UserInputType.MouseButton1 or (p12.UserInputType == Enum.UserInputType.Touch or p12.UserInputType == Enum.UserInputType.Gamepad1) then
                    sendChoice(child, true);
                    u11 = true;
                    u6:Destroy();
                end;
            end);
        end;
    end;

    repeat
        task.wait();
    until u11 or os.clock() - os_clock_ret2 >= 4;

    if not u11 then
        u6:Destroy();
        ReplicatedStorage.ButterflyDanceChoiceRemote:FireServer(1, true);
    end;
end;