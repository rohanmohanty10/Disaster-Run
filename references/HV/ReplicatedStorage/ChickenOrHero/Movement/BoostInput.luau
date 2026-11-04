 

 

local ControlGate = require(script.Parent:WaitForChild("ControlGate"));
local u1 = {};
local u2 = nil;
local u3 = nil;

function u1.request(p4) -- Line: 5
    -- upvalues: u2 (ref), u3 (ref)
    u2 = os.clock();
    u3 = p4 == true;
end;

function u1.clear() -- Line: 9
    -- upvalues: u2 (ref), u3 (ref)
    u2 = nil;
    u3 = nil;
end;

function u1.consume() -- Line: 13
    -- upvalues: u2 (ref), u3 (ref), u1 (copy)
    local v5 = u2;
    u1.clear();
    local v6;

    if v5 == nil then
        v6 = false;
    else
        v6 = os.clock() - v5 <= 0.15;
    end;

    return v6, u3 == true;
end;

function u1.available(p7) -- Line: 18
    -- upvalues: ControlGate (copy)
    local Character = p7.Character;
    local v8;

    if Character then
        v8 = Character:FindFirstChildOfClass("Humanoid");
    else
        v8 = Character;
    end;

    local v9;

    if Character then
        v9 = Character:FindFirstChild("HumanoidRootPart");
    else
        v9 = Character;
    end;

    local Attribute = p7:GetAttribute("BladeHearts");
    local v10;

    if p7:GetAttribute("GameRole") == "Catcher" and (type(Attribute) ~= "number" or Attribute <= 0) or (v8 == nil or (v8.Health <= 0 or v9 == nil)) then
        v10 = false;
    else
        v10 = not (v9.Anchored or (v8.Sit or v8.PlatformStand or (Character:GetAttribute("MovementLocked") or Character:GetAttribute("TackleActive")))) and ControlGate.movementReason(p7) == nil;
    end;

    return v10;
end;

function u1.control() -- Line: 36
    local PreferredInput = game.UserInputService.PreferredInput;

    return PreferredInput == Enum.PreferredInput.Touch and "Tap DASH" or (PreferredInput == Enum.PreferredInput.Gamepad and "RT / R2" or "Space");
end;

return u1;