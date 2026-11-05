 

 

local l__Playerlist__1 = script.Parent:WaitForChild("Playerlist");
local l__Template__2 = l__Playerlist__1:WaitForChild("Template");
local l__Indicators__3 = l__Playerlist__1:WaitForChild("Indicators");
local l__PlayerlistRemote__4 = game:GetService("ReplicatedStorage"):WaitForChild("PlayerlistRemote");
local l__Position__5 = l__Template__2.Position;
local l__FunctionLibrary__6 = require(game:GetService("ReplicatedStorage").Modules:WaitForChild("FunctionLibrary"));
local l__LocalPlayer__7 = game.Players.LocalPlayer;
local u1 = l__LocalPlayer__7.Character or l__LocalPlayer__7.CharacterAdded:wait();
local u2 = {
    ["Metal Ball Run"] = "GlobalSBRRankings"
};
local l__Scale__8 = l__Playerlist__1.CanvasSize.Y.Scale;
local l__Scale__9 = l__Template__2.Size.Y.Scale;
local l__Scale__10 = l__Indicators__3.Size.Y.Scale;
l__Template__2.Visible = false;
function RefreshPlayerlist()
    -- upvalues: u2 (copy), u1 (copy), l__FunctionLibrary__6 (copy), l__Playerlist__1 (copy), l__Template__2 (copy), l__Indicators__3 (copy), l__LocalPlayer__7 (copy), l__Position__5 (ref), l__Scale__8 (copy), l__Scale__9 (copy), l__Scale__10 (copy)
    local v3 = game.ReplicatedStorage:WaitForChild("Game_Modes"):FindFirstChild(tostring(game.PlaceId), true);
    local u4;
    if v3 and u2[v3.Parent.Parent.Name] then
        local v5 = u1:WaitForChild("RemoteFunction"):InvokeServer("ReturnPlayerRankings", u2[v3.Parent.Parent.Name]);
        u4 = {};
        for v6, v7 in pairs(v5) do
            u4[v7.UserId] = v7;
            u4[v7.UserId].Rank = v6;
        end;
    else
        u4 = nil;
    end;
    local l__CustomNames__11 = l__FunctionLibrary__6.CustomNames;
    for _, v8 in pairs(l__Playerlist__1:GetChildren()) do
        if v8 ~= l__Template__2 and v8 ~= l__Indicators__3 then
            v8:Destroy();
        end;
    end;
    local v9 = game:GetService("Players"):GetPlayers();
    for v10, v11 in pairs(v9) do
        local v12 = l__CustomNames__11[v11.UserId];
        if v11.UserId == l__LocalPlayer__7.UserId and true or (v12 and v12.Invisible and true or false) then
            table.remove(v9, v10);
        end;
    end;
    table.sort(v9, function(p13, p14) --[[ Line: 65 ]]
        return p13.Name:lower() < p14.Name:lower();
    end);
    local v15 = #v9 / 9;
    local u16 = v15 < 1 and 1 or v15;
    l__Position__5 = UDim2.new(l__Template__2.Position.X.Scale, 0, l__Template__2.Position.Y.Scale / u16, 0);
    l__Playerlist__1.CanvasSize = UDim2.new(0, 0, l__Scale__8 * u16, 0);
    l__Template__2.Size = UDim2.new(l__Template__2.Size.X.Scale, 0, l__Scale__9 / u16, 0);
    l__Indicators__3.Size = UDim2.new(l__Indicators__3.Size.X.Scale, 0, l__Scale__10 / u16, 0);
    local function v22(p17, p18) --[[ Line: 80 ]]
        -- upvalues: l__Template__2 (ref), l__FunctionLibrary__6 (ref), l__CustomNames__11 (copy), l__Playerlist__1 (ref), l__Position__5 (ref), u16 (ref), u4 (ref)
        local v19 = l__Template__2:Clone();
        v19.Name = p18.Name;
        v19.PlayerName.Text = p18.Name;
        v19.PlayerNameRanked.Text = p18.Name;
        v19.GangName.Text = "Gang-less";
        local v20 = p18:FindFirstChild("PlayerStats");
        if v20 then
            if v20:FindFirstChild("Prestige") and v20.Prestige.Value >= l__FunctionLibrary__6.MaxPrestige then
                v19.PlayerName.TextColor = BrickColor.new("Gold");
                v19.PlayerNameRanked.TextColor = BrickColor.new("Gold");
            end;
            if v20.Gang.Value ~= "" then
                v19.GangName.Text = v20.Gang.Value;
            end;
            if v20.Prestige.Value > 0 then
                v19.Prestige.TextLabel.Text = l__FunctionLibrary__6.ReturnRomanNumeral(v20.Prestige.Value);
                if v20.Prestige.Value == 1 then
                    v19.Prestige.TextLabel.TextColor = BrickColor.new("Br. yellowish orange");
                elseif v20.Prestige.Value == 2 then
                    v19.Prestige.TextLabel.TextColor = BrickColor.new("Medium stone grey");
                elseif v20.Prestige.Value == 3 then
                    v19.Prestige.TextLabel.TextColor = BrickColor.new("Gold");
                elseif v20.Prestige.Value == 10 then
                    v19.Prestige.TextLabel.TextColor = BrickColor.new("Really red");
                end;
            end;
        end;
        local v21 = l__CustomNames__11[p18.UserId];
        if v21 then
            local l__Color__12 = v21.Color;
            if v21.Name then
                v19.PlayerName.Text = v21.Name;
                v19.PlayerNameRanked.Text = v21.Name;
                if not v21.DontTextScaled then
                    v19.PlayerName.TextScaled = true;
                    v19.PlayerNameRanked.TextScaled = true;
                end;
            end;
            if l__Color__12 then
                v19.PlayerName.TextColor = v21.Color;
                v19.PlayerNameRanked.TextColor = v21.Color;
            end;
        end;
        v19.Parent = l__Playerlist__1;
        if p17 == 1 then
            v19.Position = l__Position__5;
        else
            v19.Position = l__Position__5 + UDim2.new(0, 0, 0.085 / u16 * (p17 - 1));
        end;
        if u4 and u4[tostring(p18.UserId)] then
            v19.PlayerName.Visible = false;
            v19.PlayerNameRanked.Visible = true;
            v19.PlayerRank.Visible = true;
            v19.PlayerRank.Text = "#" .. u4[tostring(p18.UserId)].Rank;
        end;
        v19.Visible = true;
    end;
    v22(1, l__LocalPlayer__7);
    for v23, v24 in pairs(v9) do
        v22(1 + v23, v24);
    end;
end;
RefreshPlayerlist();
l__PlayerlistRemote__4.OnClientEvent:connect(function(p25, ...) --[[ Line: 161 ]]
    -- upvalues: l__FunctionLibrary__6 (copy)
    local v26 = ... or {};
    if v26.NewName then
        if not l__FunctionLibrary__6.CustomNames[v26.NewName.UserId] then
            l__FunctionLibrary__6.CustomNames[v26.NewName.UserId] = {};
        end;
        l__FunctionLibrary__6.CustomNames[v26.NewName.UserId].Name = v26.NewName.Name;
        if l__FunctionLibrary__6.CustomChat[v26.NewName.Player.Name] then
            l__FunctionLibrary__6.CustomChat[v26.NewName.Player.Name].Name = v26.NewName.Name;
        end;
    end;
    if p25 == "Refresh" then
        RefreshPlayerlist();
    end;
end);