 

 

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local v1 = {
    __index = {}
};
require(ReplicatedStorage.packets);
require(ReplicatedStorage.util.actionUtil);
Players.LocalPlayer:GetMouse();
local _ = workspace.CurrentCamera;

local function holdingSpace(p2) -- Line: 16
    -- upvalues: UserInputService (copy)
    local State = p2.human:GetState();
    local v3 = State == Enum.HumanoidStateType.Jumping and true or State == Enum.HumanoidStateType.Freefall;

    if p2:IsSettingOn("HoldSpaceForAir") then
        v3 = UserInputService:IsKeyDown(Enum.KeyCode.Space) or p2.human.Jump == true;
    end;

    return v3;
end;

local function getMoveDirection(p4) -- Line: 26
    local v5 = p4.humanoidRootPart.CFrame:VectorToObjectSpace(p4.human.MoveDirection);

    return math.round(v5.X) == 1 and "Right" or (math.round(v5.X) == -1 and "Left" or (math.round(v5.Z) == -1 and "Front" or (math.round(v5.Z) == 1 and "Back" or "Front")));
end;

function v1.skill1(p6) -- Line: 43
    -- upvalues: getMoveDirection (copy), holdingSpace (copy)
    p6:senduse({ "skill1", getMoveDirection(p6), (holdingSpace(p6)) });
end;

function v1.skill3(p7) -- Line: 47
    -- upvalues: holdingSpace (copy)
    p7:senduse({ "skill3", (holdingSpace(p7)) });
end;

return v1;