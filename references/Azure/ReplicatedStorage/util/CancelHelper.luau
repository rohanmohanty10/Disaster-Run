 

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.forum.trove);

return {
    get = function(p1) -- Line: 9, Name: get
        local BoolValue = Instance.new("BoolValue");
        BoolValue.Parent = p1;

        return BoolValue;
    end,

    cancelHelperToTrove = function(p2: userdata, u3: any) -- Line: 15, Name: cancelHelperToTrove
        local v4 = {};
        table.insert(v4, u3:Add(p2.Changed:Connect(function(p5) -- Line: 17
            -- upvalues: u3 (copy)
            if p5 then
                u3:Destroy();
            end;
        end)));

        return p2, v4;
    end
};