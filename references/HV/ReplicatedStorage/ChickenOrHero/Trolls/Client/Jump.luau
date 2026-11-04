 

 

local ContextActionService = game:GetService("ContextActionService");
local RunService = game:GetService("RunService");

return {
    start = function(u1) -- Line: 10, Name: start
        -- upvalues: RunService (copy), ContextActionService (copy)
        local Movement = u1.package:WaitForChild("Movement");
        local ControlGate = require(Movement:WaitForChild("ControlGate"));
        local MovementConfig = require(Movement:WaitForChild("MovementConfig"));
        local player = u1.player;
        local Jumping = Enum.HumanoidStateType.Jumping;
        local u2 = setmetatable({}, {
            __mode = "k"
        });
        local u3 = false;

        local function body() -- Line: 19
            -- upvalues: player (copy)
            local Character = player.Character;
            local v4;

            if Character then
                v4 = Character:FindFirstChildOfClass("Humanoid");
            else
                v4 = Character;
            end;

            return v4, Character;
        end;

        local function on() -- Line: 24
            -- upvalues: player (copy), u1 (copy)
            local v5;

            if player:GetAttribute("TrollJump") == true then
                v5 = not u1.exempt();
            else
                v5 = false;
            end;

            return v5;
        end;

        local function free(p6, p7) -- Line: 28
            -- upvalues: ControlGate (copy), player (copy)
            local v8;

            if p7 then
                v8 = p7:FindFirstChild("HumanoidRootPart");
            else
                v8 = p7;
            end;

            local v9;

            if p6.Health > 0 and v8 ~= nil then
                v9 = not (v8.Anchored or (p6.Sit or p7:GetAttribute("MovementLocked") or (p7:GetAttribute("Ragdolled") or p7:GetAttribute("TackleActive")))) and ControlGate.movementReason(player) == nil;
            else
                v9 = false;
            end;

            return v9;
        end;

        local function press(p10, p11) -- Line: 42
            -- upvalues: player (copy), u1 (copy), free (copy)
            if p11 == Enum.UserInputState.Begin then
                local v12;

                if player:GetAttribute("TrollJump") == true then
                    v12 = not u1.exempt();
                else
                    v12 = false;
                end;

                if v12 then
                    local Character = player.Character;
                    local v13;

                    if Character then
                        v13 = Character:FindFirstChildOfClass("Humanoid");
                    else
                        v13 = Character;
                    end;

                    if v13 and (free(v13, Character) and v13.FloorMaterial ~= Enum.Material.Air) then
                        v13:ChangeState(Enum.HumanoidStateType.Jumping);
                    end;
                end;
            end;

            return Enum.ContextActionResult.Pass;
        end;

        RunService.Heartbeat:Connect(function() -- Line: 53
            -- upvalues: player (copy), u1 (copy), u3 (ref), ContextActionService (ref), press (copy), free (copy), Jumping (copy), u2 (copy), MovementConfig (copy)
            local v14;

            if player:GetAttribute("TrollJump") == true then
                v14 = not u1.exempt();
            else
                v14 = false;
            end;

            if v14 ~= u3 then
                u3 = v14;

                if v14 then
                    ContextActionService:BindActionAtPriority("CoHTrollJump", press, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.Space);
                else
                    ContextActionService:UnbindAction("CoHTrollJump");
                end;
            end;

            local Character = player.Character;
            local v15;

            if Character then
                v15 = Character:FindFirstChildOfClass("Humanoid");
            else
                v15 = Character;
            end;

            if not v15 then
                return;
            end;

            if not (v14 and free(v15, Character)) then
                if u2[v15] then
                    u2[v15] = nil;

                    if not MovementConfig.JumpEnabled then
                        v15.JumpPower = 0;
                        v15:SetStateEnabled(Jumping, false);
                    end;
                end;

                return;
            end;

            v15.UseJumpPower = true;

            if v15.JumpPower ~= u1.Shared.JumpPower then
                v15.JumpPower = u1.Shared.JumpPower;
            end;

            if not v15:GetStateEnabled(Jumping) then
                v15:SetStateEnabled(Jumping, true);
            end;

            u2[v15] = true;
        end);
    end
};