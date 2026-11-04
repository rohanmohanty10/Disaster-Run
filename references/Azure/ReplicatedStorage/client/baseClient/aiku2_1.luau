 
 

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local v1 = {
    __index = {}
};
require(ReplicatedStorage.util.actionUtil);
require(ReplicatedStorage.packets);
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

function v1.skill1(p4) -- Line: 26
    -- upvalues: holdingSpace (copy)
    local X = p4.humanoidRootPart.CFrame:VectorToObjectSpace(p4.human.MoveDirection).X;
    p4:senduse({ "skill1", math.round(X) == -1, (holdingSpace(p4)) });
end;

function v1.skill3(p5) -- Line: 33
    -- upvalues: holdingSpace (copy)
    local X = p5.humanoidRootPart.CFrame:VectorToObjectSpace(p5.human.MoveDirection).X;
    local math_round_ret = math.round(X);
    p5:senduse({ "skill3", math_round_ret == 0 and "forward" or math_round_ret == -1, (holdingSpace(p5)) });
end;

return v1;