 

 

local Warn = require(script.Parent.Parent.Shared.Warn);
require(script.Parent.Parent.Shared.Types);
local Entity = require(script.Parent.Parent.Shared.Entity);

return function(p1) -- Line: 6
    -- upvalues: Entity (copy), Warn (copy)
    local _modelHandle = p1._modelHandle;
    local model = p1.model;

    if not _modelHandle or model and model.Parent then
        return;
    end;

    local v2 = _modelHandle:Get();

    if v2 and (v2.Parent and v2 ~= model) then
        Entity.SetModel(p1, v2);
        Warn.low((`Model {v2:GetFullName()} was resolved for entity {p1.id}.`));
    end;
end;