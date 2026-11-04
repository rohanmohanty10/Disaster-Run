 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local HttpService = game:GetService("HttpService");
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local LeaderboardConfig = require(ChickenOrHero:WaitForChild("Presentation"):WaitForChild("LeaderboardConfig"));
local Leaderboards = ChickenOrHero:WaitForChild("Game"):WaitForChild("Leaderboards");
local ProgressionMath = require(ChickenOrHero:WaitForChild("Progression"):WaitForChild("ProgressionMath"));
local TeamEventConfig = require(ChickenOrHero.Progression:WaitForChild("TeamEventConfig"));
local TeamEventBoard = require(ChickenOrHero:WaitForChild("Interface"):WaitForChild("TeamEventBoard"));
local VerifiedName = require(ChickenOrHero.Presentation:WaitForChild("VerifiedName"));
local MapLocator = require(ChickenOrHero.Game:WaitForChild("MapLocator"));
local u1 = {};
local v2 = {};
local u3 = true;
local u4 = {};

local function numberText(p5) -- Line: 19
    if p5 >= 1000000000 then
        return ("%.1fB"):format(p5 / 1000000000);
    end;

    if p5 >= 1000000 then
        return ("%.1fM"):format(p5 / 1000000);
    end;

    if p5 >= 10000 then
        return ("%.1fK"):format(p5 / 1000);
    end;

    local math_floor_ret = math.floor(p5);

    return tostring(math_floor_ret);
end;

local function comma(p6) -- Line: 31
    local string_reverse = string.reverse;
    local math_floor_ret = math.floor(p6);
    local math_max_ret = math.max(0, math_floor_ret);
    local v7 = string_reverse((tostring(math_max_ret)));

    return string.gsub(string.reverse((string.gsub(v7, "(%d%d%d)", "%1,"))), "^,", "");
end;

local function statusText(p8, p9, p10) -- Line: 39
    -- upvalues: comma (copy), TeamEventConfig (copy)
    if not p8.def.Place then
        local string_upper_ret = string.upper(p8.key);

        if type(p9.season) == "string" then
            if p9.status == "studio" then
                return "STUDIO PREVIEW · SESSION RP";
            end;

            local v11;

            if p9.status == "retrying" then
                v11 = #p10 > 0 and "SEASON " .. p9.season .. " · UPDATE DELAYED";

                if not v11 then
                    return "TEMPORARILY UNAVAILABLE";
                end;
            else
                v11 = #p10 == 0 and "SEASON " .. p9.season .. " · NO RANKED PLAYERS YET" or "SEASON " .. p9.season .. " · TOP " .. #p10;
            end;

            return v11;
        end;

        if p9.pro ~= true then
            local v12 = p9.status == "studio" and "STUDIO PREVIEW · SESSION " .. string_upper_ret;

            if not v12 then
                if p9.status == "retrying" then
                    return #p10 > 0 and "GLOBAL · UPDATE DELAYED" or "GLOBAL · TEMPORARILY UNAVAILABLE";
                end;

                if p9.status == "loading" then
                    return "GLOBAL · LOADING...";
                end;

                v12 = #p10 == 0 and "GLOBAL · NO " .. string_upper_ret .. " YET" or "GLOBAL · ALL TIME · TOP " .. p8.def.PageSize;
            end;

            return v12;
        end;

        local v13 = type(p9.month) == "string" and (p9.month or "THIS MONTH") or "THIS MONTH";
        local v14 = p9.status == "studio" and "STUDIO PREVIEW · PRO SESSION " .. string_upper_ret;

        if not v14 then
            if p9.status == "retrying" then
                return #p10 > 0 and "PRO · UPDATE DELAYED" or "PRO · TEMPORARILY UNAVAILABLE";
            end;

            v14 = #p10 == 0 and "PRO · " .. v13 .. " · NO " .. string_upper_ret .. " YET" or "PRO · " .. v13 .. " · TOP " .. #p10;
        end;

        return v14;
    end;

    if p9.status == "loading" or p9.updatedAt == 0 then
        return "TEAM TOTAL · LOADING...";
    end;

    local v15 = tonumber(p9.members) or 0;
    local math_floor_ret = math.floor(v15);
    local math_max_ret = math.max(0, math_floor_ret);
    local v16 = tonumber(p9.total) or 0;
    local v17;

    if v16 >= 1000000000 then
        v17 = ("%.1fB"):format(v16 / 1000000000);
    elseif v16 >= 1000000 then
        v17 = ("%.1fM"):format(v16 / 1000000);
    elseif v16 >= 10000 then
        v17 = ("%.1fK"):format(v16 / 1000);
    else
        local math_floor_ret2 = math.floor(v16);
        v17 = tostring(math_floor_ret2);
    end;

    local v18 = comma(math_max_ret);
    local v19 = tonumber(p9.level) or 0;
    local v20 = ("TEAM TOTAL %s · %s %s · LEVEL %d/%d"):format(v17, v18, math_max_ret == 1 and "PLAYER" or "PLAYERS", math.floor(v19), #TeamEventConfig.TeamLevels);

    if p9.final == true then
        return (p9.winner == true and "WINNER · FINAL · " or "FINAL · ") .. v20;
    end;

    if p9.status == "retrying" then
        v20 = v20 .. " · UPDATE DELAYED";
    end;

    return v20;
end;

local function clear(p21) -- Line: 81
    -- upvalues: u1 (copy), TeamEventBoard (copy)
    local v22 = u1[p21];

    if not v22 then
        return;
    end;

    u1[p21] = nil;
    v22.generation = v22.generation + 1;
    v22.connection:Disconnect();

    if v22.view then
        TeamEventBoard.destroy(v22.view);
    end;

    v22.gui:Destroy();

    if v22.part.Parent then
        v22.part.CFrame = v22.base;
    end;

    if v22.source.Parent then
        v22.source.Enabled = v22.wasEnabled;
    end;
end;

local function render(u23) -- Line: 100
    -- upvalues: HttpService (copy), TeamEventBoard (copy), comma (copy), statusText (copy), VerifiedName (copy), LocalPlayer (copy), ProgressionMath (copy), u4 (copy), Players (copy), u3 (ref), u1 (copy)
    local success, result = pcall(HttpService.JSONDecode, HttpService, u23.snapshot.Value);

    if not success or type(result) ~= "table" then
        return;
    end;

    local MainFrame = u23.gui.MainFrame;
    local v24 = result.entries or {};

    if u23.view then
        local v25 = tonumber(result.members) or 0;
        local math_floor_ret = math.floor(v25);
        local math_max_ret = math.max(0, math_floor_ret);
        local paint = TeamEventBoard.paint;
        local view = u23.view;
        local v26 = tonumber(result.total) or 0;
        local v27;

        if v26 >= 1000000000 then
            v27 = ("%.1fB"):format(v26 / 1000000000);
        elseif v26 >= 1000000 then
            v27 = ("%.1fM"):format(v26 / 1000000);
        elseif v26 >= 10000 then
            v27 = ("%.1fK"):format(v26 / 1000);
        else
            local math_floor_ret2 = math.floor(v26);
            v27 = tostring(math_floor_ret2);
        end;

        paint(view, result, v27, comma(math_max_ret), #v24);
    else
        local v28;

        if result.pro == true then
            v28 = "PRO " .. u23.def.Title;
        else
            v28 = u23.def.Title;
        end;

        MainFrame.Title.Text = v28;
        MainFrame.Status.Text = statusText(u23, result, v24);
    end;

    local v29 = HttpService:JSONEncode(v24);

    if v29 == u23.signature then
        return;
    end;

    u23.signature = v29;
    u23.generation = u23.generation + 1;
    local generation = u23.generation;

    for _, v in u23.rows do
        v:Destroy();
    end;

    table.clear(u23.rows);

    for i, v in v24 do
        local u30 = u23.template:Clone();
        u30.Name = "Rank_" .. i;
        u30.Visible = true;
        u30.LayoutOrder = i;
        local Frame = u30.Frame;

        if u23.view then
            local v31 = VerifiedName.format(v.name, v.verified, v.userId);
            local row = TeamEventBoard.row;
            local view = u23.view;
            local value = v.value;
            local v32;

            if value >= 1000000000 then
                v32 = ("%.1fB"):format(value / 1000000000);
            elseif value >= 1000000 then
                v32 = ("%.1fM"):format(value / 1000000);
            elseif value >= 10000 then
                v32 = ("%.1fK"):format(value / 1000);
            else
                local math_floor_ret = math.floor(value);
                v32 = tostring(math_floor_ret);
            end;

            row(view, u30, i, v31, v32, v.userId == LocalPlayer.UserId);
        else
            Frame.Username.RichText = true;
            Frame.Username.Text = ("#%d  %s"):format(i, VerifiedName.format(v.name, v.verified, v.userId));
            local Stat = Frame.Stat;
            local v33 = u23.def.ValueFormat == "Level" and "LEVEL " .. ProgressionMath.state(v.value).level;

            if not v33 then
                local value = v.value;
                local v34;

                if value >= 1000000000 then
                    v34 = ("%.1fB"):format(value / 1000000000);
                elseif value >= 1000000 then
                    v34 = ("%.1fM"):format(value / 1000000);
                elseif value >= 10000 then
                    v34 = ("%.1fK"):format(value / 1000);
                else
                    local math_floor_ret = math.floor(value);
                    v34 = tostring(math_floor_ret);
                end;

                v33 = v34 .. " " .. u23.def.Suffix;
            end;

            Stat.Text = v33;
        end;

        Frame.PFP.Image = u4[v.userId] or "";
        u30.Parent = MainFrame.ScrollingFrame;
        table.insert(u23.rows, u30);

        if not u4[v.userId] and v.userId > 0 then
            task.spawn(function() -- Line: 144
                -- upvalues: Players (ref), v (copy), u4 (ref), u3 (ref), u1 (ref), u23 (copy), generation (copy), u30 (copy), Frame (copy)
                local v35, v36, v37 = pcall(Players.GetUserThumbnailAsync, Players, v.userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100);

                if v35 and v37 then
                    u4[v.userId] = v36;

                    if u3 and (u1[u23.id] == u23 and (u23.generation == generation and u30.Parent)) then
                        Frame.PFP.Image = v36;
                    end;
                end;
            end);
        end;
    end;
end;

local function attach(p38, p39, p40, p41) -- Line: 163
    -- upvalues: ChickenOrHero (copy), Leaderboards (copy), TeamEventBoard (copy), PlayerGui (copy), u1 (copy), render (copy)
    local LeaderboardPart = p40:FindFirstChild("LeaderboardPart");
    local v42;

    if LeaderboardPart then
        v42 = LeaderboardPart:FindFirstChildOfClass("SurfaceGui");
    else
        v42 = LeaderboardPart;
    end;

    local v43;

    if p39.Snapshot then
        v43 = ChickenOrHero.Game:FindFirstChild(p39.Snapshot);
    else
        v43 = Leaderboards:FindFirstChild(p38);
    end;

    if p39.Place and v42 then
        v42.Enabled = false;
    end;

    if not (v42 and v43) then
        return;
    end;

    local v44 = v42:Clone();
    v44.Name = "GlobalLeaderboard_" .. p38;
    v44.Adornee = LeaderboardPart;
    v44.Enabled = true;
    local v45;

    if p39.Place then
        v44.MainFrame.Title.AutoLocalize = false;
        local success, result = pcall(TeamEventBoard.build, v44, p38);
        v45 = success and result and result or nil;

        if not success then
            warn("[LeaderboardClient] team board style failed:", result);
        end;
    else
        v45 = nil;
    end;

    v44.Parent = PlayerGui;
    local SlotFrame = v44.MainFrame.ScrollingFrame.SlotFrame;
    SlotFrame.Visible = false;
    local u46 = {
        generation = 0,
        id = p41,
        key = p38,
        def = p39,
        model = p40,
        part = LeaderboardPart,
        base = LeaderboardPart.CFrame,
        source = v42,
        wasEnabled = v42.Enabled,
        gui = v44,
        snapshot = v43,
        template = SlotFrame,
        view = v45,
        rows = {}
    };
    u1[p41] = u46;
    v42.Enabled = false;
    u46.connection = v43.Changed:Connect(function() -- Line: 210
        -- upvalues: render (ref), u46 (copy)
        render(u46);
    end);
    render(u46);
end;

local u50 = RunService.RenderStepped:Connect(function(p47) -- Line: 215
    -- upvalues: u1 (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not workspace_CurrentCamera then
        return;
    end;

    local ServerTimeNow = workspace:GetServerTimeNow();

    for _, v in u1 do
        if v.part:IsDescendantOf(workspace) then
            local Position = workspace_CurrentCamera.CFrame.Position;

            if (Position - v.base.Position).Magnitude <= v.def.AnimateDistance then
                local Position2 = v.base.Position;
                local v48 = math.sin(ServerTimeNow * 2 * 3.141592653589793 / v.def.HoverPeriod) * v.def.HoverStuds;
                local v49 = Position2 + Vector3.new(0, v48, 0);
                local Vector3_new_ret = Vector3.new(Position.X, v49.Y, Position.Z);

                if (Vector3_new_ret - v49).Magnitude > 0.1 then
                    v.part.CFrame = v.part.CFrame:Lerp(CFrame.lookAt(v49, Vector3_new_ret), 1 - math.exp(-v.def.TurnResponsiveness * p47));
                end;
            end;
        end;
    end;
end);
script.Destroying:Connect(function() -- Line: 238
    -- upvalues: u3 (ref), u50 (copy), u1 (copy), clear (copy)
    u3 = false;
    u50:Disconnect();

    for i in u1 do
        clear(i);
    end;
end);

local function sync(p51, p52, p53, p54) -- Line: 271
    -- upvalues: u1 (copy), clear (copy), attach (copy)
    local v55 = p54 or p51;
    local v56 = u1[v55];

    if v56 and (p53 ~= v56.model or not v56.part:IsDescendantOf(workspace)) then
        clear(v55);
        v56 = nil;
    end;

    if p53 and not v56 then
        attach(p51, p52, p53, v55);
    end;
end;

local function findBoard(u57, u58, p59) -- Line: 246
    local function findIn(p60) -- Line: 247
        -- upvalues: u57 (copy), u58 (copy)
        if not p60 then
            return nil;
        end;

        for _, child in p60:GetChildren() do
            if child:IsA("Model") then
                local LeaderboardKey = child:FindFirstChild("LeaderboardKey");
                local v61 = child:GetAttribute("LeaderboardKey") or LeaderboardKey and LeaderboardKey:IsA("StringValue") and LeaderboardKey.Value;

                if v61 == u57 then
                    return child;
                end;
            end;
        end;

        local v62 = p60:FindFirstChild(u58.ModelName);

        if not (v62 and (v62:IsA("Model") and v62)) then
            v62 = nil;
        end;

        return v62;
    end;

    if u58.Container then
        if p59 then
            p59 = p59:FindFirstChild(u58.Container);
        end;

        return findIn(p59);
    end;

    local v63 = findIn(p59);

    if not v63 then
        if p59 then
            p59 = p59:FindFirstChild("Interactables");
        end;

        v63 = findIn(p59) or findIn(workspace);
    end;

    return v63;
end;

while u3 do
    local v64 = MapLocator.lobby();

    for i, v in LeaderboardConfig.Boards do
        sync(i, v, (findBoard(i, v, v64)));
    end;

    for i, v in LeaderboardConfig.SnapshotBoards or {} do
        sync(i, v, (findBoard(i, v, v64)));
    end;

    table.clear(v2);

    for _, child in workspace:GetChildren() do
        if child:IsA("Model") then
            local v65 = child;

            for i, v in LeaderboardConfig.EventBoards do
                local v66;

                if string.sub(v65.Name, 1, #v.Place) == v.Place then
                    v66 = v65:FindFirstChild(v.ModelName);
                else
                    v66 = false;
                end;

                if v66 and v66:IsA("Model") then
                    v2[v66] = true;
                    sync(i, v, v66, v66);
                end;
            end;
        end;
    end;

    for i, v in u1 do
        if v.def.Place and not v2[i] then
            clear(i);
        end;
    end;

    task.wait(1);
end;