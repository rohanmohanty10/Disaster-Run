  

 

return function(p1) -- Line: 1
    local Parent = script.Parent;
    local Assets = Parent.Assets;
    local List = Parent.List;
    local Close = Parent.Close;
    local Buttons = Parent.Buttons;
    local Button = Assets.Button;
    local _ = game.Players.LocalPlayer;
    local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
    require(PathShortcuts.ReplicatedModules.Stands);
    p1.Knit.GetService("PlayerDataService");
    local UserService = game:GetService("UserService");
    local u2 = { "Wipe" };

    local function CreateContainer(p3) -- Line: 23
        -- upvalues: Assets (copy), u2 (copy), Button (copy)
        local v4 = Assets.Frame:Clone();
        v4.Username.Text = `@{p3.Username}`;
        v4.DisplayName.Text = `{p3.DisplayName}`;
        v4.UserId.Text = `{p3.UserId}`;

        for i, v in u2 do
            local v5 = Button:Clone();
            v5.Name = v;
            v5.TextLabel.Text = v;
            v5.Visible = true;
            v5.LayoutOrder = i;
            v5.Size = UDim2.fromScale(1 / #u2, 1);
            v5.Parent = v4.Buttons;
        end;

        return v4;
    end;

    local function ShowUFragsList() -- Line: 42
    end;

    local function ShowUPointsList() -- Line: 46
    end;

    local function ClearList() -- Line: 50
        -- upvalues: List (copy)
        for _, child in List:GetChildren() do
            if child:IsA("Frame") then
                child:Destroy();
            end;
        end;
    end;

    function p1.ViewPaidLeaderboard(p6, p7, p8) -- Line: 58
        -- upvalues: UserService (copy), ClearList (copy), CreateContainer (copy), List (copy), ShowUPointsList (ref), ShowUFragsList (ref), Parent (copy)
        local function CreateDict(p9) -- Line: 62
            -- upvalues: UserService (ref)
            local v10 = {};

            for _, v in p9 do
                if v.UserId >= 1 then
                    table.insert(v10, v.UserId);
                end;
            end;

            local v11 = UserService:GetUserInfosByUserIdsAsync(v10);
            local v12 = {};

            for _, v in p9 do
                if v.UserId >= 1 then
                    v12[v.UserId] = v;
                end;
            end;

            for _, v in v11 do
                v12[v.Id].Username = v.Username;
                v12[v.Id].DisplayName = v.DisplayName;
            end;

            return v12;
        end;

        local u13 = CreateDict(p7 or {});
        local u14 = CreateDict(p8 or {});

        ShowUPointsList = function() -- Line: 88, Name: ShowUPointsList
            -- upvalues: ClearList (ref), u13 (copy), CreateContainer (ref), List (ref), u14 (copy)
            ClearList();

            for i, v in u13 do
                local u15 = CreateContainer(v);
                u15.Info.Text = `{v.UPoints} UPoints`;
                u15.Info.TextColor3 = Color3.fromRGB(255, 200, 100);
                u15.LayoutOrder = -v.UPoints;
                u15.Visible = true;
                u15.Parent = List;
                u15.Buttons.Wipe.MouseButton1Click:Connect(function() -- Line: 98
                    -- upvalues: u14 (ref), i (copy), u13 (ref), u15 (copy)
                    u14[i] = nil;
                    u13[i] = nil;
                    u15:Destroy();
                end);
            end;
        end;

        ShowUFragsList = function() -- Line: 106, Name: ShowUFragsList
            -- upvalues: ClearList (ref), u14 (copy), CreateContainer (ref), List (ref), u13 (copy)
            ClearList();

            for i, v in u14 do
                local u16 = CreateContainer(v);
                u16.Info.Text = `{v.UFragments} UFragments`;
                u16.Info.TextColor3 = Color3.fromRGB(68, 255, 0);
                u16.LayoutOrder = -v.UFragments;
                u16.Visible = true;
                u16.Parent = List;
                u16.Buttons.Wipe.MouseButton1Click:Connect(function() -- Line: 116
                    -- upvalues: u14 (ref), i (copy), u13 (ref), u16 (copy)
                    u14[i] = nil;
                    u13[i] = nil;
                    u16:Destroy();
                end);
            end;
        end;

        ShowUPointsList();
        p6:SetMenu("PaidLeaderboard");
        Parent.Visible = true;
    end;

    Close.MouseButton1Click:Connect(function() -- Line: 129
        -- upvalues: Parent (copy)
        Parent.Visible = false;
    end);
    Buttons.UPoints.MouseButton1Click:Connect(function() -- Line: 133
        -- upvalues: ShowUPointsList (ref)
        ShowUPointsList();
    end);
    Buttons.UFragments.MouseButton1Click:Connect(function() -- Line: 136
        -- upvalues: ShowUFragsList (ref)
        ShowUFragsList();
    end);
end;