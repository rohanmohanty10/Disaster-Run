  

 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");

return function(u1) -- Line: 4
    -- upvalues: Players (copy), ReplicatedStorage (copy)
    local LocalPlayer = Players.LocalPlayer;
    local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
    local Knit = require(PathShortcuts.KnitPath.Knit);
    require(PathShortcuts.KnitPath.Trove);
    local ItemData = require(PathShortcuts.ReplicatedModules.ItemData);
    local Parent = script.Parent;
    local TitleList = Parent.TitleList;
    local TitleButton = Parent.Assets.TitleButton;
    Parent.Back.MouseButton1Click:Connect(function() -- Line: 15
        -- upvalues: u1 (copy)
        u1:SetMenu("Menu");
    end);
    Parent.Close.MouseButton1Click:Connect(function() -- Line: 19
        -- upvalues: Parent (copy)
        Parent.Visible = false;
    end);
    Knit.OnStart():await();
    local u2 = Knit.GetService("TitleService");
    local u3 = Color3.fromRGB(85, 255, 0);
    local u4 = Color3.fromRGB(50, 50, 50);
    local u5 = {};

    local function EquipTitle(p6, p7) -- Line: 31
        -- upvalues: u2 (copy), u5 (copy), u3 (copy), u4 (copy)
        local v8 = u2:EquipTitle(p7):expect();

        for _, v in u5 do
            local v9;

            if v.Name == v8 then
                v9 = u3;
            else
                v9 = u4;
            end;

            v.BackgroundColor3 = v9;
        end;
    end;

    for i, _ in u2:GetOwnedTitles():expect() do
        local v10 = ItemData.GetTitle(i);

        if v10 and not TitleList:FindFirstChild(i) then
            local v11 = tonumber(i:match("%d+"));
            local u12 = TitleButton:Clone();
            local v13 = v10.DisplayName or v10.Name;

            if v10.NameCallback then
                v13 = v10.NameCallback(v10, {
                    Player = LocalPlayer
                });
            end;

            u12.Name = i;
            u12.Label.Text = v13;
            u12.Label.TextColor3 = v10.Color or u12.Label.TextColor3;
            u12.LayoutOrder = v11;
            u12.Visible = true;
            u12.Parent = TitleList;
            u12.MouseButton1Click:Connect(function() -- Line: 62
                -- upvalues: u12 (copy), i (copy), u2 (copy), u5 (copy), u3 (copy), u4 (copy)
                local v14 = u2:EquipTitle(i):expect();

                for _, v in u5 do
                    local v15;

                    if v.Name == v14 then
                        v15 = u3;
                    else
                        v15 = u4;
                    end;

                    v.BackgroundColor3 = v15;
                end;
            end);
            table.insert(u5, u12);
        end;
    end;

    u2.TitleChanged:Connect(function(u16, p17) -- Line: 69
        -- upvalues: ItemData (copy), TitleList (copy), TitleButton (copy), LocalPlayer (copy), u2 (copy), u5 (copy), u3 (copy), u4 (copy)
        local v18 = ItemData.GetTitle(u16);

        if not v18 then
            return;
        end;

        if not p17 then
            local v19 = TitleList:FindFirstChild(u16);

            if not v19 then
                return;
            end;

            local v20 = table.find(u5, v19);

            if v20 then
                table.remove(u5, v20);
            end;

            v19:Destroy();

            return;
        end;

        if TitleList:FindFirstChild(u16) then
            return;
        end;

        local v21 = tonumber(u16:match("%d+"));
        local u22 = TitleButton:Clone();
        local v23 = v18.DisplayName or v18.Name;

        if v18.NameCallback then
            v23 = v18.NameCallback(v18, {
                Player = LocalPlayer
            });
        end;

        u22.Name = u16;
        u22.Label.Text = v23;
        u22.Label.TextColor3 = v18.Color or u22.Label.TextColor3;
        u22.LayoutOrder = v21;
        u22.Visible = true;
        u22.Parent = TitleList;
        u22.MouseButton1Click:Connect(function() -- Line: 93
            -- upvalues: u22 (copy), u16 (copy), u2 (ref), u5 (ref), u3 (ref), u4 (ref)
            local v24 = u2:EquipTitle(u16):expect();

            for _, v in u5 do
                local v25;

                if v.Name == v24 then
                    v25 = u3;
                else
                    v25 = u4;
                end;

                v.BackgroundColor3 = v25;
            end;
        end);
        table.insert(u5, u22);
    end);
    local v26 = u2:GetEquippedTitle():expect();

    for _, v in u5 do
        if v.Name == v26 then
            v.BackgroundColor3 = u3;
        end;
    end;
end;