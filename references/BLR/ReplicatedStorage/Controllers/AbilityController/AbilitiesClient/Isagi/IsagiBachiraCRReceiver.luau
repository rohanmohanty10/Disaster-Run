  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local u1 = false;
local u2 = nil;

return function(u3, u4, u5, u6, p7) -- Line: 15
    -- upvalues: u1 (ref), Players (copy), ReplicatedStorage (copy), u2 (ref)
    if u1 or (u4.Character ~= u5 or not u3.ABC) then
        return;
    end;

    local u8;

    if u5 then
        u8 = u5:FindFirstChild("HumanoidRootPart");
    else
        u8 = u5;
    end;

    local u9;

    if u5 then
        u9 = u5:FindFirstChildOfClass("Humanoid");
    else
        u9 = u5;
    end;

    local u10;

    if u5 then
        u10 = u5:FindFirstChild("Values");
    else
        u10 = u5;
    end;

    local u11;

    if u10 then
        u11 = u10:FindFirstChild("HasBall");
    else
        u11 = u10;
    end;

    local u12;

    if u10 then
        u12 = u10:FindFirstChild("InCutscene");
    else
        u12 = u10;
    end;

    local PlayerStats = u4:FindFirstChild("PlayerStats");
    local u13;

    if PlayerStats then
        u13 = PlayerStats:FindFirstChild("Style");
    else
        u13 = PlayerStats;
    end;

    local u14;

    if PlayerStats then
        u14 = PlayerStats:FindFirstChild("InAwakening");
    else
        u14 = PlayerStats;
    end;

    local Attribute = u4:GetAttribute("CRSender");
    local Attribute2 = u4:GetAttribute("CRRequestToken");
    local u15;

    if typeof(Attribute) == "number" then
        u15 = Players:GetPlayerByUserId(Attribute) or nil;
    else
        u15 = nil;
    end;

    local u16;

    if u6 then
        u16 = u6:FindFirstChildOfClass("Humanoid");
    else
        u16 = u6;
    end;

    local u17;

    if u15 then
        u17 = u15:FindFirstChild("PlayerStats");
    else
        u17 = u15;
    end;

    local u18;

    if u17 then
        u18 = u17:FindFirstChild("Style");
    else
        u18 = u17;
    end;

    local u19;

    if u17 then
        u19 = u17:FindFirstChild("InAwakening");
    else
        u19 = u17;
    end;

    local Value = ReplicatedStorage.Football.Value;
    local v20;

    if Value then
        v20 = Value:FindFirstChild("Char");
    else
        v20 = Value;
    end;

    local v21;

    if Value then
        v21 = Value:FindFirstChild("OnPlayer");
    else
        v21 = Value;
    end;

    local v22;

    if Value then
        v22 = Value:GetAttribute("IsagiBachiraCRDeadline");
    else
        v22 = Value;
    end;

    if u4:GetAttribute("CRRequest") ~= "IsagiBachiraCR" or (typeof(Attribute2) ~= "string" or (p7 ~= Attribute2 or (typeof(Attribute) ~= "number" or not (u8 and (u9 and (u9.Health > 0 and (u11 and (not u11.Value and (u12 and (not u12.Value and (u13 and (u13.Value == "Isagi" and (u14 and (u14.Value and (not u4:GetAttribute("IsagiBachiraCRUsed") and (u15 and (u15 ~= u4 and (u4.Team and (u15.Team == u4.Team and (u6 and (u15.Character == u6 and (Players:GetPlayerFromCharacter(u6) == u15 and (u16 and (u16.Health > 0 and (u18 and (u18.Value == "Bachira" and (u19 and (not u19.Value and (Value and (Value.Parent == workspace and (Value:GetAttribute("IsagiBachiraCRToken") == Attribute2 and (typeof(v22) == "number" and (v22 >= workspace:GetServerTimeNow() and (v20 and (v20.Value == u6 and (v21 and not v21.Value)))))))))))))))))))))))))))))))))))) then
        return;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v23 = (workspace_CurrentCamera and workspace_CurrentCamera.CFrame.LookVector or u8.CFrame.LookVector) + Vector3.new(0, 0.12, 0);

    if v23.Magnitude <= 0 then
        return;
    end;

    local Unit = v23.Unit;
    u1 = true;
    u2 = Attribute2;
    local Team = u4.Team;
    local u24 = false;
    local u25 = false;
    local u26 = nil;
    local u27 = false;
    local u28 = false;
    local u29 = nil;

    local function releaseClaim() -- Line: 104
        -- upvalues: u2 (ref), Attribute2 (copy), u1 (ref)
        if u2 == Attribute2 then
            u2 = nil;
            u1 = false;
        end;
    end;

    local function disconnectCompletion() -- Line: 111
        -- upvalues: u29 (ref)
        local u30 = u29;
        u29 = nil;

        if u30 then
            pcall(function() -- Line: 115
                -- upvalues: u30 (copy)
                u30:Disconnect();
            end);
        end;
    end;

    local function participantsStillCurrent() -- Line: 121
        -- upvalues: u4 (copy), Players (ref), u5 (copy), u8 (copy), u9 (copy), Team (copy), PlayerStats (copy), u13 (copy), u14 (copy), u15 (copy), u6 (copy), u16 (copy), u17 (copy), u18 (copy), u19 (copy)
        local v31;

        if u4.Parent == Players and (u4.Character == u5 and (u5.Parent ~= nil and (u8.Parent == u5 and (u9.Parent == u5 and (u9.Health > 0 and (Team ~= nil and (u4.Team == Team and (PlayerStats.Parent == u4 and (u13.Parent == PlayerStats and (u13.Value == "Isagi" and (u14.Parent == PlayerStats and (u14.Value == true and (u15.Parent == Players and (u15 ~= u4 and (u15.Team == Team and (u15.Character == u6 and (u6.Parent ~= nil and (Players:GetPlayerFromCharacter(u6) == u15 and (u16.Parent == u6 and (u16.Health > 0 and (u17.Parent == u15 and (u18.Parent == u17 and (u18.Value == "Bachira" and u19.Parent == u17))))))))))))))))))))))) then
            v31 = u19.Value == false;
        else
            v31 = false;
        end;

        return v31;
    end;

    local function exactCompletionIsValid(p32) -- Line: 150
        -- upvalues: u6 (copy), participantsStillCurrent (copy), u4 (copy), u11 (copy), u10 (copy), u12 (copy), ReplicatedStorage (ref), u5 (copy)
        local v33;

        if p32 then
            v33 = p32:FindFirstChild("Char");
        else
            v33 = p32;
        end;

        local v34;

        if p32 then
            v34 = p32:FindFirstChild("OnPlayer");
        else
            v34 = p32;
        end;

        local v35 = u6 and u6:FindFirstChild("Values");
        local v36;

        if v35 then
            v36 = v35:FindFirstChild("InCutscene");
        else
            v36 = v35;
        end;

        local v37 = participantsStillCurrent();

        if v37 then
            if u4:GetAttribute("IsagiBachiraCRUsed") == true and (u11.Parent == u10 and (u11.Value == false and (u12.Parent == u10 and (u12.Value == false and (v36 ~= nil and (v36.Parent == v35 and (v36.Value == false and p32 ~= nil))))))) then
                v37 = p32:IsA("BasePart");

                if v37 then
                    if ReplicatedStorage.Football.Value == p32 and (p32.Parent == workspace and (v33 ~= nil and (v33.Parent == p32 and (v33.Value == u5 and (v34 ~= nil and v34.Parent == p32))))) then
                        v37 = v34.Value == false;
                    else
                        v37 = false;
                    end;
                end;
            else
                v37 = false;
            end;
        end;

        return v37;
    end;

    local function applyCompletion(p38, p39) -- Line: 176
        -- upvalues: u27 (ref), u28 (ref), u3 (copy), u29 (ref), u2 (ref), Attribute2 (copy), u1 (ref), exactCompletionIsValid (copy), Unit (copy)
        if u27 then
            return;
        end;

        u27 = true;

        if p39 and u28 then
            u3.ABC:Clean();
        else
            local u40 = u29;
            u29 = nil;

            if u40 then
                pcall(function() -- Line: 115
                    -- upvalues: u40 (copy)
                    u40:Disconnect();
                end);
            end;

            if u2 == Attribute2 then
                u2 = nil;
                u1 = false;
            end;
        end;

        if not exactCompletionIsValid(p38) then
            return;
        end;

        p38.AssemblyLinearVelocity = Unit * 180;
        u3:AbilityCooldown("1", 15);
        u3.BallController:DragBall(p38);
    end;

    u29 = u3.AbilityService.IsagiBachiraCRCompleted:Connect(function(p41, p42) -- Line: 200
        -- upvalues: Attribute2 (copy), u27 (ref), u25 (ref), u26 (ref), u24 (ref), u28 (ref), applyCompletion (copy)
        if p41 ~= Attribute2 or u27 then
            return;
        end;

        if not u25 then
            u25 = true;
            u26 = p42;
        end;

        if u24 and u28 then
            applyCompletion(u26, true);
        end;
    end);
    local success, result = pcall(function() -- Line: 213
        -- upvalues: u3 (copy), Attribute2 (copy), Attribute (copy)
        return u3.AbilityService:TryServerArmedChemicalReaction("IsagiBachiraCR", {
            Token = Attribute2,
            SenderUserId = Attribute
        });
    end);

    if not (success and (result == true and (u2 == Attribute2 and participantsStillCurrent()))) then
        local u43 = u29;
        u29 = nil;

        if u43 then
            pcall(function() -- Line: 115
                -- upvalues: u43 (copy)
                u43:Disconnect();
            end);
        end;

        if u2 == Attribute2 then
            u2 = nil;
            u1 = false;
        end;

        return;
    end;

    u24 = true;

    if u25 then
        local v44 = u26;

        if not u27 then
            u27 = true;
            local u45 = u29;
            u29 = nil;

            if u45 then
                pcall(function() -- Line: 115
                    -- upvalues: u45 (copy)
                    u45:Disconnect();
                end);
            end;

            if u2 == Attribute2 then
                u2 = nil;
                u1 = false;
            end;

            if exactCompletionIsValid(v44) then
                v44.AssemblyLinearVelocity = Unit * 180;
                u3:AbilityCooldown("1", 15);
                u3.BallController:DragBall(v44);
            end;
        end;

        return;
    end;

    u3.ABC:Clean();
    local u46 = false;
    u3.ABC:Add(function() -- Line: 239, Name: cleanup
        -- upvalues: u46 (ref), u28 (ref), u2 (ref), Attribute2 (copy), u1 (ref), u3 (copy), u8 (copy), u5 (copy)
        if u46 then
            return;
        end;

        u46 = true;
        u28 = false;

        if u2 == Attribute2 then
            u2 = nil;
            u1 = false;
        end;

        u3.Camera.Cutscene = false;
        u3.StatesController.States.Ability = false;
        u3.InAbility = false;

        if u8.Parent == u5 then
            u8.Anchored = false;
        end;
    end);
    u3.ABC:Add(u29);
    u3.StatesController.States.Ability = true;
    u3.Camera.Cutscene = true;
    u3.InAbility = true;
    u8.Anchored = true;
    u28 = true;
    u3.ABC:Connect(u4.CharacterRemoving, function(p47) -- Line: 262
        -- upvalues: u5 (copy), u3 (copy)
        if p47 == u5 then
            u3.ABC:Clean();
        end;
    end);
    u3.ABC:Connect(u9.Died, function() -- Line: 267
        -- upvalues: u3 (copy)
        u3.ABC:Clean();
    end);
    u3.ABC:Add(task.delay(20, function() -- Line: 270
        -- upvalues: u46 (ref), u3 (copy)
        if not u46 then
            u3.ABC:Clean();
        end;
    end));

    if u25 then
        applyCompletion(u26, true);
    end;
end;