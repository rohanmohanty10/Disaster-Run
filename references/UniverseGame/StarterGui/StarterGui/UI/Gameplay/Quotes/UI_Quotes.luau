  

 

return function(u1) -- Line: 1
    local Knit = u1.Knit;
    local Parent = script.Parent;
    local Promise = require(Knit.Util.Promise);
    local TableUtil = require(Knit.Util.TableUtil);
    u1.Player:WaitForChild("Settings");
    local Mapping = u1.Util.Mapping;
    local Inputs = require(script:WaitForChild("Inputs"));
    local u2 = Knit.GetService("QuoteService");
    local u3 = Knit.GetController("QuoteController");
    local UserInputService = game:GetService("UserInputService");
    local u4 = Random.new();
    local u5 = {};
    local u6 = {};
    local u7 = nil;

    function u1.SetQuotesVisible(p8, p9) -- Line: 24
        -- upvalues: Parent (copy), UserInputService (copy)
        Parent.Visible = p9;
        local TouchEnabled = UserInputService.TouchEnabled;
        local v10;

        if TouchEnabled then
            v10 = not p9;
        else
            v10 = false;
        end;

        p8.UI.Gameplay.Mobile.Main.Visible = v10;
        local v11;

        if TouchEnabled then
            v11 = false;
        else
            v11 = not p9;
        end;

        p8.UI.Gameplay.Moves.Visible = v11;
        local v12;

        if TouchEnabled then
            v12 = false;
        else
            v12 = not p9;
        end;

        p8.UI.Gameplay.Moveset.Visible = v12;
    end;

    local function ResolveInput(p13) -- Line: 34
        -- upvalues: Mapping (copy)
        return Mapping[p13] or p13;
    end;

    local function SetVisible(p14, p15) -- Line: 38
        -- upvalues: u7 (ref)
        local v16;

        if p15.Group.Visible then
            v16 = p15.Quote.Visible or false;
        else
            v16 = false;
        end;

        p14.Visible = v16;

        if p15.Group.Visible then
            u7 = p15.GroupName;
        end;
    end;

    local function GetDisplayQuote(p17, p18) -- Line: 46
        -- upvalues: Promise (copy), TableUtil (copy)
        if p17.DisplayQuote then
            return p17.DisplayQuote;
        end;

        local v19 = "";

        for _, v in ipairs(p17.FullQuote) do
            local Quote = v.Quote;

            if type(v.Transformer) == "function" then
                Promise.try(v.Transformer, TableUtil.Copy(v, true), p18):andThen(function(p20) -- Line: 53
                    -- upvalues: Quote (ref)
                    Quote = p20;
                end):await();
            end;

            v19 = v19 .. Quote;
        end;

        return v19;
    end;

    local function UpdateOrder() -- Line: 62
        -- upvalues: u6 (copy), u5 (copy)
        table.clear(u6);
        local v21 = 1;

        for _, v in pairs(u5) do
            if v.Button.Visible then
                u6[v21] = v.QuoteIndex;
                v.Button.Key.Text = v21;
                v.Button.LayoutOrder = v21;
                v21 = v21 + 1;
            end;
        end;
    end;

    local function CallQuote(p22) -- Line: 76
        -- upvalues: u2 (copy), u7 (ref)
        u2:Quote(u7, p22);
    end;

    local function Update() -- Line: 80
        -- upvalues: u5 (copy), u3 (copy), Parent (copy), GetDisplayQuote (copy), u1 (copy), u2 (copy), u7 (ref), UpdateOrder (copy)
        for i, v in pairs(u5) do
            v.Button:Destroy();
            u5[i] = nil;
        end;

        for i, v in pairs(u3:GetGroups()) do
            for i2, v2 in pairs(v.Quotes) do
                local v23 = Parent.Assets.Button:Clone();
                local v24 = GetDisplayQuote(v2, {
                    Player = u1.Player,
                    Character = u1.Character,
                    AbilityName = u1.Player.Data.Ability:GetAttribute("AbilityName"),
                    SkinName = u1.Player.Data.Skin:GetAttribute("SkinName")
                });
                v23.Name = i2;
                v23.Key.Text = "?";
                v23.Label.Text = v24;
                v23.MouseButton1Down:Connect(function() -- Line: 101
                    -- upvalues: i2 (copy), u2 (ref), u7 (ref), u1 (ref)
                    u2:Quote(u7, i2);
                    u1:SetQuotesVisible(false);
                end);
                local v25 = {
                    Button = v23,
                    GroupName = i,
                    Group = v,
                    QuoteIndex = i2,
                    Quote = v2
                };
                table.insert(u5, v25);
                local v26;

                if v25.Group.Visible then
                    v26 = v25.Quote.Visible or false;
                else
                    v26 = false;
                end;

                v23.Visible = v26;

                if v25.Group.Visible then
                    u7 = v25.GroupName;
                end;

                v23.Parent = Parent;
            end;
        end;

        UpdateOrder();
    end;

    local function UpdateVisibility() -- Line: 125
        -- upvalues: u5 (copy), u7 (ref), UpdateOrder (copy)
        for _, v in pairs(u5) do
            local v27;

            if v.Group.Visible then
                v27 = v.Quote.Visible or false;
            else
                v27 = false;
            end;

            v.Button.Visible = v27;

            if v.Group.Visible then
                u7 = v.GroupName;
            end;
        end;

        UpdateOrder();
    end;

    local function InputBegan(p28, p29) -- Line: 132
        -- upvalues: Parent (copy), Inputs (copy), u6 (copy), u2 (copy), u7 (ref), u1 (copy), UserInputService (copy), u4 (copy)
        if not p29 then
            local v30 = Parent.Visible and Inputs[p28.KeyCode.Name];

            if v30 then
                u2:Quote(u7, u6[v30]);
                u1:SetQuotesVisible(false);
            end;

            if p28.KeyCode == Enum.KeyCode.N then
                u1:SetQuotesVisible(true);
                task.spawn(function() -- Line: 143
                    -- upvalues: UserInputService (ref), u6 (ref), u2 (ref), u7 (ref), u4 (ref)
                    local v31 = os.clock();

                    while UserInputService:IsKeyDown(Enum.KeyCode.N) do
                        task.wait();
                    end;

                    if os.clock() - v31 <= 0.1 then
                        if #u6 == 1 then
                            u2:Quote(u7, #u6);

                            return;
                        end;

                        if #u6 > 1 then
                            u2:Quote(u7, (u4:NextInteger(1, #u6)));
                        end;
                    end;
                end);
            end;
        end;
    end;

    Update();
    local u32 = false;
    u3.Updated:Connect(function() -- Line: 171
        -- upvalues: u32 (ref), Update (copy)
        if u32 then
            return;
        end;

        u32 = true;
        task.defer(function() -- Line: 174
            -- upvalues: u32 (ref), Update (ref)
            u32 = false;
            Update();
        end);
    end);
    u3.VisibilityUpdated:Connect(UpdateVisibility);
    UserInputService.InputBegan:Connect(InputBegan);
    UserInputService.InputEnded:Connect(function(p33, p34) -- Line: 160, Name: InputEnded
        -- upvalues: u1 (copy)
        if not p34 and p33.KeyCode == Enum.KeyCode.N then
            u1:SetQuotesVisible(false);
        end;
    end);
end;