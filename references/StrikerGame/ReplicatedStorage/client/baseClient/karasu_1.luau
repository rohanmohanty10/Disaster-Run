 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local v1 = {
    __index = {}
};
local actionUtil = require(ReplicatedStorage.util.actionUtil);
require(ReplicatedStorage.packets);
local Mouse = Players.LocalPlayer:GetMouse();
local workspace_CurrentCamera = workspace.CurrentCamera;

function v1.skill4(p2) -- Line: 16
    local State = p2.human:GetState();
    p2:senduse({ "skill4", State == Enum.HumanoidStateType.Jumping and true or State == Enum.HumanoidStateType.Freefall });
end;

function v1.skill2(p3) -- Line: 24
    -- upvalues: UserInputService (copy), workspace_CurrentCamera (copy), Mouse (copy), actionUtil (copy)
    local v4 = (UserInputService.GamepadEnabled or UserInputService.TouchEnabled) and Vector2.new(workspace_CurrentCamera.ViewportSize.X / 2, workspace_CurrentCamera.ViewportSize.Y / 2) or Vector2.new(Mouse.X, Mouse.Y, Mouse.Hit.p);
    local v5 = nil;
    local v6 = nil;

    for _, child in pairs(workspace.characters:GetChildren()) do
        if not table.find({ child }, p3.character) then
            local HumanoidRootPart = child:FindFirstChild("HumanoidRootPart");

            if child:FindFirstChildOfClass("Humanoid").Health > 0 and (HumanoidRootPart and (actionUtil.checksameTeam(p3.character, child) and (HumanoidRootPart.Position - p3.humanoidRootPart.Position).magnitude < 285)) then
                local v7, v8 = workspace_CurrentCamera:WorldToScreenPoint(HumanoidRootPart.Position);
                local Vector2_new_ret = Vector2.new(v7.X, v7.Y);

                if v8 then
                    local magnitude = (v4 - Vector2_new_ret).magnitude;

                    if v5 and v6 then
                        if magnitude < v6 then
                            v6 = magnitude;
                            v5 = child;
                        end;
                    else
                        v6 = magnitude;
                        v5 = child;
                    end;
                end;
            end;
        end;
    end;

    p3:senduse({ "skill2", v5 });
end;

return v1;