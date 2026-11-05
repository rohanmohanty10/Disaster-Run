  

 

local u1 = game:GetService("ReplicatedStorage")["Client Assets"]["Hit Effects"];

local function generateHeavy(p2, p3, p4) -- Line: 2
    -- upvalues: u1 (copy)
    local CFrame = p2.CFrame;
    local v5 = u1.Heavy:Clone();
    v5.CFrame = CFrame;
    v5.Parent = workspace.Effects;

    for _, child in ipairs(v5.Attachment:GetChildren()) do
        child:Emit(5);
    end;

    game:GetService("Debris"):AddItem(v5, 1);
end;

return function(p6, p7, p8) -- Line: 15
    -- upvalues: generateHeavy (copy)
    generateHeavy(p6.Torso or p6.PrimaryPart, p8.HitData);
end;