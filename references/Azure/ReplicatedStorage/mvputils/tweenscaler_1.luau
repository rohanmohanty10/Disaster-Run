 
 

local Debris = game:GetService("Debris");
local TweenService = game:GetService("TweenService");

return function(p1: userdata, p2: userdata, p3: number) -- Line: 4
    -- upvalues: Debris (copy), TweenService (copy)
    local Model = Instance.new("Model", workspace.Effects);
    p1.Parent = Model;
    Debris:AddItem(Model, 5);
    local NumberValue = Instance.new("NumberValue", Model);
    NumberValue:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 11
        -- upvalues: Model (copy), NumberValue (copy)
        Model:ScaleTo(NumberValue.Value);
    end);
    TweenService:Create(NumberValue, p2, {
        Value = p3
    }):Play();
end;