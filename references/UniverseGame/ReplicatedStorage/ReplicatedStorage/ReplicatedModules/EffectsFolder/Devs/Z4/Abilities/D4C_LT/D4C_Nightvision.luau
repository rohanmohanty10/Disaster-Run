  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);

return function(p1, p2) -- Line: 6
    -- upvalues: Trove (copy)
    if not p1 or #p2 < 1 then
        return;
    end;

    local v3 = Trove.new();
    local HumanoidRootPart = p1.HumanoidRootPart;

    for _, v in p2 do
        local Head = v.Head;
        local v4 = math.ceil((HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude);
        local v5 = v3:Construct(Instance, "Attachment");
        v5.Name = "D4C_Overhead";
        v5.Parent = Head;
        v5.CFrame = CFrame.new(0, 2, 0);
        local v6 = script.Overhead:Clone();
        v6.Parent = v5;
        v6.Name = "D4C_BillboardUi";
        v6.TextLabel.Visible = v4 >= 25;
        v6.TextLabel.Text = v.Name .. " is " .. math.ceil(v4) .. " studs away!";
        local v7 = v3:Construct(Instance, "Highlight");
        v7.Parent = v;
        v7.OutlineColor = Color3.fromRGB(255, 255, 255);
        v7.FillTransparency = 1;
        v7.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
    end;

    while p1:GetAttribute("DimensionController") and p1.Parent do
        local HumanoidRootPart2 = p1:FindFirstChild("HumanoidRootPart");

        if HumanoidRootPart2 == nil then
            break;
        end;

        for _, v in p2 do
            local HumanoidRootPart3 = v:FindFirstChild("HumanoidRootPart");

            if HumanoidRootPart3 ~= nil then
                local Head = v:FindFirstChild("Head");

                if Head ~= nil then
                    local Magnitude = (HumanoidRootPart2.Position - HumanoidRootPart3.Position).Magnitude;
                    local D4C_Overhead = Head:FindFirstChild("D4C_Overhead");

                    if D4C_Overhead then
                        local D4C_BillboardUi = D4C_Overhead:FindFirstChild("D4C_BillboardUi");

                        if D4C_BillboardUi then
                            D4C_BillboardUi.TextLabel.Visible = Magnitude >= 25;
                            D4C_BillboardUi.TextLabel.Text = v.Name .. " is " .. math.ceil(Magnitude) .. " studs away!";
                        end;
                    end;
                end;
            end;
        end;

        task.wait(0.1);
    end;

    v3:Destroy();
end;