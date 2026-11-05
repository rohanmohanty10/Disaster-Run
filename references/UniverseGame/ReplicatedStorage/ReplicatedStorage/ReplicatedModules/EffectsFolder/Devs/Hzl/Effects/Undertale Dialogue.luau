  

 

local u1 = game:GetService("ReplicatedStorage")["Client Assets"];

return function(p2) -- Line: 3
    -- upvalues: u1 (copy)
    require(u1.Undertale.UT_DialogueHandler).NewDialogue(p2);
end;