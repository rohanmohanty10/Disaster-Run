  

 

return function(p1) -- Line: 1
    local Parent = script.Parent;
    local Assets = Parent.Assets;
    local List = Parent.List;
    local Close = Parent.Close;
    local _ = Parent.Buttons;
    local Buttons = Parent.Buttons;
    local Button = Assets.Button;
    local TabButton = Assets.TabButton;
    local _ = game.Players.LocalPlayer;
    local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
    local Stands = require(PathShortcuts.ReplicatedModules.Stands);
    local u2 = p1.Knit.GetService("PlayerDataService");
    local UserService = game:GetService("UserService");
    local u3 = { "Wipe" };

    local function CreateContainer(p4) -- Line: 25
        -- upvalues: Assets (copy), u3 (copy), Button (copy)
        local v5 = Assets.Frame:Clone();
        v5.Username.Text = `@{p4.Username}`;
        v5.DisplayName.Text = `{p4.DisplayName}`;
        v5.UserId.Text = `{p4.UserId}`;

        for i, v in u3 do
            local v6 = Button:Clone();
            v6.Name = v;
            v6.TextLabel.Text = v;
            v6.Visible = true;
            v6.LayoutOrder = i;
            v6.Size = UDim2.fromScale(1 / #u3, 1);
            v6.Parent = v5.Buttons;
        end;

        return v5;
    end;

    local u7 = {};

    local function ClearList() -- Line: 46
        -- upvalues: List (copy)
        for _, child in List:GetChildren() do
            if child:IsA("Frame") then
                child:Destroy();
            end;
        end;
    end;

    function p1.ViewSigmaLeaderboard(p8, p9, p10, p11) -- Line: 54
        -- upvalues: UserService (copy), u7 (copy), ClearList (copy), CreateContainer (copy), List (copy), u2 (copy), Stands (copy), Parent (copy)
        local function CreateDict(p12) -- Line: 59
            -- upvalues: UserService (ref)
            local v13 = {};

            for _, v in p12 do
                if v.UserId >= 1 then
                    table.insert(v13, v.UserId);
                end;
            end;

            local v14 = UserService:GetUserInfosByUserIdsAsync(v13);
            local v15 = {};

            for _, v in p12 do
                if v.UserId >= 1 then
                    v15[v.UserId] = v;
                end;
            end;

            for _, v in v14 do
                v15[v.Id].Username = v.Username;
                v15[v.Id].DisplayName = v.DisplayName;
            end;

            return v15;
        end;

        local u16 = CreateDict(p9 or {});
        local u17 = CreateDict(p10 or {});
        local u18 = CreateDict(p11 or {});

        function u7.UCoins() -- Line: 86
            -- upvalues: ClearList (ref), u16 (copy), CreateContainer (ref), List (ref), u2 (ref), u17 (copy), u18 (copy)
            ClearList();

            for i, v in u16 do
                local u19 = CreateContainer(v);
                u19.Info.Text = `{v.UCoins} UCoins`;
                u19.Info.TextColor3 = Color3.new(1, 1, 0);
                u19.LayoutOrder = -v.UCoins;
                u19.Visible = true;
                u19.Parent = List;
                u19.Buttons.Wipe.MouseButton1Click:Connect(function() -- Line: 96
                    -- upvalues: u2 (ref), i (copy), u16 (ref), u17 (ref), u18 (ref), u19 (copy)
                    u2:SigmaWipe(i);
                    u16[i] = nil;
                    u17[i] = nil;
                    u18[i] = nil;
                    u19:Destroy();
                end);
            end;
        end;

        function u7.Ascensions() -- Line: 106
            -- upvalues: ClearList (ref), u17 (copy), CreateContainer (ref), Stands (ref), List (ref), u2 (ref), u16 (copy), u18 (copy)
            ClearList();

            for i, v in u17 do
                local u20 = CreateContainer(v);
                local v21 = tonumber(v.AbilityId:match("%d+"));
                local HighestAscension = v.HighestAscension;
                u20.Info.Text = `{Stands[v21]} ASC {HighestAscension}`;
                u20.Info.TextColor3 = Color3.new(1, 1, 1);
                u20.LayoutOrder = -HighestAscension;
                u20.Visible = true;
                u20.Parent = List;
                u20.Buttons.Wipe.MouseButton1Click:Connect(function() -- Line: 118
                    -- upvalues: u2 (ref), i (copy), u16 (ref), u17 (ref), u18 (ref), u20 (copy)
                    u2:SigmaWipe(i);
                    u16[i] = nil;
                    u17[i] = nil;
                    u18[i] = nil;
                    u20:Destroy();
                end);
            end;
        end;

        function u7.Unusuals() -- Line: 128
            -- upvalues: ClearList (ref), u18 (copy), CreateContainer (ref), List (ref), u2 (ref), u16 (copy), u17 (copy)
            ClearList();

            for i, v in u18 do
                local u22 = CreateContainer(v);
                u22.Info.RichText = true;
                u22.Info.Text = `<font color="#{Color3.fromRGB(75, 170, 255):ToHex()}">{v.UShards} UShards</font> / <font color="#{Color3.fromRGB(255, 255, 0):ToHex()}">{v.UCoins} UCoins</font>`;
                u22.LayoutOrder = -v.UShards;
                u22.Visible = true;
                u22.Parent = List;
                u22.Buttons.Wipe.MouseButton1Click:Connect(function() -- Line: 138
                    -- upvalues: u2 (ref), i (copy), u16 (ref), u17 (ref), u18 (ref), u22 (copy)
                    u2:SigmaWipe(i, "Unusual");
                    u16[i] = nil;
                    u17[i] = nil;
                    u18[i] = nil;
                    u22:Destroy();
                end);
            end;
        end;

        u7.UCoins();
        p8:SetMenu("SigmaLeaderboard");
        Parent.Visible = true;
    end;

    Close.MouseButton1Click:Connect(function() -- Line: 153
        -- upvalues: Parent (copy)
        Parent.Visible = false;
    end);
    local v23 = { "UCoins", "Ascensions", "Unusuals" };

    for i, v in v23 do
        local v24 = TabButton:Clone();
        v24.Name = v;
        v24.Text = v;
        v24.LayoutOrder = i;
        v24.Visible = true;
        v24.Size = UDim2.fromScale(1 / #v23, 1);
        v24.Parent = Buttons;
        v24.MouseButton1Click:Connect(function() -- Line: 168
            -- upvalues: u7 (copy), v (copy)
            u7[v]();
        end);
    end;
end;