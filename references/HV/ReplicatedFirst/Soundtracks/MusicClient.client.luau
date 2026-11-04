 

 

local script_Parent = script.Parent;
local u1 = require(script_Parent.MusicController).new(script_Parent.JoiningGameMusic, require(script_Parent.MusicConfig));
script.Destroying:Connect(function() -- Line: 4
    -- upvalues: u1 (copy)
    u1:destroy();
end);