  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local u1 = false;
local u2 = nil;

return function(u3, u4, u5, u6, p7) -- Line: 19, Name: ChemicalReaction
    -- upvalues: u1 (ref), Players (copy), ReplicatedStorage (copy), u2 (ref)
    if u1 or u4.Character ~= u5 then
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

    local v10;

    if u5 then
        v10 = u5:FindFirstChild("Values");
    else
        v10 = u5;
    end;

    if v10 then
        v10 = v10:FindFirstChild("InCutscene");
    end;

    local Attribute = u4:GetAttribute("CRSender");
    local Attribute2 = u4:GetAttribute("CRRequestToken");
    local u11;

    if typeof(Attribute) == "number" then
        u11 = Players:GetPlayerByUserId(Attribute) or nil;
    else
        u11 = nil;
    end;

    local u12;

    if u6 then
        u12 = u6:FindFirstChildOfClass("Humanoid");
    else
        u12 = u6;
    end;

    local u13;

    if u11 then
        u13 = u11:FindFirstChild("PlayerStats");
    else
        u13 = u11;
    end;

    local u14;

    if u13 then
        u14 = u13:FindFirstChild("Style");
    else
        u14 = u13;
    end;

    local u15;

    if u13 then
        u15 = u13:FindFirstChild("InAwakening");
    else
        u15 = u13;
    end;

    local Value = ReplicatedStorage.Football.Value;
    local v16;

    if Value then
        v16 = Value:GetAttribute("NELIsagiXHioriExpiresAt");
    else
        v16 = Value;
    end;

    if u4:GetAttribute("CRRequest") ~= "NELIsagiXHiori" or (typeof(Attribute2) ~= "string" or (p7 ~= Attribute2 or not (u8 and (u9 and (u9.Health > 0 and (v10 and (not v10.Value and (u11 and (u11.Team == u4.Team and (u4.Team and (u11.Character == u6 and (Players:GetPlayerFromCharacter(u6) == u11 and (u12 and (u12.Health > 0 and (u14 and (u14.Value == "Hiori" and (u15 and (u15.Value and (not u11:GetAttribute("NoLookUsedThisAwk") and (Value and (Value:IsDescendantOf(workspace) and (typeof(v16) == "number" and v16 >= workspace:GetServerTimeNow())))))))))))))))))))))) then
        return;
    end;

    local v17 = workspace.CurrentCamera.CFrame.LookVector + Vector3.new(0, 0.18, 0);

    if v17.Magnitude <= 0.001 then
        return;
    end;

    local Unit = v17.Unit;

    if not (u3.ABC and (typeof(u3.ABC.Clean) == "function" and (typeof(u3.ABC.Add) == "function" and (u3.AbilityService and u3.AbilityService.NELIsagiXHioriCompleted)))) then
        return;
    end;

    u3.ABC:Clean();
    local Team = u4.Team;
    local u18 = false;
    local u19 = false;
    local u20 = false;
    local u21 = false;
    local u22 = false;
    local u23 = nil;
    local u24 = {};
    u1 = true;
    u2 = Attribute2;

    local function participantsValid() -- Line: 93
        -- upvalues: u4 (copy), Players (ref), u11 (copy), Team (copy), u5 (copy), u6 (copy), u8 (copy), u9 (copy), u12 (copy), u14 (copy), u13 (copy), u15 (copy)
        local v25;

        if u4.Parent == Players and (u11.Parent == Players and (u4.Team == Team and (u11.Team == Team and (u4.Character == u5 and (u11.Character == u6 and (u8.Parent == u5 and (u9.Parent == u5 and (u9.Health > 0 and (u12.Parent == u6 and (u12.Health > 0 and (u14.Parent == u13 and (u14.Value == "Hiori" and u15.Parent == u13)))))))))))) then
            v25 = u15.Value;
        else
            v25 = false;
        end;

        return v25;
    end;

    local function cleanupState() -- Line: 111
        -- upvalues: u19 (ref), u24 (copy), u2 (ref), Attribute2 (copy), u1 (ref), u20 (ref), u3 (copy), u8 (copy), u5 (copy)
        if u19 then
            return;
        end;

        u19 = true;

        for _, v in u24 do
            v:Disconnect();
        end;

        table.clear(u24);

        if u2 == Attribute2 then
            u2 = nil;
            u1 = false;
        end;

        if u20 then
            u20 = false;
            u3.Camera.Cutscene = false;

            if u8.Parent == u5 then
                u8.Anchored = false;
            end;

            u3.StatesController.States.Ability = false;
            u3.InAbility = false;
        end;
    end;

    local function finish() -- Line: 135
        -- upvalues: u19 (ref), u21 (ref), u3 (copy), cleanupState (copy)
        if u19 then
            return false;
        end;

        if u21 then
            u3.ABC:Clean();
        else
            cleanupState();
        end;

        return true;
    end;

    local function processCompletion(p26) -- Line: 147
        -- upvalues: u19 (ref), u21 (ref), u3 (copy), cleanupState (copy), participantsValid (copy), ReplicatedStorage (ref), u5 (copy), Unit (copy)
        local v27;

        if u19 then
            v27 = false;
        elseif u21 then
            u3.ABC:Clean();
            v27 = true;
        else
            cleanupState();
            v27 = true;
        end;

        if not v27 then
            return;
        end;

        local v28;

        if p26 then
            v28 = p26:FindFirstChild("Char");
        else
            v28 = p26;
        end;

        local v29;

        if p26 then
            v29 = p26:FindFirstChild("OnPlayer");
        else
            v29 = p26;
        end;

        if not (participantsValid() and (p26 and (p26:IsA("BasePart") and (ReplicatedStorage.Football.Value == p26 and (p26.Parent == workspace and (v28 and (v28.Parent == p26 and (v28.Value == u5 and (v29 and (v29.Parent == p26 and not v29.Value)))))))))) then
            return;
        end;

        p26.AssemblyLinearVelocity = Unit * 170;
        u3:AbilityCooldown("1", 43);
        u3.BallController:DragBall(p26);
    end;

    table.insert(u24, u3.AbilityService.NELIsagiXHioriCompleted:Connect(function(p30, p31) -- Line: 175
        -- upvalues: Attribute2 (copy), u19 (ref), u18 (ref), u22 (ref), u23 (ref), processCompletion (copy)
        if p30 ~= Attribute2 or u19 then
            return;
        end;

        if u18 then
            processCompletion(p31);

            return;
        end;

        u22 = true;
        u23 = p31;
    end));
    table.insert(u24, u4.CharacterRemoving:Connect(function(p32) -- Line: 186
        -- upvalues: u5 (copy), u19 (ref), u21 (ref), u3 (copy), cleanupState (copy)
        if p32 == u5 then
            if u19 then
                return;
            end;

            if u21 then
                u3.ABC:Clean();

                return;
            end;

            cleanupState();
        end;
    end));
    table.insert(u24, u9.Died:Connect(finish));
    local success, result = pcall(function() -- Line: 193
        -- upvalues: u3 (copy), Attribute2 (copy), Attribute (copy)
        return u3.AbilityService:TryNELIsagiXHioriCR({
            Token = Attribute2,
            SenderUserId = Attribute
        });
    end);

    if u19 or not (success and (result == true and (u2 == Attribute2 and participantsValid()))) then
        if not u19 then
            if u21 then
                u3.ABC:Clean();
            else
                cleanupState();
            end;
        end;

        return;
    end;

    u18 = true;

    if u22 then
        processCompletion(u23);

        return;
    end;

    if u19 then
        return;
    end;

    u21 = true;
    u3.ABC:Add(cleanupState);
    u20 = true;

    if pcall(function() -- Line: 221
        -- upvalues: u3 (copy), u8 (copy)
        u3.StatesController.States.Ability = true;
        u8.Anchored = true;
        u3.Camera.Cutscene = true;
        u3.InAbility = true;
    end) then
        u3.ABC:Add(task.delay(17, finish));

        return;
    end;

    if not u19 then
        if u21 then
            u3.ABC:Clean();
        else
            cleanupState();
        end;
    end;
end;