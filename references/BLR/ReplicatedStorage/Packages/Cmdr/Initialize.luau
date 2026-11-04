  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local StarterGui = game:GetService("StarterGui");
local CreateGui = require(script.Parent.CreateGui);

return function(p1) -- Line: 6
    -- upvalues: ReplicatedStorage (copy), StarterGui (copy), CreateGui (copy)
    local u2 = nil;

    local function Create(p3, p4, p5) -- Line: 9
        -- upvalues: u2 (ref)
        local Instance_new_ret = Instance.new(p3);
        Instance_new_ret.Name = p4;
        Instance_new_ret.Parent = p5 or u2;

        return Instance_new_ret;
    end;

    u2 = script.Parent.CmdrClient;
    u2.Parent = ReplicatedStorage;
    local RemoteFunction = Instance.new("RemoteFunction");
    RemoteFunction.Name = "CmdrFunction";
    RemoteFunction.Parent = u2;
    local RemoteEvent = Instance.new("RemoteEvent");
    RemoteEvent.Name = "CmdrEvent";
    RemoteEvent.Parent = u2;
    local Folder = Instance.new("Folder");
    Folder.Name = "Commands";
    Folder.Parent = u2;
    local Folder2 = Instance.new("Folder");
    Folder2.Name = "Types";
    Folder2.Parent = u2;
    script.Parent.Shared.Parent = u2;
    p1.ReplicatedRoot = u2;
    p1.RemoteFunction = RemoteFunction;
    p1.RemoteEvent = RemoteEvent;
    p1:RegisterTypesIn(script.Parent.BuiltInTypes);
    script.Parent.BuiltInTypes:Destroy();
    script.Parent.BuiltInCommands.Name = "Server commands";

    if StarterGui:FindFirstChild("Cmdr") == nil then
        CreateGui();
    end;
end;