  

 

local ContextActionService = game:GetService("ContextActionService");
local _ = script.Parent.Parent.Parent.Server.Replicate;
local u1 = {};
local v2 = {
    _Enabled = false
};

for _, child in script:GetChildren() do
    if child:IsA("ModuleScript") then
        u1[child.Name] = require(child);
    end;
end;

function v2.Enable(p3) -- Line: 16
    -- upvalues: u1 (copy), ContextActionService (copy)
    if p3._Enabled then
        return;
    end;

    p3._Enabled = true;

    for i, v in u1 do
        ContextActionService:BindAction(i, v.Execute, false, v.Bind);
    end;
end;

function v2.Disable(p4) -- Line: 27
    -- upvalues: u1 (copy), ContextActionService (copy)
    if not p4._Enabled then
        return;
    end;

    p4._Enabled = false;

    for i, _ in u1 do
        ContextActionService:UnbindAction(i);
    end;
end;

return v2;