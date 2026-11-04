  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local HttpService = game:GetService("HttpService");
local Magnus = require(ReplicatedStorage.AbilityBalancing).Magnus;
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local u1 = false;
local u2 = nil;

return function(u3, u4, u5) -- Line: 14
    -- upvalues: u1 (ref), AbilityUtils (copy), Players (copy), Magnus (copy), HttpService (copy), u2 (ref), ReplicatedStorage (copy)
    if u1 or u4:GetAttribute("CRRequest") ~= "KaiserKiyoraCR" then
        return;
    end;

    local v6;

    if u5 then
        v6 = u5:FindFirstChild("HumanoidRootPart");
    else
        v6 = u5;
    end;

    local u7;

    if u5 then
        u7 = u5:FindFirstChild("Humanoid");
    else
        u7 = u5;
    end;

    local v8;

    if u5 then
        v8 = u5:FindFirstChild("Values");
    else
        v8 = u5;
    end;

    if v8 then
        v8 = v8:FindFirstChild("HasBall");
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Attribute = u4:GetAttribute("KaiserKiyoraCRArmToken");

    if u4.Character ~= u5 or not (v6 and (u7 and (u7.Health > 0 and (v8 and (v8.Value and (workspace_CurrentCamera and (typeof(Attribute) == "string" and AbilityUtils.rules.grounded(u4)))))))) then
        return;
    end;

    local Attribute2 = u4:GetAttribute("CRSender");
    local v9;

    if typeof(Attribute2) == "number" then
        v9 = Players:GetPlayerByUserId(Attribute2) or nil;
    else
        v9 = nil;
    end;

    local v10;

    if v9 then
        v10 = v9:FindFirstChild("PlayerStats");
    else
        v10 = v9;
    end;

    if not (v9 and (v9 ~= u4 and (v9.Team == u4.Team and (v10 and (v10:FindFirstChild("Style") and v10.Style.Value == "Kiyora"))))) then
        return;
    end;

    local v11 = workspace_CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1);

    if v11.Magnitude < 0.001 then
        v11 = v6.CFrame.LookVector * Vector3.new(1, 0, 1);
    end;

    local v12 = v11 + Magnus.ShotTiltVector;

    if v12.Magnitude < 0.001 then
        return;
    end;

    local Unit = v12.Unit;

    if u3.ABC then
        u3.ABC:Clean();
    end;

    local u13 = HttpService:GenerateGUID(false);
    local u14 = false;
    local u15 = false;
    local u16 = false;
    local u17 = false;
    local u18 = nil;
    u1 = true;
    u2 = u13;
    u3.ABC:Add(function() -- Line: 76, Name: cleanupState
        -- upvalues: u14 (ref), u2 (ref), u13 (copy), u1 (ref), u16 (ref), u3 (copy), u5 (copy)
        if u14 then
            return;
        end;

        u14 = true;

        if u2 == u13 then
            u2 = nil;
            u1 = false;
        end;

        if u16 then
            u16 = false;
            u3.Camera.Cutscene = false;
            u3.StatesController.States.Ability = false;
            u3.InAbility = false;
            local v19 = u5 and u5:FindFirstChild("HumanoidRootPart");

            if v19 and v19.Anchored then
                v19.Anchored = false;
            end;
        end;
    end);

    local function finish() -- Line: 99
        -- upvalues: u14 (ref), u3 (copy)
        if u14 then
            return false;
        end;

        u3.ABC:Clean();

        return true;
    end;

    local function handleCompletion(p20) -- Line: 107
        -- upvalues: u14 (ref), u3 (copy), u4 (copy), u5 (copy), u7 (copy), ReplicatedStorage (ref), Unit (copy), Magnus (ref)
        local v21;

        if u14 then
            v21 = false;
        else
            u3.ABC:Clean();
            v21 = true;
        end;

        if not v21 then
            return;
        end;

        local v22;

        if p20 then
            v22 = p20:FindFirstChild("Char");
        else
            v22 = p20;
        end;

        local v23;

        if p20 then
            v23 = p20:FindFirstChild("OnPlayer");
        else
            v23 = p20;
        end;

        if u4.Character ~= u5 or (u7.Health <= 0 or not (p20 and (p20:IsA("BasePart") and (ReplicatedStorage.Football.Value == p20 and (p20.Parent == workspace and (v22 and (v22.Value == u5 and (v23 and not v23.Value)))))))) then
            return;
        end;

        p20.AssemblyLinearVelocity = Unit * Magnus.ShotPower;
        u3:AbilityCooldown("3", Magnus.Cooldown);
        u3.BallController:DragBall(p20);
    end;

    u3.ABC:Connect(u3.AbilityService.KaiserKiyoraCRCompleted, function(p24, p25) -- Line: 132
        -- upvalues: u13 (copy), u15 (ref), u17 (ref), u18 (ref), handleCompletion (copy)
        if p24 ~= u13 then
            return;
        end;

        if u15 then
            handleCompletion(p25);

            return;
        end;

        u17 = true;
        u18 = p25;
    end);
    u3.ABC:Connect(u4.CharacterRemoving, function(p26) -- Line: 144
        -- upvalues: u5 (copy), u14 (ref), u3 (copy)
        if p26 == u5 then
            if u14 then
                return;
            end;

            u3.ABC:Clean();
        end;
    end);
    u3.ABC:Connect(u7.Died, finish);
    local success, result = pcall(function() -- Line: 153
        -- upvalues: u3 (copy), u13 (copy), Attribute (copy)
        return u3.AbilityService:TryKaiserKiyoraCR({
            RequestId = u13,
            ArmToken = Attribute
        });
    end);

    if u14 then
        return;
    end;

    if not success or result ~= true then
        if not u14 then
            u3.ABC:Clean();
        end;

        return;
    end;

    u15 = true;

    if u17 then
        handleCompletion(u18);

        return;
    end;

    if u14 then
        return;
    end;

    u16 = true;
    u3.StatesController.States.Ability = true;
    u3.Camera.Cutscene = true;
    u3.InAbility = true;
    u3.ABC:Add(task.delay(30, finish));
end;