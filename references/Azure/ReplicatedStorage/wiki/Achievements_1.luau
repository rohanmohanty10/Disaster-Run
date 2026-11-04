 
 

game:GetService("ReplicatedStorage");

local function newAchievement(p1, p2, p3, p4) -- Line: 3
    return {
        Title = p1,
        Desc = p2,
        Requirement = {
            Type = p3,
            Amount = p4
        }
    };
end;

return { {
        Title = "Score",
        Desc = "",
        Requirement = {
            Type = nil,
            Amount = nil
        }
    } };