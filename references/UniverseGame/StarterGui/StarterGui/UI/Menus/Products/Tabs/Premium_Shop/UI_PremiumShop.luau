  

 

game:GetService("Players");

return function(u1) -- Line: 3
    local Parent = script.Parent;
    local Tabs = Parent.Tabs;
    local Frame = Parent.Items:WaitForChild("Frame");
    local Pages = Tabs.Pages;
    local UIPageLayout = Pages.UIPageLayout;
    local LeftArrow = Tabs.LeftArrow;
    local RightArrow = Tabs.RightArrow;
    local PageFrame = Parent.Assets.PageFrame;
    local TabButton = Parent.Assets.TabButton;
    local u2 = {};
    local u3 = { { "Skins", "Mounts", "Kill Effects", "Items", "Spawns" }, { "Abilities" } };

    for _, child in script:GetChildren() do
        u2[child.Name] = require(child);
    end;

    local u4 = {};

    local function SelectTab(p5) -- Line: 38
        -- upvalues: u2 (copy), u4 (copy), Frame (copy), u1 (copy), Parent (copy)
        if not u2[p5] then
            return;
        end;

        for _, v in u4 do
            local v6;

            if v.Name == p5 then
                v6 = Color3.new(0, 1, 0);
            else
                v6 = Color3.new(1, 1, 1);
            end;

            v.TextColor3 = v6;
            local v7;

            if v.Name == p5 then
                v7 = Color3.fromRGB(27, 27, 27);
            else
                v7 = Color3.fromRGB(50, 50, 50);
            end;

            v.BackgroundColor3 = v7;
        end;

        for _, child in Frame:GetChildren() do
            if child:IsA("TextButton") then
                child.Visible = child:GetAttribute("Tab") == p5;
            end;
        end;

        u2[p5](u1, {
            ItemsFrame = Frame,
            Assets = Parent.Assets,
            Tab = p5
        });
    end;

    for i, v in u3 do
        local v8 = PageFrame:Clone();
        local v9 = #v <= 4 and 0.25 or 1 / #v;

        for _, v2 in v do
            local v10 = TabButton:Clone();
            v10.Size = UDim2.fromScale(v9, 1);
            v10.Visible = true;
            v10.Name = v2;
            v10.Text = v2;
            v10.Parent = v8;
            v10.MouseButton1Click:Connect(function() -- Line: 72
                -- upvalues: SelectTab (copy), v2 (copy)
                SelectTab(v2);
            end);
            table.insert(u4, v10);
        end;

        v8.Name = `Page_{i}`;
        v8.LayoutOrder = i;
        v8.Visible = true;
        v8.Parent = Pages;
    end;

    local function UpdateArrows(p11) -- Line: 85
        -- upvalues: LeftArrow (copy), RightArrow (copy), u3 (copy)
        if p11 <= 1 then
            LeftArrow.Visible = false;
            RightArrow.Visible = true;

            return;
        end;

        if #u3 <= p11 then
            LeftArrow.Visible = true;
            RightArrow.Visible = false;

            return;
        end;

        LeftArrow.Visible = true;
        RightArrow.Visible = true;
    end;

    LeftArrow.MouseButton1Click:Connect(function() -- Line: 98
        -- upvalues: UIPageLayout (copy)
        UIPageLayout:Previous();
        UIPageLayout.CurrentPage.Name:match("%d+");
    end);
    RightArrow.MouseButton1Click:Connect(function() -- Line: 104
        -- upvalues: UIPageLayout (copy)
        UIPageLayout:Next();
        UIPageLayout.CurrentPage.Name:match("%d+");
    end);

    if #u3 > 1 then
        LeftArrow.Visible = true;
        RightArrow.Visible = true;
    else
        LeftArrow.Visible = false;
        RightArrow.Visible = false;
    end;

    task.delay(3, function() -- Line: 121
        -- upvalues: SelectTab (copy)
        SelectTab("Skins");
    end);
end;