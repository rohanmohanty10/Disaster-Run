  

 

local Maid = require(game.ReplicatedStorage.ReplicatedModules.Maid);
local LocalPlayer = game.Players.LocalPlayer;
local u1 = {};

for _, child in pairs(workspace.Map:GetChildren()) do
    if child:FindFirstChild("Collisions") then
        table.insert(u1, child.Collisions);
    end;
end;

local function raycastMap(p2, p3, p4, p5) -- Line: 13
    -- upvalues: u1 (copy)
    local v6 = RaycastParams.new();
    v6.FilterDescendantsInstances = p5 and p5.Folder or u1;
    v6.FilterType = p5 and p5.RaycastType or Enum.RaycastFilterType.Whitelist;
    local v7 = workspace:Raycast(p2, p3, v6);

    if p4 then
        return v7;
    end;

    if v7 then
        return v7.Position;
    end;
end;

return function(p8, p9, p10, p11) -- Line: 25
    -- upvalues: Maid (copy), u1 (copy), LocalPlayer (copy)
    local v12 = Maid.new();
    local v13 = p10 and TweenInfo.new(unpack(p10)) or TweenInfo.new(0.1, Enum.EasingStyle.Sine);
    local v14 = p8.CFrame.LookVector * p9;
    local v15 = p8.CFrame + v14;
    local v16 = {
        Folder = {},
        RaycastType = Enum.RaycastFilterType.Blacklist
    };

    for _, child in ipairs(workspace:GetChildren()) do
        if child ~= workspace.Map then
            table.insert(v16.Folder, child);
        end;
    end;

    while true do
        local Position = p8.Position;
        local v17 = RaycastParams.new();
        v17.FilterDescendantsInstances = v16 and v16.Folder or u1;
        v17.FilterType = v16 and v16.RaycastType or Enum.RaycastFilterType.Whitelist;
        local v18 = workspace:Raycast(Position, v14, v17);

        if v18 then
            local Instance = v18.Instance;

            while Instance.Parent.ClassName ~= "Folder" do
                Instance = Instance.Parent;
            end;

            local v19 = Instance:IsA("Model") and table.pack(Instance:GetBoundingBox())[2] or Instance.Size;
            table.insert(v16.Folder, Instance);

            if v19.Magnitude >= v14.Magnitude then
                v15 = CFrame.new(v18.Position);
                break;
            end;
        end;

        if not v18 then
            break;
        end;
    end;

    local u20 = game:GetService("TweenService"):Create(p8, v13, {
        CFrame = v15
    });
    u20:Play();

    if p11 then
        v12:GiveTask(LocalPlayer.Character.AttributeChanged:Connect(function(p21) -- Line: 58
            -- upvalues: u20 (copy)
            if p21 == "RaycastCollision" then
                u20:Cancel();
            end;
        end));
    end;

    u20.Completed:Wait();
    v12:Destroy();
end;