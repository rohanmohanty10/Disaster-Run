  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
local Core = require(ReplicatedRoot.Core);
require(ReplicatedRoot.Libraries.Utility.DirectoryUtil);
require(ReplicatedRoot.Libraries.Utility.TableUtil);
require(ReplicatedRoot.Libraries.Classes.Trove);
require(ReplicatedRoot.Libraries.Classes.Signal);
require(script.Parent.MoveAction);
local u1 = {};
u1.__index = u1;
require(ReplicatedRoot.Libraries.Types.CommonTypes);

function u1.new(p2) -- Line: 21
    -- upvalues: u1 (copy)
    for i, v in pairs(u1) do
        p2[i] = v;
    end;

    return p2;
end;

function u1.InvokeServer(p3, p4) -- Line: 30
    -- upvalues: Core (copy)
    return require(Core.ReplicatedServices.MoveInputController).InvokeMove(p3, p4);
end;

function u1.ActivateServer(p5, p6) -- Line: 35
    return p5:InvokeServer({
        Type = "Activate",
        Arguments = p6.Arguments or {},
        RequestId = p6.Parameters.RequestId or p6.Id
    });
end;

function u1.DeactivateServer(p7, p8) -- Line: 43
    return p7:InvokeServer({
        Type = "Deactivate",
        Arguments = p8.Arguments or {},
        RequestId = `{p8.Parameters.RequestId or p8.Id}-Deactivate`
    });
end;

return u1;