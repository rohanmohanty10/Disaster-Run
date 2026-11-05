  

 

return function(p1) -- Line: 1
    local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
    require(PathShortcuts.KnitPath.Promise);
    require(PathShortcuts.KnitPath.Trove);
    local Parent = script.Parent;
    local Parent2 = Parent.Parent;

    local function ShowFrame(p2) -- Line: 10
        -- upvalues: Parent2 (copy)
        for _, child in Parent2.Frame:GetChildren() do
            child.Visible = p2 == child.Name;
        end;
    end;

    Parent.BlackmarketTab.MouseButton1Click:Connect(function() -- Line: 16
        -- upvalues: Parent2 (copy)
        for _, child in Parent2.Frame:GetChildren() do
            child.Visible = child.Name == "Backpack";
        end;

        Parent2.Info.Visible = false;
    end);
    Parent.ShardTab.MouseButton1Click:Connect(function() -- Line: 21
        -- upvalues: Parent2 (copy)
        for _, child in Parent2.Frame:GetChildren() do
            child.Visible = child.Name == "ShardConvert";
        end;

        Parent2.Info.Visible = false;
    end);
    local Core = require(game:GetService("ReplicatedStorage").ReplicatedRoot:WaitForChild("Core"));
    Core.OnStart():await();
    local u3 = Core.GetClientService("ConfigurationService"):GetFFlags():expect();

    function p1.ShowBlackMarket(p4) -- Line: 32
        -- upvalues: u3 (copy), Parent2 (copy)
        p4.ShowBlackMarketItems();
        p4:SetMenu("Black Market");

        if not u3.new_backpack_enabled then
            game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, not Parent2.Visible);
        end;

        Parent2:GetPropertyChangedSignal("Visible"):Once(function() -- Line: 40
            -- upvalues: Parent2 (ref), u3 (ref)
            if Parent2.Visible == false and not u3.new_backpack_enabled then
                game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, not Parent2.Visible);
            end;
        end);
    end;
end;