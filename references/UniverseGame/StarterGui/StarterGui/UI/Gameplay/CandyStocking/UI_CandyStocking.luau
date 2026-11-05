  

 

return function(u1) -- Line: 1
    local Parent = script.Parent;
    local Holder = Parent.Holder;
    local LocalPlayer = game:GetService("Players").LocalPlayer;
    local u2 = u1.Knit.GetService("EventCandyService");

    if LocalPlayer then
        LocalPlayer:FindFirstChild("Data");
    end;

    local Fusion = require(game:GetService("ReplicatedStorage").ClientLibrary.Fusion);
    local ItemData = require(game.ReplicatedStorage.ReplicatedModules.ItemData);
    TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
    local u3 = {
        CurrentInventory = Fusion.Value({})
    };

    local function UpdateData() -- Line: 22
        -- upvalues: u2 (copy), u3 (copy)
        local v4 = u2:GetCandyInventory():expect();

        if v4 and typeof(v4) == "table" then
            u3.CurrentInventory:set(v4);
        end;

        task.wait();
    end;

    u2.ReceiptUpdated:Connect(function(p5) -- Line: 32
        -- upvalues: u3 (copy)
        u3.CurrentInventory:set(p5);
    end);
    local v6 = u2:GetCandyInventory():expect();

    if v6 and typeof(v6) == "table" then
        u3.CurrentInventory:set(v6);
    end;

    task.wait();

    local function UpdateEntry(p7, p8) -- Line: 39
        -- upvalues: ItemData (copy), Holder (copy), u1 (copy)
        local v9 = ItemData.GetItemInfo(p7);

        if not (v9 and Holder:FindFirstChild(v9.Name)) then
            return;
        end;

        local v10 = Holder:FindFirstChild(v9.Name);
        local Count = p8.Count;
        local _Candy_Halloween_Conversion_Price = v9._Candy_Halloween_Conversion_Price;
        v10.Count.Text = "x" .. Count;
        v10.Value.Text = `Value (1x): <font color="#ff55ff">{_Candy_Halloween_Conversion_Price}{u1.EventCurrencyString}</font>`;
        v10.ValueTotal.Text = `Value (Owned): <font color="#ff55ff">{_Candy_Halloween_Conversion_Price * Count}{u1.EventCurrencyString}</font>`;
    end;

    Fusion.Observer(u3.CurrentInventory):onChange(function() -- Line: 51
        -- upvalues: u3 (copy), Holder (copy), ItemData (copy), UpdateEntry (copy)
        local v11 = u3.CurrentInventory:get();

        for _, child in Holder:GetChildren() do
            if child:IsA("Frame") and (child.Name ~= "Spacer" and child:FindFirstChild("Count")) then
                local v12 = ItemData.GetItemByName(child.Name);

                if v12 then
                    UpdateEntry(v12.ItemId, {
                        Count = 0
                    });
                end;
            end;
        end;

        for i, v in v11 do
            UpdateEntry(i, {
                Count = v
            });
        end;
    end);
    Parent.Close.MouseButton1Click:Connect(function() -- Line: 70
        -- upvalues: Parent (copy)
        Parent.Visible = false;
    end);

    function u1.OpenCandyStocking(p13) -- Line: 74
        -- upvalues: u2 (copy), u3 (copy), Parent (copy)
        local v14 = u2:GetCandyInventory():expect();

        if v14 and typeof(v14) == "table" then
            u3.CurrentInventory:set(v14);
        end;

        task.wait();
        Parent.Visible = true;
    end;
end;