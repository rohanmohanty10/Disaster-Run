  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
require(ReplicatedRoot.Core);
require(ReplicatedRoot.Libraries.Utility.DirectoryUtil);
require(ReplicatedRoot.Libraries.Classes.Trove);
require(ReplicatedRoot.Libraries.Classes.Signal);
require(script.Parent.Ability);
local u1 = {};
u1.__index = u1;
require(ReplicatedRoot.Libraries.Types.CommonTypes);

function u1.new(p2) -- Line: 20
    -- upvalues: u1 (copy)
    for i, v in pairs(u1) do
        p2[i] = v;
    end;

    return p2;
end;

return u1;