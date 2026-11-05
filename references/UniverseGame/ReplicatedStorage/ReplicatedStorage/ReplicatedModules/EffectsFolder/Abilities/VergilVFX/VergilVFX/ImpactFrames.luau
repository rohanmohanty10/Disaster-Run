  

 

local u1 = {
    Impact1 = { "rbxassetid://110045172323816", "rbxassetid://137160353191198", "rbxassetid://86070931259150", "rbxassetid://76057346618052" },
    Impact2 = { "rbxassetid://74522837584980", "rbxassetid://98839732250976", "rbxassetid://114500380699889", "rbxassetid://89690655975460" },
    Impact3 = { "rbxassetid://86803200451412", "rbxassetid://99224853959841", "rbxassetid://84989752330753", "rbxassetid://97645196196257", "rbxassetid://99973493818132", "rbxassetid://115709759360933", "rbxassetid://87658336020853" }
};
local ContentProvider = game:GetService("ContentProvider");

local function u4(p2, p3) -- Line: 64
end;

task.spawn(function() -- Line: 68
    -- upvalues: u1 (copy), ContentProvider (copy), u4 (copy)
    for _, v in u1 do
        ContentProvider:PreloadAsync(v, u4);
    end;
end);

return function(p5, p6) -- Line: 25, Name: PlayFrame
    -- upvalues: u1 (copy)
    local v7 = u1[p5];
    local Core = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Core");
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    ImageLabel.Position = UDim2.fromScale(0.5, 0.5);
    ImageLabel.Size = UDim2.fromScale(1, 1);
    ImageLabel.Visible = true;
    ImageLabel.Parent = Core;
    local v8 = p6 or 1;

    for _, v in v7 do
        ImageLabel.Image = v;
        task.wait(v8 / 60);
    end;

    ImageLabel:Destroy();
end;