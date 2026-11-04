  

local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Trove = require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.Spring);
local getCharacter = require(ReplicatedStorage.Shared.utils.getCharacter);
local workspace_CurrentCamera = workspace.CurrentCamera;
local u1 = {
    directionRecalculates = false,

    stepped = function() -- Line: 11, Name: stepped
    end,

    direction = function() -- Line: 12, Name: direction
        -- upvalues: workspace_CurrentCamera (copy)
        return (workspace_CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit;
    end,

    speed = function() -- Line: 16, Name: speed
        return 1;
    end,

    fov = function() -- Line: 19, Name: fov
        return 0;
    end
};

return function(p2: number, u3: number, u4: table) -- Line: 22, Name: executeDash
    -- upvalues: ReplicatedStorage (copy), u1 (copy), Trove (copy), getCharacter (copy), RunService (copy)
    local CameraController = require(ReplicatedStorage.Controllers.CameraController);
    local table_clone_ret = table.clone(u4 or u1);

    for i, v in u1 do
        if table_clone_ret[i] == nil then
            table_clone_ret[i] = table_clone_ret[i] or v;
        end;
    end;

    local u5 = Trove.new();
    local _, u6 = getCharacter();
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.MaxForce = Vector3.new(40000, 0, 40000);
    BodyVelocity.Parent = u6;
    u5:Add(BodyVelocity);
    local u7 = time();
    local u8 = table_clone_ret.direction();
    u5:Add(RunService.Heartbeat:Connect(function(p9) -- Line: 52
        -- upvalues: table_clone_ret (copy), u8 (ref), u7 (copy), u3 (copy), u5 (copy), BodyVelocity (copy), CameraController (copy), u4 (copy), u6 (copy)
        if table_clone_ret.directionRecalculates then
            u8 = table_clone_ret.direction();
        end;

        local v10 = time() - u7;

        if u3 < v10 then
            u5:Destroy();

            return;
        end;

        if table_clone_ret.speed(v10) then
            BodyVelocity.Velocity = u8 * table_clone_ret.speed(v10);
            BodyVelocity.MaxForce = Vector3.new(1000000000, 0, 1000000000);
        else
            BodyVelocity.MaxForce = Vector3.new(0, 0, 0);
            BodyVelocity.Velocity = Vector3.new(0, 0, 0);
        end;

        CameraController.FOVBonus = table_clone_ret.fov(v10);

        if not u4.notlookat then
            u6.CFrame = CFrame.lookAt(u6.CFrame.Position, u6.CFrame.Position + u8);
        end;

        local v11 = table_clone_ret.stepped(v10, BodyVelocity.Velocity);

        if v11 ~= nil then
            BodyVelocity.Velocity = v11;
        end;
    end));
    u5:Add(function() -- Line: 79
        -- upvalues: CameraController (copy)
        CameraController.FOVBonus = 0;
    end);

    return u5;
end;