  

local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local AdvanceUbersRules = require(ReplicatedStorage.Shared.AdvanceUbersRules);
local Trove = require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.Spring);
local getCharacter = require(ReplicatedStorage.Shared.utils.getCharacter);
local workspace_CurrentCamera = workspace.CurrentCamera;
local Knit = require(ReplicatedStorage.Packages.Knit);
local u1 = nil;
Knit.OnStart():andThen(function() -- Line: 12
    -- upvalues: u1 (ref), Knit (copy)
    u1 = Knit.GetService("AbilityService");
end);
local u2 = {
    PredatorKrampus = 1.2
};

local function doShot(p3: userdata, p4: table?, p5: vector) -- Line: 26
    -- upvalues: getCharacter (copy), ReplicatedStorage (copy), AdvanceUbersRules (copy), u2 (copy), workspace_CurrentCamera (copy)
    local v6, _, _, _ = getCharacter();
    local BallController = require(ReplicatedStorage.Controllers.BallController);
    local v7 = p4 or {};
    local v8 = v7.ShotPower * AdvanceUbersRules.multiplier(v6, "Shot");

    for i, v in u2 do
        if v6:GetAttribute(i) then
            print("yoooo u got a shot boost " .. i, v);
            v8 = v8 * v;
        end;
    end;

    local v9 = p5 or (v7.ShotDirection or workspace_CurrentCamera.CFrame.LookVector);
    local Y = (v7.ShotTiltVector or Vector3.new(0, 0.05, 0)).Y;

    if v9.Y < Y then
        v9 = Vector3.new(v9.X, Y, v9.Z);
    end;

    print(v9);
    p3.AssemblyLinearVelocity = v9 * v8;
    BallController:DragBall(p3);
end;

return {
    executeShot = function(u10, u11, u12) -- Line: 65, Name: executeShot
        -- upvalues: ReplicatedStorage (copy), getCharacter (copy), RunService (copy), u1 (ref), Trove (copy), doShot (copy)
        require(ReplicatedStorage.Controllers.BallController);
        local StatesController = require(ReplicatedStorage.Controllers.StatesController);
        local _, _, _, u13 = getCharacter();

        if RunService:IsServer() then
            warn("executeShot can only be called from the client");

            return nil;
        end;

        local v14 = u1 and u1.Ability;

        if not v14 then
            warn("executeShot: No ability signal found on self.AbilityService");

            return nil;
        end;

        local u15 = Trove.new();
        u15:Add(v14:Connect(function(p16) -- Line: 85
            -- upvalues: StatesController (copy), u13 (copy), u15 (copy), u10 (copy), doShot (ref), u11 (copy), u12 (copy)
            if not (p16 and (StatesController.States.Ability ~= false and u13.HasBall ~= false)) then
                StatesController.States.Ability = false;
                u15:Destroy();

                return;
            end;

            if u10.ExtraEndlag then
                task.delay(u10.ExtraEndlag, function() -- Line: 93
                    -- upvalues: StatesController (ref)
                    StatesController.States.Ability = false;
                end);
            else
                StatesController.States.Ability = false;
            end;

            doShot(p16, u10, u11);
            u15:Destroy();
            u12:Destroy();
        end));

        return u15;
    end,

    doShot = doShot
};