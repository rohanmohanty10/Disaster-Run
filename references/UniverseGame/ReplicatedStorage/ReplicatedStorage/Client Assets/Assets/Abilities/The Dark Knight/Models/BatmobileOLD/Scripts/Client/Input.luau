  

 

local GuiService = game:GetService("GuiService");
local RunService = game:GetService("RunService");
local Constants = require(script.Parent.Parent.Constants);
local InputCategorizer = require(script.Parent.InputCategorizer);
local u1 = {
    [InputCategorizer.InputCategory.KeyboardAndMouse] = require(script.KeyboardAndMouse),
    [InputCategorizer.InputCategory.Gamepad] = require(script.Gamepad),
    [InputCategorizer.InputCategory.Touch] = require(script.Touch)
};
local disconnectAndClear = require(script.Parent.disconnectAndClear);
local Inputs = script.Parent.Parent.Parent.Inputs;
local u2 = InputCategorizer.getLastInputCategory();
local u3 = false;
local u4 = {};

local function onLastInputCategoryChanged(p5) -- Line: 20
    -- upvalues: u2 (ref), u1 (copy)
    u2 = p5;

    for i, v in u1 do
        if i == p5 then
            v:enable();
        else
            v:disable();
        end;
    end;
end;

local function update() -- Line: 32
    -- upvalues: u1 (copy), u2 (ref), Inputs (copy), Constants (copy)
    local v6 = u1[u2];

    if not v6 then
        return;
    end;

    local v7, v8 = v6:getThrottleAndSteering();
    Inputs:SetAttribute(Constants.THROTTLE_INPUT_ATTRIBUTE, v7);
    Inputs:SetAttribute(Constants.STEERING_INPUT_ATTRIBUTE, v8);
end;

return {
    enable = function(p9) -- Line: 45, Name: enable
        -- upvalues: u3 (ref), GuiService (copy), u4 (copy), InputCategorizer (copy), onLastInputCategoryChanged (copy), RunService (copy), update (copy)
        if u3 then
            return;
        end;

        u3 = true;
        GuiService.TouchControlsEnabled = false;
        table.insert(u4, InputCategorizer.lastInputCategoryChanged:Connect(onLastInputCategoryChanged));
        table.insert(u4, RunService.Stepped:Connect(update));
        onLastInputCategoryChanged(InputCategorizer.getLastInputCategory());
    end,

    disable = function(p10) -- Line: 60, Name: disable
        -- upvalues: u3 (ref), GuiService (copy), u1 (copy), disconnectAndClear (copy), u4 (copy)
        if not u3 then
            return;
        end;

        u3 = false;
        GuiService.TouchControlsEnabled = true;

        for _, v in u1 do
            v:disable();
        end;

        disconnectAndClear(u4);
    end
};