 

 

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local v1 = {
    __index = {}
};
local actionUtil = require(ReplicatedStorage.util.actionUtil);
require(ReplicatedStorage.packets);
local Mouse = Players.LocalPlayer:GetMouse();
local workspace_CurrentCamera = workspace.CurrentCamera;

function v1.skill1(p2) -- Line: 18
    local State = p2.human:GetState();
    local table_find_ret = table.find({ "Jumping", "Freefall" }, State.Name);
    local v3 = p2.humanoidRootPart.CFrame:VectorToObjectSpace(p2.human.MoveDirection);
    p2:senduse({ "skill1", table_find_ret, math.round(v3.X) == 1 and "Right" or (math.round(v3.X) == -1 and "Left" or (math.round(v3.Z) == 1 and "Back" or "Front")) });
end;

function v1.skill3(p4) -- Line: 37
    -- upvalues: UserInputService (copy), workspace_CurrentCamera (copy), Mouse (copy), actionUtil (copy)
    local v5 = (UserInputService.GamepadEnabled or UserInputService.TouchEnabled) and Vector2.new(workspace_CurrentCamera.ViewportSize.X / 2, workspace_CurrentCamera.ViewportSize.Y / 2) or Vector2.new(Mouse.X, Mouse.Y, Mouse.Hit.p);
    local v6 = nil;
    local v7 = nil;

    for _, child in pairs(workspace.characters:GetChildren()) do
        if not table.find({ child }, p4.character) then
            local HumanoidRootPart = child:FindFirstChild("HumanoidRootPart");

            if child:FindFirstChildOfClass("Humanoid").Health > 0 and (HumanoidRootPart and (actionUtil.checksameTeam(p4.character, child) and (HumanoidRootPart.Position - p4.humanoidRootPart.Position).magnitude < 1125)) then
                local v8, v9 = workspace_CurrentCamera:WorldToScreenPoint(HumanoidRootPart.Position);
                local Vector2_new_ret = Vector2.new(v8.X, v8.Y);

                if v9 then
                    local magnitude = (v5 - Vector2_new_ret).magnitude;

                    if v6 and v7 then
                        if magnitude < v7 then
                            v7 = magnitude;
                            v6 = child;
                        end;
                    else
                        v7 = magnitude;
                        v6 = child;
                    end;
                end;
            end;
        end;
    end;

    p4:senduse({ "skill3", v6 });
end;

return v1;