  

 

local UserInputService = game:GetService("UserInputService");
local UserGameSettings = UserSettings():GetService("UserGameSettings");
local Workspace = game:GetService("Workspace");
local disconnectAndClear = require(script.Parent.Parent.Parent.disconnectAndClear);
local u1 = Vector2.new(1, 0.66) * 0.017453292519943295;
local u2 = false;
local u3 = {};
local u4 = {};
local zero = Vector2.zero;

local function resetInput() -- Line: 17
    -- upvalues: zero (ref)
    zero = Vector2.zero;
end;

local function adjustTouchPitchSensitivity(p5) -- Line: 24
    -- upvalues: Workspace (copy)
    local CurrentCamera = Workspace.CurrentCamera;

    if not CurrentCamera then
        return p5;
    end;

    local v6 = CurrentCamera.CFrame:ToEulerAnglesYXZ();

    if p5.Y * v6 >= 0 then
        return p5;
    end;

    local v7 = (1 - (math.abs(v6) * 2 / 3.141592653589793) ^ 0.75) * 0.75 + 0.25;

    return Vector2.new(1, v7) * p5;
end;

local function onTouchMoved(p8, p9) -- Line: 50
    -- upvalues: u4 (copy), zero (ref)
    if p9 then
        return;
    end;

    if u4[p8] then
        return;
    end;

    zero = Vector2.new(p8.Delta.X, p8.Delta.Y);
end;

local function onInputBegan(p10, p11) -- Line: 60
    -- upvalues: u4 (copy)
    if p10.UserInputType == Enum.UserInputType.Touch and p11 then
        u4[p10] = true;
    end;
end;

local function onInputEnded(p12, p13) -- Line: 68
    -- upvalues: u4 (copy)
    if u4[p12] then
        u4[p12] = nil;
    end;
end;

return {
    getInput = function(p14, p15) -- Line: 76, Name: getInput
        -- upvalues: UserGameSettings (copy), adjustTouchPitchSensitivity (copy), zero (ref), u1 (copy)
        local v16 = Vector2.new(1, UserGameSettings:GetCameraYInvertValue());
        local v17 = adjustTouchPitchSensitivity(zero) * u1;
        zero = Vector2.zero;

        return v17 * v16;
    end,

    enable = function(p18) -- Line: 87, Name: enable
        -- upvalues: u2 (ref), u3 (copy), UserInputService (copy), onInputBegan (copy), onInputEnded (copy), onTouchMoved (copy), zero (ref)
        if u2 then
            return;
        end;

        u2 = true;
        table.insert(u3, UserInputService.InputBegan:Connect(onInputBegan));
        table.insert(u3, UserInputService.InputEnded:Connect(onInputEnded));
        table.insert(u3, UserInputService.TouchMoved:Connect(onTouchMoved));
        zero = Vector2.zero;
    end,

    disable = function(p19) -- Line: 100, Name: disable
        -- upvalues: u2 (ref), disconnectAndClear (copy), u3 (copy), u4 (copy)
        if not u2 then
            return;
        end;

        u2 = false;
        disconnectAndClear(u3);
        table.clear(u4);
    end
};