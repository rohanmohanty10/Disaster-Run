 

 

local Players = game:GetService("Players");
game:GetService("UserInputService");
game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local v1 = {
    __index = {}
};
local packets = require(ReplicatedStorage.packets);
local actionUtil = require(ReplicatedStorage.util.actionUtil);
local Mouse = Players.LocalPlayer:GetMouse();
local workspace_CurrentCamera = workspace.CurrentCamera;

function v1.skill2(p2) -- Line: 16
    -- upvalues: workspace_CurrentCamera (copy), packets (copy)
    local X = p2.humanoidRootPart.CFrame:VectorToObjectSpace(p2.human.MoveDirection).X;
    local v3 = math.round(X) == -1;
    packets.bytenet_use.send({ "skill2", v3, workspace_CurrentCamera.CFrame.LookVector });
end;

function v1.skill4(p4) -- Line: 24
    -- upvalues: Mouse (copy), actionUtil (copy), workspace_CurrentCamera (copy), packets (copy)
    local Vector2_new_ret = Vector2.new(Mouse.X, Mouse.Y, Mouse.Hit.p);
    local v5 = nil;
    local v6 = nil;

    for _, child in pairs(workspace.characters:GetChildren()) do
        if not table.find({ child }, p4.character) then
            local HumanoidRootPart = child:FindFirstChild("HumanoidRootPart");

            if child:FindFirstChildOfClass("Humanoid").Health > 0 and (HumanoidRootPart and (actionUtil.checksameTeam(p4.character, child) and (HumanoidRootPart.Position - p4.humanoidRootPart.Position).magnitude < 100000)) then
                local v7, v8 = workspace_CurrentCamera:WorldToScreenPoint(HumanoidRootPart.Position);
                local Vector2_new_ret2 = Vector2.new(v7.X, v7.Y);

                if v8 then
                    local magnitude = (Vector2_new_ret - Vector2_new_ret2).magnitude;

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

    packets.bytenet_use.send({ "skill4", v5 });
end;

return v1;