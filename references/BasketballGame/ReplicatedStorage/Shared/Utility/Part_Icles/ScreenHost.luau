 
 

local CoreGui = game:GetService("CoreGui");
local v1 = {};
local u2 = nil;

function v1.get() -- Line: 7
    -- upvalues: u2 (ref), CoreGui (copy)
    if u2 and u2.Parent then
        return u2;
    end;

    u2 = Instance.new("ScreenGui");
    u2.Name = "PartIclesScreenHost";
    u2.Archivable = false;
    u2.DisplayOrder = -10;
    u2.ResetOnSpawn = false;
    u2.IgnoreGuiInset = true;
    u2.Parent = CoreGui;

    return u2;
end;

function v1.destroy() -- Line: 19
    -- upvalues: u2 (ref)
    if u2 then
        pcall(u2.Destroy, u2);
        u2 = nil;
    end;
end;

function v1.exists() -- Line: 23
    -- upvalues: u2 (ref)
    return u2 and u2.Parent ~= nil;
end;

return v1;