  

local v1 = {};
game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
require(ReplicatedStorage.Shared.Essentials);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);

function v1.SetupCosmetic(u2, p3) -- Line: 9
    -- upvalues: CollectionService (copy), EmitModule (copy)
    local v4 = script.Part:Clone();
    v4:PivotTo(u2.Torso.CFrame * script.Torso.CFrame:ToObjectSpace(v4:GetPivot()));
    v4.Parent = u2.Torso;
    CollectionService:AddTag(v4, (`Cosmetic{p3}`));
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = u2.Torso;
    WeldConstraint.Part1 = v4;
    WeldConstraint.Parent = v4;
    local u5 = {};

    for _, child in script.Torso:GetChildren() do
        local v6 = child:Clone();
        v6.Parent = u2.Torso;
        table.insert(u5, v6);
        CollectionService:AddTag(v6, (`Cosmetic{p3}`));
    end;

    task.spawn(function() -- Line: 32
        -- upvalues: u2 (copy), u5 (copy), EmitModule (ref)
        while workspace:IsAncestorOf(u2.Parent) do
            for _, v in u5 do
                EmitModule.emit(v);
            end;

            task.wait(1.5);
        end;
    end);
end;

return v1;