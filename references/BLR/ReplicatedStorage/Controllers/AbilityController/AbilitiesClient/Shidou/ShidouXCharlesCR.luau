  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local u1 = false;
local u2 = nil;

return function(u3, u4, u5) -- Line: 12
    -- upvalues: u1 (ref), AbilityBalancing (copy), u2 (ref), ReplicatedStorage (copy)
    if u1 or u4:GetAttribute("CRRequest") ~= "ShidouXCharlesCR" then
        return;
    end;

    local Attribute = u4:GetAttribute("CRRequestToken");
    local Attribute2 = u4:GetAttribute("CRSender");
    local u6;

    if u5 then
        u6 = u5:FindFirstChild("HumanoidRootPart");
    else
        u6 = u5;
    end;

    local u7;

    if u5 then
        u7 = u5:FindFirstChildOfClass("Humanoid");
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
        v8 = v8:FindFirstChild("InCutscene");
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Attribute3 = u4:GetAttribute("ShidouXCharlesCRReadyAt");

    if u4.Character ~= u5 or (typeof(Attribute) ~= "string" or (typeof(Attribute2) ~= "number" or not (u6 and (u7 and (u7.Health > 0 and (v8 and (not v8.Value and (workspace_CurrentCamera and (u3.ABC and (typeof(Attribute3) ~= "number" or workspace:GetServerTimeNow() >= Attribute3)))))))))) then
        return;
    end;

    local ShidouXCharlesCR = AbilityBalancing.ShidouXCharlesCR;
    local v9 = workspace_CurrentCamera.CFrame.LookVector + ShidouXCharlesCR.ShotTiltVector;

    if v9.Magnitude < 0.001 then
        return;
    end;

    local Unit = v9.Unit;
    local u10 = {};
    u1 = true;
    u2 = u10;
    local u11 = false;
    local u12 = false;
    local u13 = false;
    local u14 = nil;
    local u15 = false;
    local u16 = nil;
    local u17 = nil;
    local u18 = nil;
    local u19 = nil;

    local function clearAttempt() -- Line: 63
        -- upvalues: u2 (ref), u10 (copy), u1 (ref)
        if u2 == u10 then
            u2 = nil;
            u1 = false;
        end;
    end;

    local function disconnectConnection(p20) -- Line: 70
        if p20 then
            p20:Disconnect();
        end;
    end;

    local function disconnectPreResponseCancellation() -- Line: 76
        -- upvalues: u18 (ref), u19 (ref)
        local v21 = u18;

        if v21 then
            v21:Disconnect();
        end;

        local v22 = u19;

        if v22 then
            v22:Disconnect();
        end;

        u18 = nil;
        u19 = nil;
    end;

    local function disconnectCompletion() -- Line: 83
        -- upvalues: u17 (ref)
        local v23 = u17;

        if v23 then
            v23:Disconnect();
        end;

        u17 = nil;
    end;

    local function cancelBeforeResponse() -- Line: 88
        -- upvalues: u11 (ref), u13 (ref), u18 (ref), u19 (ref), u17 (ref), u2 (ref), u10 (copy), u1 (ref)
        if u11 or u13 then
            return;
        end;

        u13 = true;
        local v24 = u18;

        if v24 then
            v24:Disconnect();
        end;

        local v25 = u19;

        if v25 then
            v25:Disconnect();
        end;

        u18 = nil;
        u19 = nil;
        local v26 = u17;

        if v26 then
            v26:Disconnect();
        end;

        u17 = nil;

        if u2 == u10 then
            u2 = nil;
            u1 = false;
        end;
    end;

    local v27 = u3.AbilityService and u3.AbilityService.ShidouXCharlesCRCompleted;

    if not v27 or typeof(v27.Connect) ~= "function" then
        if u2 == u10 then
            u2 = nil;
            u1 = false;
        end;

        return;
    end;

    u17 = v27:Connect(function(p28, p29) -- Line: 106
        -- upvalues: Attribute (copy), u13 (ref), u14 (ref), u12 (ref), u16 (ref)
        if p28 ~= Attribute or u13 then
            return;
        end;

        if not u14 then
            u14 = {
                Token = p28,
                Ball = p29
            };
        end;

        if u12 and u16 then
            u16(u14);
        end;
    end);
    u18 = u4.CharacterRemoving:Connect(function(p30) -- Line: 120
        -- upvalues: u5 (copy), u11 (ref), u13 (ref), u18 (ref), u19 (ref), u17 (ref), u2 (ref), u10 (copy), u1 (ref)
        if p30 == u5 and not u11 then
            if u13 then
                return;
            end;

            u13 = true;
            local v31 = u18;

            if v31 then
                v31:Disconnect();
            end;

            local v32 = u19;

            if v32 then
                v32:Disconnect();
            end;

            u18 = nil;
            u19 = nil;
            local v33 = u17;

            if v33 then
                v33:Disconnect();
            end;

            u17 = nil;

            if u2 == u10 then
                u2 = nil;
                u1 = false;
            end;
        end;
    end);
    u19 = u7.Died:Connect(cancelBeforeResponse);
    local success, result = pcall(function() -- Line: 129
        -- upvalues: u3 (copy), Attribute (copy), Attribute2 (copy)
        return u3.AbilityService:TryServerArmedChemicalReaction("ShidouXCharlesCR", {
            Token = Attribute,
            SenderUserId = Attribute2
        });
    end);
    u11 = true;
    local v34 = u18;

    if v34 then
        v34:Disconnect();
    end;

    local v35 = u19;

    if v35 then
        v35:Disconnect();
    end;

    u18 = nil;
    u19 = nil;

    if u2 ~= u10 or u13 then
        local v36 = u17;

        if v36 then
            v36:Disconnect();
        end;

        u17 = nil;

        if u2 == u10 then
            u2 = nil;
            u1 = false;
        end;

        return;
    end;

    if not (success and (result == true and (u4.Character == u5 and u7.Health > 0))) then
        local v37 = u17;

        if v37 then
            v37:Disconnect();
        end;

        u17 = nil;

        if u2 == u10 then
            u2 = nil;
            u1 = false;
        end;

        return;
    end;

    if u3.ABC then
        u3.ABC:Clean();
    end;

    u3.DragonHeader = false;
    local u38 = false;
    local u39 = true;
    u3.ABC:Add(function() -- Line: 160, Name: cleanupState
        -- upvalues: u38 (ref), u18 (ref), u19 (ref), u17 (ref), u2 (ref), u10 (copy), u1 (ref), u39 (ref), u3 (copy), u6 (copy), u5 (copy)
        if u38 then
            return;
        end;

        u38 = true;
        local v40 = u18;

        if v40 then
            v40:Disconnect();
        end;

        local v41 = u19;

        if v41 then
            v41:Disconnect();
        end;

        u18 = nil;
        u19 = nil;
        local v42 = u17;

        if v42 then
            v42:Disconnect();
        end;

        u17 = nil;

        if u2 == u10 then
            u2 = nil;
            u1 = false;
        end;

        if u39 then
            u39 = false;
            u3.Camera.Cutscene = false;
            u3.StatesController.States.Ability = false;
            u3.InAbility = false;

            if u6.Parent == u5 and u6.Anchored then
                u6.Anchored = false;
            end;
        end;
    end);
    u3.StatesController.States.Ability = true;
    u3.Camera.Cutscene = true;
    u3.InAbility = true;

    local function finish() -- Line: 184
        -- upvalues: u38 (ref), u3 (copy)
        if u38 then
            return false;
        end;

        u3.ABC:Clean();

        return true;
    end;

    local function exactCompletionBallValid(p43) -- Line: 192
        -- upvalues: u4 (copy), u5 (copy), u7 (copy), ReplicatedStorage (ref)
        local v44;

        if p43 then
            v44 = p43:FindFirstChild("Char");
        else
            v44 = p43;
        end;

        local v45;

        if p43 then
            v45 = p43:FindFirstChild("OnPlayer");
        else
            v45 = p43;
        end;

        if u4.Character == u5 and u7.Health > 0 then
            local v46 = p43 and p43:IsA("BasePart");

            if v46 then
                if ReplicatedStorage.Football.Value == p43 and p43.Parent == workspace then
                    if v44 then
                        if v44.Value == u5 then
                            if v45 then
                                v45 = not v45.Value;
                            end;
                        else
                            v45 = false;
                        end;
                    else
                        v45 = v44;
                    end;
                else
                    v45 = false;
                end;
            else
                v45 = v46;
            end;
        else
            v45 = false;
        end;

        return v45;
    end;

    u16 = function(p47) -- Line: 207
        -- upvalues: u15 (ref), Attribute (copy), u38 (ref), u3 (copy), exactCompletionBallValid (copy), Unit (copy), ShidouXCharlesCR (copy)
        if u15 or (typeof(p47) ~= "table" or p47.Token ~= Attribute) then
            return;
        end;

        u15 = true;
        local Ball = p47.Ball;
        local v48;

        if u38 then
            v48 = false;
        else
            u3.ABC:Clean();
            v48 = true;
        end;

        if not v48 then
            return;
        end;

        if not exactCompletionBallValid(Ball) then
            return;
        end;

        Ball.AssemblyLinearVelocity = Unit * ShidouXCharlesCR.ShotPower;
        u3:AbilityCooldown("2", 5);
        u3.BallController:DragBall(Ball);
    end;

    u3.ABC:Connect(u4.CharacterRemoving, function(p49) -- Line: 231
        -- upvalues: u5 (copy), u38 (ref), u3 (copy)
        if p49 == u5 then
            if u38 then
                return;
            end;

            u3.ABC:Clean();
        end;
    end);
    u3.ABC:Connect(u7.Died, finish);
    u3.ABC:Add(task.delay(15, finish));
    u12 = true;

    if u14 then
        u16(u14);
    end;
end;