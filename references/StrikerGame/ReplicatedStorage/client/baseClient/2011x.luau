 

 

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

function v1.skill4(p2) -- Line: 16
    -- upvalues: UserInputService (copy)
    local State = p2.human:GetState();
    local v3 = State == Enum.HumanoidStateType.Jumping and true or State == Enum.HumanoidStateType.Freefall;

    if p2:IsSettingOn("HoldSpaceForAir") then
        v3 = UserInputService:IsKeyDown(Enum.KeyCode.Space) or p2.human.Jump == true;
    end;

    p2:senduse({ "skill4", v3 });
end;

return v1;