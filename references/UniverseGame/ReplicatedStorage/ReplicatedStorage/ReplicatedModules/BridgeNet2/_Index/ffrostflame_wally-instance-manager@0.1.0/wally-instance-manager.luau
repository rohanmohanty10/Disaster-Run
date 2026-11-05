  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");

return {
    add = function(p1, p2) -- Line: 5, Name: add
        -- upvalues: ReplicatedStorage (copy)
        if not ReplicatedStorage:FindFirstChild(p1.Name) then
            local Folder = Instance.new("Folder");
            Folder.Name = p1.Name;
            Folder.Parent = ReplicatedStorage;
        end;

        p2.Parent = ReplicatedStorage:FindFirstChild(p1.Name);
    end,

    get = function(p3, p4) -- Line: 15, Name: get
        -- upvalues: ReplicatedStorage (copy)
        if ReplicatedStorage:FindFirstChild(p3.Name) == nil then
            return nil;
        end;

        return ReplicatedStorage[p3.Name]:FindFirstChild(p4);
    end,

    waitForInstance = function(p5, p6, p7) -- Line: 21, Name: waitForInstance
        -- upvalues: ReplicatedStorage (copy)
        return ReplicatedStorage:WaitForChild(p5.Name):WaitForChild(p6, p7 or 1);
    end
};