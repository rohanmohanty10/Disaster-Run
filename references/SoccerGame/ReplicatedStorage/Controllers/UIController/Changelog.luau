  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ReplicatedFirst = game:GetService("ReplicatedFirst");
local BG = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("Changelog"):WaitForChild("BG");
local Knit = require(ReplicatedStorage.Packages.Knit);
local u1 = {};
local v2 = Knit.CreateController({
    Name = "Changelog"
});

function v2.KnitStart(p3) -- Line: 23
    -- upvalues: ReplicatedFirst (copy), u1 (copy), BG (copy)
    for _, child in ReplicatedFirst.Changelog:GetChildren() do
        local v4, v5 = child.Name:match("(%d+) | (.+)");
        local v6 = tonumber(v4);

        if v6 and v5 then
            u1[v5] = require(child);
            local v7 = BG.UpdateList.List.UpdateTemplate:Clone();
            v7.Title.Text = v5;
            v7.LayoutOrder = -v6;
            v7.Icon.Image = u1[v5].icon;
            v7.Parent = BG.UpdateList.List;
            v7.Activated:Connect(function() -- Line: 39
            end);
        else
            warn("BAD CHANGELOG MODULE. NAMED INCORRECTLY: ", child);
        end;
    end;
end;

return v2;