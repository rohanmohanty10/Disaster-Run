 
 

local raycast = require(game:GetService("ReplicatedStorage").util.raycast);

return {
    { 5, function(p1) -- Line: 5
            shared.vfx.emit(p1.Spin1);
        end },
    { 51, function(p2, p3) -- Line: 10
            -- upvalues: raycast (copy)
            while p3 and (p3.Parent and (p3:IsDescendantOf(workspace) and not raycast(p3.Position, Vector3.new(0, -5, 0), 5, { workspace.map }))) do
                task.wait();
            end;

            if not p3.Parent:GetAttribute("hadballforthisstupidbug") then
                shared.vfx.emit(p2.Land);
            end;
        end }
};