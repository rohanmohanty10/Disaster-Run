 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local v1 = {
    __index = {}
};
require(ReplicatedStorage.util.actionUtil);
require(ReplicatedStorage.packets);
Players.LocalPlayer:GetMouse();
local workspace_CurrentCamera = workspace.CurrentCamera;

function v1.skill1(p2) -- Line: 16
    p2:senduse({ "skill1" });
end;

function v1.skill2(p3) -- Line: 20
    -- upvalues: workspace_CurrentCamera (copy)
    local X = p3.humanoidRootPart.CFrame:VectorToObjectSpace(p3.human.MoveDirection).X;
    p3:senduse({ "skill2", math.round(X) == -1, workspace_CurrentCamera.CFrame.LookVector });
end;

function v1.skill3(p4) -- Line: 28
    local X = p4.humanoidRootPart.CFrame:VectorToObjectSpace(p4.human.MoveDirection).X;
    p4:senduse({ "skill3", math.round(X) == -1 });
end;

function v1.skill4(p5) -- Line: 35
    -- upvalues: UserInputService (copy)
    local State = p5.human:GetState();
    local v6 = State == Enum.HumanoidStateType.Jumping and true or State == Enum.HumanoidStateType.Freefall;

    if p5:IsSettingOn("HoldSpaceForAir") then
        v6 = UserInputService:IsKeyDown(Enum.KeyCode.Space) or p5.human.Jump == true;
    end;

    local u7 = p5.humanoidRootPart.CFrame:VectorToObjectSpace(p5.human.MoveDirection);
    ({
        left = math.round(u7.X) == -1,
        right = math.round(u7.X) == 1,
        back = math.round(u7.Z) == -1
    }).front = math.round(u7.Z) == 1;
    p5:senduse({ "skill4", v6, (function() -- Line: 55, Name: getdirection
            -- upvalues: u7 (copy)
            if math.round(u7.X) == 1 then
                return "Right";
            end;

            if math.round(u7.X) == -1 then
                return "Left";
            end;

            if math.round(u7.Z) == -1 then
                return "Front";
            end;

            if math.round(u7.Z) == 1 then
                return "Back";
            end;

            if nil == nil then
                return "Front";
            end;
        end)() });
end;

function v1.skill5(p8) -- Line: 84
    local X = p8.humanoidRootPart.CFrame:VectorToObjectSpace(p8.human.MoveDirection).X;
    p8:senduse({ "skill5", math.round(X) == -1 });
end;

return v1;