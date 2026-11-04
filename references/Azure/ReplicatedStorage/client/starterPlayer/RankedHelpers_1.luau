 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local trove = require(ReplicatedStorage.forum.trove);
local wiki = require(ReplicatedStorage.wiki);
local v1 = {};
local u2 = { "A", "B" };
local Ranked = script.Parent.Ranked;

function v1.Ranked(u3) -- Line: 14
    -- upvalues: ReplicatedStorage (copy), u2 (copy), trove (copy), Ranked (copy), Players (copy), wiki (copy), RunService (copy), soundUtil (copy)
    if not ReplicatedStorage.Ranked.Value then
        return;
    end;

    local RankedRemote = ReplicatedStorage:WaitForChild("RankedRemote", 120);

    if not (RankedRemote and RankedRemote:IsA("RemoteEvent")) then
        warn("[Ranked] RankedRemote not found");

        return;
    end;

    local Phase = RankedRemote.Phase;
    local Votes = RankedRemote.Votes;
    local player = u3.player;
    local storage = u3.storage;
    local Attribute = player:GetAttribute("team");

    while not table.find(u2, Attribute) do
        player:GetAttributeChangedSignal("team"):Wait();
        Attribute = player:GetAttribute("team");
    end;

    local u4 = Votes[Attribute];
    local u5 = trove.new();
    u5:AttachToInstance(RankedRemote);
    local u6 = u5:Extend();
    local u7 = u5:Clone(Ranked);
    u7.Parent = u3.playerGui;
    local Select = u7.Select;
    local Container = Select.Container;
    local UIListLayout = Container.UIListLayout;
    local Text = Select.Description.Text;
    local Text2 = Select.Header.Text;
    local Field = u7.Field;
    local u8 = u7:FindFirstChild("Frame") and u7.Frame:FindFirstChild("Phase");

    local function close_ui() -- Line: 52
        -- upvalues: u7 (copy), u5 (copy)
        if u7.Parent then
            u7:Destroy();
        end;

        u5:Destroy();
    end;

    local function update_votes() -- Line: 59
        -- upvalues: u4 (copy), Players (ref), player (copy), wiki (ref), Votes (copy), Select (copy), Field (copy), Container (copy), RankedRemote (copy), Phase (copy)
        local v9 = {};
        local v10 = {};
        local v11 = {};
        local v12 = "";

        for _, child in u4:GetChildren() do
            local PlayerByUserId = Players:GetPlayerByUserId(tonumber(child.Name) or 0);

            if PlayerByUserId then
                local Attribute2 = child:GetAttribute("style");

                if Attribute2 and (Attribute2 ~= "" and not v9[Attribute2]) then
                    v9[Attribute2] = PlayerByUserId.Name;

                    if tonumber(child.Name) ~= player.UserId then
                        Attribute2 = v12;
                    end;
                else
                    Attribute2 = v12;
                end;

                local Attribute3 = child:GetAttribute("position");

                if typeof(Attribute3) == "number" then
                    v11[wiki.teamroles[Attribute3]] = PlayerByUserId.Name;
                end;

                local Attribute4 = child:GetAttribute("ban");

                if Attribute4 and Attribute4 ~= "" then
                    v10[Attribute4] = (v10[Attribute4] or 0) + 1;
                    v12 = Attribute2;
                else
                    v12 = Attribute2;
                end;
            end;
        end;

        local v13 = 0;
        local v14 = 0;

        for _, child in Votes:GetChildren() do
            for _, child2 in child:GetChildren() do
                if child2:IsA("BoolValue") then
                    v13 = v13 + 1;

                    if child2.Value then
                        v14 = v14 + 1;
                    end;
                end;
            end;
        end;

        Select.ReadyCount.Text = `{v14}/{v13}`;

        for _, child in Field.Picks:GetChildren() do
            if child:IsA("ImageButton") then
                local v15 = v11[child.Name];
                child.TextLabel.Text = v15 or child.Name;
                child.ImageTransparency = v15 and 0.5 or 0;
            end;
        end;

        for _, child in Container:GetChildren() do
            if child:IsA("Frame") then
                local v16 = v9[child.Name];
                local v17 = v12 == child.Name;
                child.Ban.Visible = RankedRemote.Bans:FindFirstChild(child.Name) ~= nil;
                child.Frame.GroupTransparency = v16 and 0.5 or 0;
                local v18;

                if v16 then
                    v18 = not v17;
                else
                    v18 = v16;
                end;

                child.Picked.Visible = v18;
                child.Picked.Text = `PICKED BY\n{v16}`;
                child.MySelected.Visible = v17;

                if Phase.Value == "Ban" then
                    child.Frame.Count.Text = tostring(v10[child.Name] or 0);
                else
                    child.Frame.Count.Text = "";
                end;
            end;
        end;
    end;

    u5:Connect(RunService.Heartbeat, function() -- Line: 132
        -- upvalues: u3 (copy)
        if u3.lobbyui then
            u3.lobbyui:Destroy();
            u3.lobbyui = nil;
        end;
    end);
    u5:Connect(u4.ChildAdded, function(p19: userdata) -- Line: 139, Name: bind_vote_entry
        -- upvalues: u5 (copy), update_votes (copy)
        if not p19:IsA("BoolValue") then
            return;
        end;

        u5:Connect(p19.AttributeChanged, update_votes);
        u5:Connect(p19.Changed, update_votes);
    end);

    for _, child in u4:GetChildren() do
        if child:IsA("BoolValue") then
            u5:Connect(child.AttributeChanged, update_votes);
            u5:Connect(child.Changed, update_votes);
        end;
    end;

    u5:Connect(RankedRemote.Bans.ChildAdded, update_votes);
    u5:Connect(RankedRemote.Bans.ChildRemoved, update_votes);
    u5:Connect(RankedRemote.Timer.Changed, function(p20) -- Line: 154
        -- upvalues: Select (copy)
        if Select.Visible then
            Select.Timer.Text = tostring(p20);
        end;
    end);
    local roundstart = ReplicatedStorage:WaitForChild("workspace", 20):WaitForChild("roundstart", 20);

    if roundstart and roundstart:IsA("BoolValue") then
        if roundstart.Value then
            if u7.Parent then
                u7:Destroy();
            end;

            u5:Destroy();

            return;
        end;

        u5:Connect(roundstart.Changed, function(p21) -- Line: 166
            -- upvalues: u7 (copy), u5 (copy)
            if p21 then
                if u7.Parent then
                    u7:Destroy();
                end;

                u5:Destroy();
            end;
        end);
    end;

    local function update_phase() -- Line: 173
        -- upvalues: Phase (copy), u7 (copy), u5 (copy), u6 (copy), Select (copy), Field (copy), u8 (copy), RankedRemote (copy), Text2 (copy), Text (copy), UIListLayout (copy), Container (copy), soundUtil (ref), ReplicatedStorage (ref), storage (copy), wiki (ref), u4 (copy), player (copy), update_votes (copy)
        local Value = Phase.Value;

        if Value == "Done" then
            if u7.Parent then
                u7:Destroy();
            end;

            u5:Destroy();

            return;
        end;

        u6:Clean();
        Select.Visible = false;
        Field.Visible = false;

        if Value == "Waiting" then
            if u8 then
                u8.Text = "waiting for players";
            end;

            Select.Header.Text = "Waiting for players...";
            Select.Description.Text = "The match will begin once everyone has joined.";
            Select.Timer.Text = tostring(RankedRemote.Timer.Value);
            Select.Visible = true;

            return;
        end;

        if not table.find({ "Ban", "Pick" }, Value) then
            if Value == "Position" then
                if u8 then
                    u8.Text = "position phase";
                end;

                for _, child in Field.Picks:GetChildren() do
                    if child:IsA("ImageButton") then
                        u6:Connect(child.MouseButton1Click, function() -- Line: 274
                            -- upvalues: soundUtil (ref), ReplicatedStorage (ref), wiki (ref), child (copy), RankedRemote (ref)
                            soundUtil:play(ReplicatedStorage.Resources.click, "default");
                            local table_find_ret = table.find(wiki.teamroles, child.Name);

                            if table_find_ret then
                                RankedRemote:FireServer("PositionSelect", table_find_ret);
                            end;
                        end);
                    end;
                end;

                task.spawn(update_votes);
                Field.Visible = true;
            end;

            return;
        end;

        local u22 = Value == "Ban";

        if u8 then
            u8.Text = u22 and "banning phase" or "picking phase";
        end;

        Select.Header.Text = u22 and "Ban a style!" or Text2;
        Select.Description.Text = u22 and "Select the style you want to ban!" or Text;

        local function load_style(u23, p24) -- Line: 204
            -- upvalues: u6 (ref), UIListLayout (ref), Container (ref), RankedRemote (ref), soundUtil (ref), ReplicatedStorage (ref), u22 (copy)
            local v25 = u6:Clone(UIListLayout.style_base);
            v25.Frame.ImageLabel.Image = p24.image or v25.Frame.ImageLabel.Image;

            if p24.ignorecolor then
                v25.Frame.ImageLabel.ImageColor3 = Color3.new(1, 1, 1);
            else
                v25.Frame.ImageLabel.ImageColor3 = p24.color or v25.Frame.ImageLabel.ImageColor3;
            end;

            v25.Frame.Main.Text = p24.display_name or u23;
            v25.Frame.Description.Text = p24.description or v25.Frame.Description.Text;
            v25.Name = u23;
            v25.Parent = Container;
            u6:Connect(v25.Button.MouseButton1Click, function() -- Line: 217
                -- upvalues: RankedRemote (ref), u23 (copy), soundUtil (ref), ReplicatedStorage (ref), u22 (ref)
                if RankedRemote.Bans:FindFirstChild(u23) then
                    return;
                end;

                soundUtil:play(ReplicatedStorage.Resources.click, "default");
                RankedRemote:FireServer(u22 and "Ban" or "StyleSelect", u23);
            end);
        end;

        if Value == "Pick" then
            for _, child in storage.styles:GetChildren() do
                if child:IsA("StringValue") then
                    local Value2 = child.Value;
                    local v26 = wiki.styles[Value2];

                    if v26 and not v26.spec then
                        load_style(Value2, v26);
                    end;
                end;
            end;
        else
            for i, v in wiki.styles do
                if not (v.spec or v.mastery_of) then
                    load_style(i, v);
                end;
            end;
        end;

        Container.CanvasSize = UDim2.fromOffset(0, Container.UIListLayout.AbsoluteContentSize.Y);
        u6:Connect(Select.Ready.Button.MouseButton1Click, function() -- Line: 250
            -- upvalues: soundUtil (ref), ReplicatedStorage (ref), RankedRemote (ref)
            soundUtil:play(ReplicatedStorage.Resources.click, "default");
            RankedRemote:FireServer("Ready");
        end);
        local v27 = u4:FindFirstChild((tostring(player.UserId)));

        if v27 and v27:IsA("BoolValue") then
            Select.Ready.Main.Text = v27.Value and "Unready" or "Ready";
            u6:Connect(v27.Changed, function(p28) -- Line: 258
                -- upvalues: Select (ref)
                Select.Ready.Main.Text = p28 and "Unready" or "Ready";
            end);
        end;

        Select.Timer.Text = tostring(RankedRemote.Timer.Value);
        task.spawn(update_votes);
        Select.Visible = true;
    end;

    u5:Connect(Phase.Changed, update_phase);
    task.spawn(update_phase);
end;

return v1;