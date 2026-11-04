 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local actionUtil = require(ReplicatedStorage.util.actionUtil);
local GamepadContainer = require(ReplicatedStorage.client.GamepadContainer);
local v1 = {
    __index = {}
};

local function waltz(u2: any, u3: string, p4: number) -- Line: 11
    -- upvalues: GamepadContainer (copy), UserInputService (copy), RunService (copy)
    local _target = u2:get_target(u2.player.setting.customKeybinds[u3].Value);
    local KeyCode = GamepadContainer[p4].KeyCode;
    local u5 = false;
    local u6 = nil;
    local u7 = nil;

    local function stop() -- Line: 17
        -- upvalues: u3 (copy), u6 (ref), u7 (ref)
        shared.AwaitingUnholdForMobile[u3] = nil;
        u6:Disconnect();
        u7:Disconnect();
    end;

    shared.AwaitingUnholdForMobile[u3] = true;
    u6 = UserInputService.InputEnded:Connect(function(p8) -- Line: 24
        -- upvalues: _target (copy), KeyCode (copy), u3 (copy), u6 (ref), u7 (ref), u2 (copy)
        if p8.KeyCode == _target or (p8.UserInputType == _target or p8.KeyCode == KeyCode) then
            shared.AwaitingUnholdForMobile[u3] = nil;
            u6:Disconnect();
            u7:Disconnect();
            u2:senduse({ u3, false });
        end;
    end);
    u7 = RunService.RenderStepped:Connect(function() -- Line: 30
        -- upvalues: u2 (copy), u5 (ref), u3 (copy), u6 (ref), u7 (ref)
        local Attribute = u2.character:GetAttribute("RolandWaltz");
        u5 = u5 or Attribute;

        if not (shared.AwaitingUnholdForMobile[u3] and (not u5 or Attribute)) then
            shared.AwaitingUnholdForMobile[u3] = nil;
            u6:Disconnect();
            u7:Disconnect();
        end;
    end);
    u2:senduse({ u3, true });
end;

local function card(u9: string, u10: number) -- Line: 41
    -- upvalues: actionUtil (copy), waltz (copy)
    return function(p11) -- Line: 42
        -- upvalues: u10 (copy), actionUtil (ref), waltz (ref), u9 (copy)
        if (p11.character:GetAttribute("RolandHand") or ""):split(",")[u10] == "crystal" and actionUtil.checkball(p11.character) then
            waltz(p11, u9, u10);

            return;
        end;

        p11:senduse({ u9, p11.humanoidRootPart.CFrame:VectorToObjectSpace(p11.human.MoveDirection).X < -0.5 and "left" or "right" });
    end;
end;

local u12 = 1;
local u13 = "skill1";

function v1.skill1(p14) -- Line: 42
    -- upvalues: u12 (copy), actionUtil (copy), waltz (copy), u13 (copy)
    if (p14.character:GetAttribute("RolandHand") or ""):split(",")[u12] == "crystal" and actionUtil.checkball(p14.character) then
        waltz(p14, u13, u12);

        return;
    end;

    p14:senduse({ u13, p14.humanoidRootPart.CFrame:VectorToObjectSpace(p14.human.MoveDirection).X < -0.5 and "left" or "right" });
end;

local u15 = 2;
local u16 = "skill2";

function v1.skill2(p17) -- Line: 42
    -- upvalues: u15 (copy), actionUtil (copy), waltz (copy), u16 (copy)
    if (p17.character:GetAttribute("RolandHand") or ""):split(",")[u15] == "crystal" and actionUtil.checkball(p17.character) then
        waltz(p17, u16, u15);

        return;
    end;

    p17:senduse({ u16, p17.humanoidRootPart.CFrame:VectorToObjectSpace(p17.human.MoveDirection).X < -0.5 and "left" or "right" });
end;

local u18 = 3;
local u19 = "skill3";

function v1.skill3(p20) -- Line: 42
    -- upvalues: u18 (copy), actionUtil (copy), waltz (copy), u19 (copy)
    if (p20.character:GetAttribute("RolandHand") or ""):split(",")[u18] == "crystal" and actionUtil.checkball(p20.character) then
        waltz(p20, u19, u18);

        return;
    end;

    p20:senduse({ u19, p20.humanoidRootPart.CFrame:VectorToObjectSpace(p20.human.MoveDirection).X < -0.5 and "left" or "right" });
end;

local u21 = 4;
local u22 = "skill4";

function v1.skill4(p23) -- Line: 42
    -- upvalues: u21 (copy), actionUtil (copy), waltz (copy), u22 (copy)
    if (p23.character:GetAttribute("RolandHand") or ""):split(",")[u21] == "crystal" and actionUtil.checkball(p23.character) then
        waltz(p23, u22, u21);

        return;
    end;

    p23:senduse({ u22, p23.humanoidRootPart.CFrame:VectorToObjectSpace(p23.human.MoveDirection).X < -0.5 and "left" or "right" });
end;

function v1.skill5(p24) -- Line: 59
    p24:senduse({ "skill5" });
end;

return v1;