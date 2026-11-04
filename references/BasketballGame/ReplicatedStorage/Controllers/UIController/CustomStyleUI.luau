 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = require(ReplicatedStorage.Packages.Knit).CreateController({
    Name = "CustomStyleUI"
});

function u1.KnitInit(p2) -- Line: 9
end;

function u1.KnitStart(p3) -- Line: 13
    -- upvalues: u1 (copy)
    for _, child in script:GetChildren() do
        task.spawn(require(child), u1);
    end;
end;

return u1;