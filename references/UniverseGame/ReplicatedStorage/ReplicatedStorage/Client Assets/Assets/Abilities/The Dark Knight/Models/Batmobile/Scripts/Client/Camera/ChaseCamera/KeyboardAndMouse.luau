  

 

local UserInputService = game:GetService("UserInputService");
local UserGameSettings = UserSettings():GetService("UserGameSettings");
local disconnectAndClear = require(script.Parent.Parent.Parent.disconnectAndClear);
local MouseButton2 = Enum.UserInputType.MouseButton2;
local u1 = Vector2.new(1, 0.77) * 0.008726646259971648;
local u2 = Vector2.new(1, 0.77) * 0.12217304763960307;
local u3 = false;
local u4 = false;
local u5 = {};
local zero = Vector2.zero;
local zero2 = Vector2.zero;

local function resetInput() -- Line: 17
    -- upvalues: zero (ref), zero2 (ref)
    zero = Vector2.zero;
    zero2 = Vector2.zero;
end;

local function onInputChanged(p6) -- Line: 22
    -- upvalues: u4 (ref), zero (ref)
    if p6.UserInputType == Enum.UserInputType.MouseMovement and u4 then
        zero = Vector2.new(p6.Delta.X, p6.Delta.Y);
    end;
end;

local function onInputBegan(p7, p8) -- Line: 30
    -- upvalues: MouseButton2 (copy), u4 (ref), UserInputService (copy)
    if p8 then
        return;
    end;

    if p7.UserInputType == MouseButton2 and not u4 then
        u4 = true;
        UserInputService.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition;
    end;
end;

local function onInputEnded(p9, p10) -- Line: 43
    -- upvalues: MouseButton2 (copy), u4 (ref), UserInputService (copy)
    if p9.UserInputType == MouseButton2 and u4 then
        u4 = false;
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
    end;
end;

local function onPointerAction(p11, p12, p13, p14) -- Line: 53
    -- upvalues: zero2 (ref)
    if p14 then
        return;
    end;

    zero2 = p12;
end;

return {
    getInput = function(p15, p16) -- Line: 63, Name: getInput
        -- upvalues: UserGameSettings (copy), zero (ref), u1 (copy), zero2 (ref), u2 (copy)
        local v17 = Vector2.new(1, UserGameSettings:GetCameraYInvertValue());
        local v18 = zero * u1 + zero2 * u2;
        zero = Vector2.zero;
        zero2 = Vector2.zero;

        return v18 * v17;
    end,

    enable = function(p19) -- Line: 74, Name: enable
        -- upvalues: u3 (ref), u5 (copy), UserInputService (copy), onInputBegan (copy), onInputEnded (copy), onInputChanged (copy), onPointerAction (copy), zero (ref), zero2 (ref)
        if u3 then
            return;
        end;

        u3 = true;
        table.insert(u5, UserInputService.InputBegan:Connect(onInputBegan));
        table.insert(u5, UserInputService.InputEnded:Connect(onInputEnded));
        table.insert(u5, UserInputService.InputChanged:Connect(onInputChanged));
        table.insert(u5, UserInputService.PointerAction:Connect(onPointerAction));
        zero = Vector2.zero;
        zero2 = Vector2.zero;
    end,

    disable = function(p20) -- Line: 88, Name: disable
        -- upvalues: u3 (ref), disconnectAndClear (copy), u5 (copy), UserInputService (copy)
        if not u3 then
            return;
        end;

        u3 = false;
        disconnectAndClear(u5);
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
    end
};