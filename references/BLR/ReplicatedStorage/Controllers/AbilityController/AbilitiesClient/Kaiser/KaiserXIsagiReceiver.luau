  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Teams = game:GetService("Teams");
local KaiserCRShot = require(ReplicatedStorage.AbilityBalancing).KaiserCRShot;
local Popup = require(ReplicatedStorage.Shared.Popup);

return function(u1, u2, u3, u4, p5) -- Line: 11
    -- upvalues: Players (copy), Teams (copy), ReplicatedStorage (copy), KaiserCRShot (copy), Popup (copy), RunService (copy)
    if u1.UsingCRMove then
        return false;
    end;

    local u6;

    if u4 then
        u6 = Players:GetPlayerFromCharacter(u4);
    else
        u6 = u4;
    end;

    local Team = u2.Team;
    local Visitor = Teams:FindFirstChild("Visitor");
    local u7;

    if u3 then
        u7 = u3:FindFirstChild("HumanoidRootPart");
    else
        u7 = u3;
    end;

    local u8;

    if u3 then
        u8 = u3:FindFirstChildOfClass("Humanoid");
    else
        u8 = u3;
    end;

    local u9;

    if u3 then
        u9 = u3:FindFirstChild("Values");
    else
        u9 = u3;
    end;

    local u10;

    if u9 then
        u10 = u9:FindFirstChild("HasBall");
    else
        u10 = u9;
    end;

    local u11;

    if u9 then
        u11 = u9:FindFirstChild("InCutscene");
    else
        u11 = u9;
    end;

    local PlayerStats = u2:FindFirstChild("PlayerStats");
    local u12;

    if PlayerStats then
        u12 = PlayerStats:FindFirstChild("Style");
    else
        u12 = PlayerStats;
    end;

    local u13;

    if u4 then
        u13 = u4:FindFirstChild("HumanoidRootPart");
    else
        u13 = u4;
    end;

    local u14;

    if u4 then
        u14 = u4:FindFirstChildOfClass("Humanoid");
    else
        u14 = u4;
    end;

    local u15;

    if u4 then
        u15 = u4:FindFirstChild("Values");
    else
        u15 = u4;
    end;

    local u16;

    if u15 then
        u16 = u15:FindFirstChild("InCutscene");
    else
        u16 = u15;
    end;

    local u17;

    if u6 then
        u17 = u6:FindFirstChild("PlayerStats");
    else
        u17 = u6;
    end;

    local u18;

    if u17 then
        u18 = u17:FindFirstChild("Style");
    else
        u18 = u17;
    end;

    local Football = ReplicatedStorage:FindFirstChild("Football");
    local u19;

    if Football then
        u19 = Football.Value;
    else
        u19 = Football;
    end;

    local u20;

    if u19 then
        u20 = u19:FindFirstChild("Char");
    else
        u20 = u19;
    end;

    local u21;

    if u19 then
        u21 = u19:FindFirstChild("OnPlayer");
    else
        u21 = u19;
    end;

    local u22 = KaiserCRShot and KaiserCRShot.ActivationRangeBall;
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local u23 = u1.Animations and u1.Animations.Abilities and u1.Animations.Abilities.NELIsagixKaiserCRTarget;

    local function contextValid() -- Line: 44
        -- upvalues: u2 (copy), Players (ref), u6 (copy), Team (copy), Visitor (copy), u3 (copy), u4 (copy), u8 (copy), u14 (copy), u7 (copy), u13 (copy), u12 (copy), PlayerStats (copy), u18 (copy), u17 (copy), u11 (copy), u9 (copy), u16 (copy), u15 (copy), Football (copy), u19 (copy), u20 (copy), u21 (copy)
        local v24;

        if u2.Parent == Players then
            v24 = u6;

            if v24 then
                if u6.Parent == Players and u6 ~= u2 then
                    v24 = Team;

                    if v24 then
                        if Team == Visitor or (u2.Team ~= Team or (u6.Team ~= Team or (u2.Character ~= u3 or u6.Character ~= u4))) then
                            v24 = false;
                        else
                            v24 = u3 and (u3.Parent and u4 and (u4.Parent and u8));

                            if v24 then
                                if u8.Parent == u3 and u8.Health > 0 then
                                    v24 = u14;

                                    if v24 then
                                        if u14.Parent == u4 and u14.Health > 0 then
                                            v24 = u7;

                                            if v24 then
                                                if u7.Parent == u3 then
                                                    v24 = u13;

                                                    if v24 then
                                                        if u13.Parent == u4 then
                                                            v24 = u12;

                                                            if v24 then
                                                                if u12.Parent == PlayerStats and u12.Value == "Kaiser" then
                                                                    v24 = u18;

                                                                    if v24 then
                                                                        if u18.Parent == u17 and u18.Value == "Isagi" then
                                                                            v24 = u11;

                                                                            if v24 then
                                                                                if u11.Parent == u9 then
                                                                                    v24 = not u11.Value and u16;

                                                                                    if v24 then
                                                                                        if u16.Parent == u15 then
                                                                                            v24 = not u16.Value and Football;

                                                                                            if v24 then
                                                                                                if Football.Value == u19 then
                                                                                                    v24 = u19 and u19:IsA("BasePart") and (u19.Parent and u20);

                                                                                                    if v24 then
                                                                                                        if u20.Parent == u19 then
                                                                                                            v24 = u21 and u21.Parent == u19;
                                                                                                        else
                                                                                                            v24 = false;
                                                                                                        end;
                                                                                                    end;
                                                                                                else
                                                                                                    v24 = false;
                                                                                                end;
                                                                                            end;
                                                                                        else
                                                                                            v24 = false;
                                                                                        end;
                                                                                    end;
                                                                                else
                                                                                    v24 = false;
                                                                                end;
                                                                            end;
                                                                        else
                                                                            v24 = false;
                                                                        end;
                                                                    end;
                                                                else
                                                                    v24 = false;
                                                                end;
                                                            end;
                                                        else
                                                            v24 = false;
                                                        end;
                                                    end;
                                                else
                                                    v24 = false;
                                                end;
                                            end;
                                        else
                                            v24 = false;
                                        end;
                                    end;
                                else
                                    v24 = false;
                                end;
                            end;
                        end;
                    end;
                else
                    v24 = false;
                end;
            end;
        else
            v24 = false;
        end;

        return v24;
    end;

    local function ballStateValid() -- Line: 92
        -- upvalues: u21 (copy), u19 (copy), u4 (copy), u20 (copy), u3 (copy), u10 (copy)
        if u21.Value then
            local v25;

            if u19.Parent == u4 and u20.Value == u4 then
                v25 = true;
            elseif u19.Parent == u3 and u20.Value == u3 then
                v25 = u10 and u10.Value;
            else
                v25 = false;
            end;

            return v25;
        end;

        local v26;

        if u19.Parent == workspace then
            v26 = u20.Value == u4;
        else
            v26 = false;
        end;

        return v26;
    end;

    local function passArrived() -- Line: 100
        -- upvalues: u19 (copy), u7 (copy), u22 (copy), u20 (copy), u4 (copy), u21 (copy), u3 (copy)
        if u22 < (u19.Position - u7.Position).Magnitude then
            return false;
        end;

        local v27 = u19.Parent == workspace and (u20.Value == u4 and not u21.Value);

        if not v27 then
            if u19.Parent == u3 and u20.Value == u3 then
                v27 = u21.Value;
            else
                v27 = false;
            end;
        end;

        return v27;
    end;

    if contextValid() then
        local v28;

        if u21.Value then
            if u19.Parent == u4 and u20.Value == u4 then
                v28 = true;
            elseif u19.Parent == u3 and u20.Value == u3 then
                if u10 then
                    v28 = u10.Value;
                else
                    v28 = u10;
                end;
            else
                v28 = false;
            end;
        elseif u19.Parent == workspace then
            v28 = u20.Value == u4;
        else
            v28 = false;
        end;

        if v28 and (typeof(u22) == "number" and (workspace_CurrentCamera and (u23 and (u1.ABC and (typeof(u1.ABC.Clean) == "function" and (typeof(u1.ABC.Add) == "function" and (typeof(u1.ABC.Connect) == "function" and (u1.StatesController and (u1.StatesController.States and (u1.BallController and (typeof(u1.BallController.DragBall) == "function" and (u1.AbilityService and (u1.AbilityService.Ability and (typeof(u1.Animations.StopAnims) == "function" and typeof(p5) == "function")))))))))))))) then
            u1.UsingCRMove = true;

            local function fail(p29) -- Line: 131
                -- upvalues: u1 (copy), Popup (ref), u2 (copy)
                u1.UsingCRMove = false;

                if p29 then
                    pcall(Popup.Popup, u2, "Chemical Reaction Failed");
                end;

                return false;
            end;

            pcall(Popup.Popup, u2, "Prepare to shoot!");
            local v30 = os.clock() + 3;
            local v31 = false;

            while true do
                if os.clock() > v30 then
                    if v31 and contextValid() then
                        if u21.Value then
                            if u19.Parent == u4 and u20.Value == u4 then
                                u10 = true;
                            elseif u19.Parent == u3 and u20.Value == u3 then
                                if u10 then
                                    u10 = u10.Value;
                                end;
                            else
                                u10 = false;
                            end;
                        elseif u19.Parent == workspace then
                            u10 = u20.Value == u4;
                        else
                            u10 = false;
                        end;

                        if u10 then
                            local v32;

                            if u22 < (u19.Position - u7.Position).Magnitude then
                                v32 = false;
                            else
                                v32 = u19.Parent == workspace and u20.Value == u4 and not u21.Value;

                                if not v32 then
                                    if u19.Parent == u3 and u20.Value == u3 then
                                        v32 = u21.Value;
                                    else
                                        v32 = false;
                                    end;
                                end;
                            end;

                            if v32 then
                                local success, result = pcall(p5);

                                if not (success and (typeof(result) == "table" and result.Ok == true)) then
                                    u1.UsingCRMove = false;
                                    pcall(Popup.Popup, u2, "Chemical Reaction Failed");

                                    return false;
                                end;

                                if not contextValid() then
                                    u1.UsingCRMove = false;

                                    return false;
                                end;

                                u1.ABC:Clean();
                                u1.UsingCRMove = true;
                                u1.StatesController.States.Ability = true;
                                local u33 = false;

                                local function clean() -- Line: 177
                                    -- upvalues: u1 (copy)
                                    u1.ABC:Clean();
                                end;

                                u1.ABC:Add(function() -- Line: 181
                                    -- upvalues: u1 (copy), u23 (copy)
                                    u1.UsingCRMove = false;
                                    u1.StatesController.States.Ability = false;
                                    pcall(function() -- Line: 184
                                        -- upvalues: u23 (ref)
                                        if u23.IsPlaying then
                                            u23:Stop();
                                        end;
                                    end);
                                end);
                                u1.ABC:Add(task.delay(8, clean));
                                u1.ABC:Connect(u8.Died, clean);
                                u1.ABC:Connect(u14.Died, clean);
                                u1.ABC:Connect(u2.CharacterRemoving, function(p34) -- Line: 194
                                    -- upvalues: u3 (copy), u1 (copy)
                                    if p34 == u3 then
                                        u1.ABC:Clean();
                                    end;
                                end);
                                u1.ABC:Connect(u6.CharacterRemoving, function(p35) -- Line: 199
                                    -- upvalues: u4 (copy), u1 (copy)
                                    if p35 == u4 then
                                        u1.ABC:Clean();
                                    end;
                                end);
                                u1.ABC:Connect(u2:GetPropertyChangedSignal("Team"), function() -- Line: 204
                                    -- upvalues: u2 (copy), Team (copy), u1 (copy)
                                    if u2.Team ~= Team then
                                        u1.ABC:Clean();
                                    end;
                                end);
                                u1.ABC:Connect(u6:GetPropertyChangedSignal("Team"), function() -- Line: 209
                                    -- upvalues: u6 (copy), Team (copy), u1 (copy)
                                    if u6.Team ~= Team then
                                        u1.ABC:Clean();
                                    end;
                                end);
                                u1.ABC:Connect(u12.Changed, function() -- Line: 214
                                    -- upvalues: u12 (copy), u1 (copy)
                                    if u12.Value ~= "Kaiser" then
                                        u1.ABC:Clean();
                                    end;
                                end);
                                u1.ABC:Connect(u18.Changed, function() -- Line: 219
                                    -- upvalues: u18 (copy), u1 (copy)
                                    if u18.Value ~= "Isagi" then
                                        u1.ABC:Clean();
                                    end;
                                end);
                                u1.ABC:Connect(Football.Changed, function() -- Line: 224
                                    -- upvalues: Football (copy), u19 (copy), u1 (copy)
                                    if Football.Value ~= u19 then
                                        u1.ABC:Clean();
                                    end;
                                end);

                                if pcall(function() -- Line: 230
                                    -- upvalues: u1 (copy), u23 (copy)
                                    u1.Animations:StopAnims();
                                    u23.Priority = Enum.AnimationPriority.Action4;
                                    u23:Play();
                                end) then
                                    u1.ABC:Connect(u1.AbilityService.Ability, function(p36) -- Line: 240
                                        -- upvalues: u33 (ref), u19 (copy), contextValid (copy), Football (copy), u21 (copy), u1 (copy), workspace_CurrentCamera (copy), KaiserCRShot (ref), RunService (ref)
                                        if u33 or p36 ~= u19 then
                                            return;
                                        end;

                                        if not (contextValid() and (Football.Value == u19 and (u19.Parent == workspace and not u21.Value))) then
                                            u1.ABC:Clean();

                                            return;
                                        end;

                                        u33 = true;
                                        u1.UsingCRMove = false;
                                        u1.StatesController.States.Ability = false;
                                        local u37 = (workspace.CurrentCamera or workspace_CurrentCamera).CFrame.LookVector + KaiserCRShot.ShotTiltVector;
                                        u19.AssemblyLinearVelocity = u37 * KaiserCRShot.ShotPower;
                                        u1.BallController:DragBall(u19);
                                        local ShotDuration = KaiserCRShot.ShotDuration;
                                        local u38 = KaiserCRShot.ShotPower - 15;
                                        local u39 = tick();
                                        local Position = u19.Position;
                                        u1.ABC:Connect(RunService.Stepped, function(p40, p41) -- Line: 268
                                            -- upvalues: contextValid (ref), Football (ref), u19 (ref), u1 (ref), u38 (ref), u37 (copy), u39 (copy), ShotDuration (copy), u21 (ref), Position (copy)
                                            if not contextValid() or Football.Value ~= u19 then
                                                u1.ABC:Clean();

                                                return;
                                            end;

                                            u38 = math.max(u38 - 200 * p41, 40);
                                            local RaycastParams_new_ret = RaycastParams.new();
                                            RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
                                            RaycastParams_new_ret.FilterDescendantsInstances = { u19 };
                                            RaycastParams_new_ret.CollisionGroup = "Trajectory";
                                            local v42 = workspace:Raycast(u19.Position, u37 * 10, RaycastParams_new_ret);

                                            if ShotDuration <= tick() - u39 or v42 and v42.Instance or (u21.Value or (u19.Position - Position).Magnitude >= 200) then
                                                u1.ABC:Clean();

                                                return;
                                            end;

                                            u19.AssemblyLinearVelocity = u37 * u38;
                                        end);
                                    end);

                                    return true;
                                end;

                                u1.ABC:Clean();

                                return false;
                            end;
                        end;
                    end;

                    u1.UsingCRMove = false;
                    pcall(Popup.Popup, u2, "Chemical Reaction Failed");

                    return false;
                end;

                if not contextValid() then
                    break;
                end;

                local v43;

                if u21.Value then
                    if u19.Parent == u4 and u20.Value == u4 then
                        v43 = true;
                    elseif u19.Parent == u3 and u20.Value == u3 then
                        if u10 then
                            v43 = u10.Value;
                        else
                            v43 = u10;
                        end;
                    else
                        v43 = false;
                    end;
                elseif u19.Parent == workspace then
                    v43 = u20.Value == u4;
                else
                    v43 = false;
                end;

                if not v43 then
                    break;
                end;

                local v44;

                if u22 < (u19.Position - u7.Position).Magnitude then
                    v44 = false;
                else
                    v44 = u19.Parent == workspace and u20.Value == u4 and not u21.Value;

                    if not v44 then
                        if u19.Parent == u3 and u20.Value == u3 then
                            v44 = u21.Value;
                        else
                            v44 = false;
                        end;
                    end;
                end;

                if v44 then
                    v31 = true;
                end;

                RunService.Heartbeat:Wait();
            end;

            u1.UsingCRMove = false;
            pcall(Popup.Popup, u2, "Chemical Reaction Failed");

            return false;
        end;
    end;

    return false;
end;