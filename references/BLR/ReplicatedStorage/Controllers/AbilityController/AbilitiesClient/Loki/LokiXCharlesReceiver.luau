  

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
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);

return function(u1, u2, u3, u4, p5) -- Line: 17
    -- upvalues: Players (copy), ReplicatedStorage (copy), AbilityBalancing (copy)
    local u6;

    if u3 then
        u6 = Players:GetPlayerFromCharacter(u3);
    else
        u6 = u3;
    end;

    local u7;

    if u4 then
        u7 = Players:GetPlayerFromCharacter(u4);
    else
        u7 = u4;
    end;

    local u8;

    if u2 then
        u8 = u2.Team;
    else
        u8 = u2;
    end;

    local u9;

    if u3 then
        u9 = u3:FindFirstChild("HumanoidRootPart");
    else
        u9 = u3;
    end;

    local u10;

    if u3 then
        u10 = u3:FindFirstChildOfClass("Humanoid");
    else
        u10 = u3;
    end;

    local v11;

    if u3 then
        v11 = u3:FindFirstChild("Values");
    else
        v11 = u3;
    end;

    if v11 then
        v11 = v11:FindFirstChild("HasBall");
    end;

    local u12;

    if u2 then
        u12 = u2:FindFirstChild("PlayerStats");
    else
        u12 = u2;
    end;

    local u13;

    if u12 then
        u13 = u12:FindFirstChild("Style");
    else
        u13 = u12;
    end;

    local u14;

    if u4 then
        u14 = u4:FindFirstChild("HumanoidRootPart");
    else
        u14 = u4;
    end;

    local u15;

    if u4 then
        u15 = u4:FindFirstChildOfClass("Humanoid");
    else
        u15 = u4;
    end;

    local v16;

    if u4 then
        v16 = u4:FindFirstChild("Values");
    else
        v16 = u4;
    end;

    if v16 then
        v16 = v16:FindFirstChild("HasBall");
    end;

    local u17;

    if u7 then
        u17 = u7:FindFirstChild("PlayerStats");
    else
        u17 = u7;
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

    local function participantsValid() -- Line: 40
        -- upvalues: u2 (copy), Players (ref), u6 (copy), u7 (copy), u8 (copy), u3 (copy), u4 (copy), u9 (copy), u14 (copy), u10 (copy), u15 (copy), u13 (copy), u12 (copy), u18 (copy), u17 (copy)
        local v22 = u2;

        if v22 then
            if u2.Parent == Players and u6 == u2 then
                v22 = u7;

                if v22 then
                    if u7.Parent == Players and u7 ~= u2 then
                        v22 = u8;

                        if v22 then
                            if u2.Team == u8 and (u7.Team == u8 and (u2.Character == u3 and u7.Character == u4)) then
                                v22 = u3 and (u3.Parent and u4 and (u4.Parent and u9));

                                if v22 then
                                    if u9.Parent == u3 then
                                        v22 = u14;

                                        if v22 then
                                            if u14.Parent == u4 then
                                                v22 = u10;

                                                if v22 then
                                                    if u10.Parent == u3 and u10.Health > 0 then
                                                        v22 = u15;

                                                        if v22 then
                                                            if u15.Parent == u4 and u15.Health > 0 then
                                                                v22 = u13;

                                                                if v22 then
                                                                    if u13.Parent == u12 and u13.Value == "Loki" then
                                                                        v22 = u18;

                                                                        if v22 then
                                                                            if u18.Parent == u17 then
                                                                                v22 = u18.Value == "Charles";
                                                                            else
                                                                                v22 = false;
                                                                            end;
                                                                        end;
                                                                    else
                                                                        v22 = false;
                                                                    end;
                                                                end;
                                                            else
                                                                v22 = false;
                                                            end;
                                                        end;
                                                    else
                                                        v22 = false;
                                                    end;
                                                end;
                                            else
                                                v22 = false;
                                            end;
                                        end;
                                    else
                                        v22 = false;
                                    end;
                                end;
                            else
                                v22 = false;
                            end;
                        end;
                    else
                        v22 = false;
                    end;
                end;
            else
                v22 = false;
            end;
        end;

        return v22;
    end;

    if not (participantsValid() and (Football and (u19 and (u19:IsA("BasePart") and (Football.Value == u19 and (u20 and (u20.Parent == u19 and (u20.Value == u4 and (u21 and (u21.Parent == u19 and (u21.Value and (u19.Parent == u4 and (v16 and (v16.Value and (v11 and not (v11.Value or (typeof(p5) ~= "function" or not (u1.ABC and (typeof(u1.ABC.Clean) == "function" and (typeof(u1.ABC.Add) == "function" and (typeof(u1.ABC.Connect) == "function" and (u1.Camera and (u1.StatesController and (u1.StatesController.States and (u1.AbilityService and (u1.AbilityService.LokiXCharlesCRCompleted and (u1.BallController and typeof(u1.BallController.DragBall) == "function"))))))))))))))))))))))))))) then
        return false;
    end;

    u1.ABC:Clean();
    local u23 = false;
    local u24 = false;
    local u25 = false;
    local u26 = false;
    local u27 = false;
    local u28 = nil;
    local u29 = {};

    local function cleanupState() -- Line: 116
        -- upvalues: u24 (ref), u29 (copy), u25 (ref), u1 (copy), u9 (copy), u3 (copy)
        if u24 then
            return;
        end;

        u24 = true;

        for _, v in u29 do
            v:Disconnect();
        end;

        table.clear(u29);

        if u25 then
            u25 = false;
            u1.Camera.Cutscene = false;
            u1.InAbility = false;
            u1.StatesController.States.Ability = false;
            pcall(function() -- Line: 130
                -- upvalues: u9 (ref), u3 (ref)
                if u9.Parent == u3 then
                    u9.Anchored = false;
                end;
            end);
        end;
    end;

    local function finish() -- Line: 138
        -- upvalues: u24 (ref), u26 (ref), u1 (copy), cleanupState (copy)
        if u24 then
            return false;
        end;

        if u26 then
            u1.ABC:Clean();
        else
            cleanupState();
        end;

        return true;
    end;

    local function processTerminal(p30) -- Line: 150
        -- upvalues: u24 (ref), u26 (ref), u1 (copy), cleanupState (copy), u19 (copy), participantsValid (copy), Football (copy), u20 (copy), u3 (copy), u21 (copy), u9 (copy), AbilityBalancing (ref)
        local v31;

        if u24 then
            v31 = false;
        elseif u26 then
            u1.ABC:Clean();
            v31 = true;
        else
            cleanupState();
            v31 = true;
        end;

        if not v31 or p30 == nil then
            return;
        end;

        if p30 ~= u19 or not (participantsValid() and (Football.Value == u19 and (u19.Parent == workspace and (u20.Parent == u19 and (u20.Value == u3 and (u21.Parent == u19 and not u21.Value)))))) then
            return;
        end;

        pcall(function() -- Line: 166
            -- upvalues: u9 (ref), u19 (ref), AbilityBalancing (ref), u1 (ref)
            u19.AssemblyLinearVelocity = ((u9.CFrame * CFrame.Angles(0, 0.4363323129985824, 0)).LookVector + Vector3.new(0, 0.02, 0)) * AbilityBalancing.LokiXCharles.ShotPower;
            u1.BallController:DragBall(u19);
        end);
    end;

    table.insert(u29, u1.AbilityService.LokiXCharlesCRCompleted:Connect(function(p32) -- Line: 174
        -- upvalues: u24 (ref), u23 (ref), u27 (ref), u28 (ref), processTerminal (copy)
        if u24 then
            return;
        end;

        if u23 then
            processTerminal(p32);

            return;
        end;

        u27 = true;
        u28 = p32;
    end));
    table.insert(u29, u10.Died:Connect(finish));
    table.insert(u29, u15.Died:Connect(finish));
    table.insert(u29, u2.CharacterRemoving:Connect(function(p33) -- Line: 187
        -- upvalues: u3 (copy), u24 (ref), u26 (ref), u1 (copy), cleanupState (copy)
        if p33 == u3 then
            if u24 then
                return;
            end;

            if u26 then
                u1.ABC:Clean();

                return;
            end;

            cleanupState();
        end;
    end));
    table.insert(u29, u7.CharacterRemoving:Connect(function(p34) -- Line: 192
        -- upvalues: u4 (copy), u24 (ref), u26 (ref), u1 (copy), cleanupState (copy)
        if p34 == u4 then
            if u24 then
                return;
            end;

            if u26 then
                u1.ABC:Clean();

                return;
            end;

            cleanupState();
        end;
    end));
    local PropertyChangedSignal = u2:GetPropertyChangedSignal("Team");
    table.insert(u29, PropertyChangedSignal:Connect(function() -- Line: 197
        -- upvalues: u2 (copy), u8 (copy), u24 (ref), u26 (ref), u1 (copy), cleanupState (copy)
        if u2.Team ~= u8 then
            if u24 then
                return;
            end;

            if u26 then
                u1.ABC:Clean();

                return;
            end;

            cleanupState();
        end;
    end));
    local PropertyChangedSignal2 = u7:GetPropertyChangedSignal("Team");
    table.insert(u29, PropertyChangedSignal2:Connect(function() -- Line: 202
        -- upvalues: u7 (copy), u8 (copy), u24 (ref), u26 (ref), u1 (copy), cleanupState (copy)
        if u7.Team ~= u8 then
            if u24 then
                return;
            end;

            if u26 then
                u1.ABC:Clean();

                return;
            end;

            cleanupState();
        end;
    end));
    table.insert(u29, u13.Changed:Connect(function() -- Line: 207
        -- upvalues: u13 (copy), u24 (ref), u26 (ref), u1 (copy), cleanupState (copy)
        if u13.Value ~= "Loki" then
            if u24 then
                return;
            end;

            if u26 then
                u1.ABC:Clean();

                return;
            end;

            cleanupState();
        end;
    end));
    table.insert(u29, u18.Changed:Connect(function() -- Line: 212
        -- upvalues: u18 (copy), u24 (ref), u26 (ref), u1 (copy), cleanupState (copy)
        if u18.Value ~= "Charles" then
            if u24 then
                return;
            end;

            if u26 then
                u1.ABC:Clean();

                return;
            end;

            cleanupState();
        end;
    end));
    table.insert(u29, Football.Changed:Connect(function() -- Line: 217
        -- upvalues: Football (copy), u19 (copy), u24 (ref), u26 (ref), u1 (copy), cleanupState (copy)
        if Football.Value ~= u19 then
            if u24 then
                return;
            end;

            if u26 then
                u1.ABC:Clean();

                return;
            end;

            cleanupState();
        end;
    end));
    local success, result = pcall(p5);

    if u24 or not (success and (typeof(result) == "table" and (result.Ok == true and (participantsValid() and Football.Value == u19)))) then
        if not u24 then
            if u26 then
                u1.ABC:Clean();
            else
                cleanupState();
            end;
        end;

        return false;
    end;

    u23 = true;

    if u27 then
        processTerminal(u28);

        return true;
    end;

    if u24 then
        return false;
    end;

    u26 = true;
    u1.ABC:Add(cleanupState);
    u25 = true;

    if pcall(function() -- Line: 247
        -- upvalues: u1 (copy), u9 (copy)
        u1.Camera.Cutscene = true;
        u1.InAbility = true;
        u1.StatesController.States.Ability = true;
        u9.Anchored = true;
    end) then
        u1.ABC:Add(task.delay(25, finish));

        return true;
    end;

    if not u24 then
        if u26 then
            u1.ABC:Clean();
        else
            cleanupState();
        end;
    end;

    return false;
end;