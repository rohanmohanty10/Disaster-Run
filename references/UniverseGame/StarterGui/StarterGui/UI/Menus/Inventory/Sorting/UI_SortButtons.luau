  

 

local SortButton = require(script.SortButton);

return function(p1) -- Line: 2
    -- upvalues: SortButton (copy)
    local Parent = script.Parent;
    SortButton(p1, {
        Name = "Order",
        Text = "Sort by: A-Z",
        Visible = true,
        Size = UDim2.fromScale(0.5, 1),
        Buttons = { {
                Name = "A",
                Text = "A-Z"
            }, {
                Name = "B",
                Text = "Z-A"
            }, {
                Name = "C",
                Text = "Type"
            }, {
                Name = "D",
                Text = "Highest Rarity"
            }, {
                Name = "E",
                Text = "Lowest Rarity"
            } },
        Parent = Parent
    });
    SortButton(p1, {
        Name = "Search",
        Visible = true,
        Size = UDim2.fromScale(0.5, 1),
        Parent = Parent
    });
end;