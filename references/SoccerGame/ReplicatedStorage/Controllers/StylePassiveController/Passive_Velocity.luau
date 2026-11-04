  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Trove = require(ReplicatedStorage.Packages.Trove);
local StatesController = require(ReplicatedStorage.Controllers.StatesController);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local u1 = { { 25, 4 }, { 60, 9 }, { 90, 12 }, { 100, 17 } };

return {
    hook = function(p2) -- Line: 26, Name: hook
        -- upvalues: AbilityUtils (copy), StatesController (copy), Trove (copy), ReplicatedStorage (copy), u1 (copy)
        local Character = AbilityUtils.getCharacter();
        local CharacterEvents = StatesController.CharacterEvents;
        local v3 = Trove.new();
        local u4 = 0;
        local u5 = 0;
        local u6 = 0;
        v3:Add(function() -- Line: 37
            -- upvalues: ReplicatedStorage (ref)
            ReplicatedStorage.SillyMiscThings.replicateVelocityPassive:FireServer(nil);
        end);
        v3:Add(CharacterEvents.RoundStarted:Connect(function() -- Line: 41
            -- upvalues: u4 (ref)
            u4 = 0;
        end));
        v3:Add(CharacterEvents.PreUpdate:Connect(function(p7, p8) -- Line: 45
            -- upvalues: ReplicatedStorage (ref), u4 (ref), StatesController (ref), Character (copy), u5 (ref), u6 (ref), u1 (ref)
            if game.ReplicatedStorage.GameValues.AwakeningCutscene.Value then
                return;
            end;

            if time() - 0 > 0.05 then
                ReplicatedStorage.SillyMiscThings.replicateVelocityPassive:FireServer(u4);
            end;

            local Ability = StatesController.States.Ability;
            local v9;

            if p7.MoveDirection.Magnitude > 0 and p7:GetState() == Enum.HumanoidStateType.Running then
                v9 = StatesController.States.Running and not StatesController.States.Ability;
            else
                v9 = false;
            end;

            if v9 and Character.HumanoidRootPart.AssemblyLinearVelocity.Magnitude > 20 then
                u5 = u5 + p8;
                u6 = 0;

                if u5 > 1.4 or u4 > 0 then
                    u4 = u4 + p8 * 9.5;
                end;
            elseif not Ability then
                u6 = u6 + p8;
                u5 = 0;

                if u6 > 1 then
                    u4 = u4 - p8 * 47.5;
                end;
            end;

            u4 = math.clamp(u4, 0, 95);

            if StatesController.States.Running then
                for i = #u1, 1, -1 do
                    if u4 > u1[i][1] then
                        local States = StatesController.States;
                        States.CalculatedSpeedBonus = States.CalculatedSpeedBonus + u1[i][2];

                        return;
                    end;

                    local _ = i;
                end;
            end;
        end));
        v3:Add(CharacterEvents.OnSlide:Connect(function() -- Line: 86
            -- upvalues: u4 (ref)
            u4 = 0;
        end));
        v3:Add(CharacterEvents.OnDribble:Connect(function() -- Line: 90
            -- upvalues: u4 (ref)
            u4 = u4 - 47.5;
        end));
        v3:Add(CharacterEvents.OnJump:Connect(function() -- Line: 94
        end));
        v3:Add(CharacterEvents.CustomEvent:Connect(function(p10) -- Line: 99
            -- upvalues: u4 (ref)
            if p10 == "SwiftInterceptDash" then
                u4 = u4 + 71.25;

                return;
            end;

            if p10 == "ExplosiveAcceleration" then
                u4 = u4 + 47.5;

                return;
            end;

            if p10 == "ResetVelocity" then
                u4 = 0;
            end;
        end));

        return v3, function(p11) -- Line: 114
            -- upvalues: u4 (ref), u1 (ref)
            if p11 == "CurrentVelocity" then
                return u4;
            end;

            if p11 == "VelocityPercent" then
                return u4 / 95;
            end;

            if p11 == "Bars" then
                return u1;
            end;
        end;
    end
};