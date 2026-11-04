 

 

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
require(ReplicatedStorage.packets);
require(script.Parent);
require(ReplicatedStorage.util.actionUtil);
local GamepadContainer = require(ReplicatedStorage.client.GamepadContainer);
local v1 = {};
Players.LocalPlayer:GetMouse();
local _ = workspace.CurrentCamera;

function v1.skill3(p2) -- Line: 19
    local X = p2.humanoidRootPart.CFrame:VectorToObjectSpace(p2.human.MoveDirection).X;
    p2:senduse({ "skill3", math.round(X) == -1 and "Left" or "Right" });
end;

function v1.skill4(u3) -- Line: 30
    -- upvalues: GamepadContainer (copy), UserInputService (copy), RunService (copy)
    local setting = u3.player:FindFirstChild("setting");
    local u4 = true;
    local _target = u3:get_target(setting.customKeybinds.skill4.Value);
    local KeyCode = GamepadContainer[4].KeyCode;
    local Attribute = u3.character:GetAttribute("BreakdanceCount");
    shared.AwaitingUnholdForMobile.skill4 = true;
    local u5 = nil;
    local u6 = nil;
    u6 = UserInputService.InputEnded:Connect(function(p7, p8) -- Line: 42
        -- upvalues: _target (copy), KeyCode (copy), u4 (ref), u3 (copy), u6 (ref)
        if p7.KeyCode == _target or p7.KeyCode == KeyCode then
            u4 = false;
        end;

        if not u4 then
            u3:senduse({ "skill4", false });
            u6:Disconnect();
            shared.AwaitingUnholdForMobile.skill4 = nil;
            print("No longer pressing, sent use");
        end;
    end);
    u5 = RunService.RenderStepped:Connect(function() -- Line: 74
        -- upvalues: Attribute (copy), u3 (copy), u6 (ref), u5 (ref)
        if not shared.AwaitingUnholdForMobile.skill4 or Attribute ~= u3.character:GetAttribute("BreakdanceCount") then
            shared.AwaitingUnholdForMobile.skill4 = nil;

            if u6 and u6.Connected then
                u6:Disconnect();
                u6 = nil;
            end;

            u5:Disconnect();
            u5 = nil;
            print("Disconnecting, hold expired");
        end;
    end);
    u3:senduse({ "skill4", true });
end;

return v1;