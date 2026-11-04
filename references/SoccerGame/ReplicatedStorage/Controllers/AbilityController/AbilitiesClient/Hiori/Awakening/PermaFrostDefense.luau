  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local BallController = require(ReplicatedStorage.Controllers.BallController);
local Popup = require(ReplicatedStorage.Shared.Popup);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;

return function() -- Line: 23
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), LocalPlayer (copy), Popup (copy), interface (copy), BallController (copy), ReplicatedStorage (copy)
    local PermaFrostDefense = AbilityBalancing.PermaFrostDefense;
    local _, v1, _, v2 = AbilityUtils.getCharacter(LocalPlayer);

    if not (v2 and (v2:FindFirstChild("IsInPenalty") and v2.IsInPenalty.Value)) then
        Popup.Popup(LocalPlayer, "Must be near the GK box!");

        return;
    end;

    local Team = LocalPlayer.Team;
    local SmallSquare = workspace:FindFirstChild("SmallSquare");

    if Team and (v1 and SmallSquare) then
        local v3 = (1 / 0);
        local v4 = (1 / 0);

        for _, child in ipairs(SmallSquare:GetChildren()) do
            if child:IsA("BasePart") then
                local Magnitude = (v1.Position - child.Position).Magnitude;

                if string.find(child.Name, Team.Name) then
                    v3 = math.min(v3, Magnitude);
                else
                    v4 = math.min(v4, Magnitude);
                end;
            end;
        end;

        if v4 < v3 then
            Popup.Popup(LocalPlayer, "Must be in your OWN goal box!");

            return;
        end;
    end;

    if not (AbilityUtils.rules.grounded(LocalPlayer) and (AbilityUtils.rules.looseBall(LocalPlayer, PermaFrostDefense.Range) and (AbilityUtils.rules.slotReady(1) and AbilityUtils.rules.isAwakened(LocalPlayer)))) then
        return;
    end;

    interface.AbilityService.Ability:Fire(script.Name);
    AbilityUtils.clientCutsceneSkill(interface, PermaFrostDefense, 10, 1, false, nil, true);
    local ABC = interface.ABC;
    ABC:Connect(interface.AbilityService.Ability, function(p5) -- Line: 75
        -- upvalues: LocalPlayer (ref), PermaFrostDefense (copy), BallController (ref), ReplicatedStorage (ref), ABC (copy)
        if not p5 then
            return;
        end;

        local Character = LocalPlayer.Character;

        if Character then
            Character = Character:FindFirstChild("HumanoidRootPart");
        end;

        if not Character then
            return;
        end;

        p5.AssemblyLinearVelocity = (Character.CFrame.LookVector + PermaFrostDefense.ShotTiltVector) * PermaFrostDefense.ShotPower;
        BallController:DragBall(ReplicatedStorage.Football.Value);
        ABC:Clean();
    end);
end;