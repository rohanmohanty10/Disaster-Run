  

game:GetService("Players");
game:GetService("ReplicatedFirst");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local u1 = { 13929414, 189239279, 4946842593, 1754608862, 118124403, 7964479833, 552714899 };

if require(ReplicatedStorage.Shared.environment).env == "Dev" then
    for _, v in { 104188763, 2606515483 } do
        table.insert(u1, v);
    end;
end;

local u2 = RunService:IsServer();
local u3 = RunService:IsClient();
local u4 = u2 and "SERVER" or "CLIENT";
local script_Iris = script.Iris;
local u5 = {};
local u6 = {};

local function createFolder(p7, p8) -- Line: 65
    local Folder = Instance.new("Folder");
    Folder.Name = p7;
    Folder.Parent = p8;

    return Folder;
end;

local u9 = nil;
local u10 = nil;
local u11 = nil;

if u2 then
    u10 = Instance.new("Folder");
    u10.Name = "DEBUG_SERVERF";
    u10.Parent = ReplicatedStorage;
    u11 = Instance.new("RemoteEvent");
    u11.Name = "DEBUG_Comm";
    u11.Parent = ReplicatedStorage;
    u11.OnServerEvent:Connect(function(p12, p13, p14) -- Line: 81
        -- upvalues: RunService (copy), u1 (copy), u5 (copy)
        if RunService:IsStudio() or table.find(u1, p12.UserId) then
            u5[p13][p14](p14, p12);
        end;
    end);
else
    u9 = Instance.new("Folder");
    u9.Name = "DEBUG_CLIENTF";
    u9.Parent = ReplicatedStorage;
    task.spawn(function() -- Line: 88
        -- upvalues: u11 (ref), ReplicatedStorage (copy), u10 (ref)
        u11 = ReplicatedStorage:WaitForChild("DEBUG_Comm");
        u10 = ReplicatedStorage:WaitForChild("DEBUG_SERVERF");
    end);
end;

local v15 = {};
local Model = Instance.new("Model");
Model.Parent = workspace.Terrain;
local Highlight = Instance.new("Highlight");
Highlight.FillTransparency = 0.95;
Highlight.OutlineTransparency = 0.5;
Highlight.Parent = Model;

if RunService:IsStudio() then
    local u16 = 0;

    function v15.showPoint(u17: vector, u18: string) -- Line: 109
        -- upvalues: RunService (copy), Model (copy), u16 (ref)
        RunService.Heartbeat:Once(function() -- Line: 110
            -- upvalues: u18 (copy), Model (ref), u16 (ref), u17 (copy), RunService (ref)
            local v19 = u18 and Model:FindFirstChild(u18) or Instance.new("Part");

            if not v19.Parent then
                u16 = u16 + 1;
                local Color = BrickColor.palette(u16).Color;
                v19.CanCollide = false;
                v19.CanQuery = false;
                v19.Shape = Enum.PartType.Ball;
                v19.CanTouch = false;
                v19.CastShadow = false;
                v19.Anchored = true;
                v19.Size = Vector3.new(1, 1, 1);
                v19.Color = Color;
                v19.Material = Enum.Material.SmoothPlastic;

                if u18 then
                    v19.Name = tostring(u18);
                end;

                v19.Parent = Model;
            end;

            v19.CFrame = CFrame.new(u17);

            if not u18 then
                RunService.Heartbeat:Wait();
                v19:Destroy();
            end;
        end);
    end;

    function v15.showLine(u20: vector, u21: vector, u22: string) -- Line: 137
        -- upvalues: RunService (copy), Model (copy), u16 (ref)
        RunService.Heartbeat:Once(function() -- Line: 138
            -- upvalues: u22 (copy), Model (ref), u16 (ref), u20 (copy), u21 (copy), RunService (ref)
            local v23 = u22 and Model:FindFirstChild(u22) or Instance.new("Part");

            if not v23.Parent then
                u16 = u16 + 1;
                local Color = BrickColor.palette(u16).Color;
                v23.CanCollide = false;
                v23.CanQuery = false;
                v23.CanTouch = false;
                v23.CastShadow = false;
                v23.Anchored = true;
                v23.Color = Color;
                v23.Material = Enum.Material.SmoothPlastic;

                if u22 then
                    v23.Name = tostring(u22);
                end;

                v23.Parent = Model;
            end;

            v23.Shape = Enum.PartType.Block;
            v23.CFrame = CFrame.lookAlong(u20, u21) * CFrame.new(0, 0, -u21.Magnitude / 2);
            v23.Size = Vector3.new(0.2, 0.2, u21.Magnitude);

            if not u22 then
                RunService.Heartbeat:Wait();
                v23:Destroy();
            end;
        end);
    end;
else
    function v15.showPoint() -- Line: 165
    end;
end;

function v15.isAdmin(p24: userdata) -- Line: 168
    -- upvalues: u1 (copy)
    return table.find(u1, p24.UserId);
end;

function v15.createGroup(u25) -- Line: 172
    -- upvalues: u2 (copy), u10 (ref), u9 (ref), u4 (copy), u5 (copy), u6 (copy), u3 (copy)
    local Folder = Instance.new("Folder");
    Folder.Name = u25;
    Folder.Parent = u2 and u10 or u9;
    Folder:SetAttribute("Origin", u4);
    local v26 = {};

    if u2 then
        u5[u25] = {};
    else
        u6[u25] = {};
    end;

    function v26.setLabel(p27: string, p28: string, p29: string?) -- Line: 185
        -- upvalues: Folder (copy)
        local v30 = Folder:FindFirstChild("label_" .. p27);

        if not v30 then
            v30 = Instance.new("StringValue");
            v30.Name = "label_" .. p27;
            v30.Parent = Folder;
        end;

        if p29 then
            p28 = `{p28}: {p29}`;
        end;

        v30.Value = p28;
    end;

    function v26.addButton(p31: string, p32: string, p33: function) -- Line: 196
        -- upvalues: u2 (ref), u5 (ref), u25 (copy), u3 (ref), u6 (ref), Folder (copy)
        local v34 = `no text for addButton {p31}`;
        assert(p32, v34);
        local v35 = `no callback for addButton {p31}`;
        assert(p33, v35);

        if u2 then
            u5[u25][p31] = p33;
        elseif u3 then
            u6[u25][p31] = p33;
        end;

        local v36 = Folder:FindFirstChild("button_" .. p31);

        if not v36 then
            v36 = Instance.new("StringValue");
            v36.Name = "button_" .. p31;
            v36.Parent = Folder;
        end;

        v36.Value = p32;
    end;

    function v26.destroy() -- Line: 214
        -- upvalues: Folder (copy)
        Folder:Destroy();
    end;

    return v26;
end;

v15.Global = v15.createGroup("Global");

local function initClient() -- Line: 224
    -- upvalues: script_Iris (copy), UserInputService (copy), u10 (ref), u11 (ref), u9 (ref), u6 (copy)
    if not script_Iris then
        for _, v in { game:GetService("ReplicatedFirst"), game:GetService("ReplicatedStorage") } do
            local iris = v:FindFirstChild("iris", true);

            if iris then
                if iris:FindFirstChild("config") and iris:FindFirstChild("widgets") then
                    break;
                end;
            end;
        end;
    end;

    if not script_Iris then
        warn("Required DebugUtil but iris is not installed! Make sure it is in ReplicatedStorage or ReplicatedFirst.");

        return;
    end;

    local u37 = require(script_Iris).Init();

    local function sortedChildren(p38: userdata) -- Line: 250
        local Children = p38:GetChildren();

        local function sorttype(p39) -- Line: 252
            if p39:sub(1, 5) == "label" then
                return "b_" .. p39;
            end;

            if p39:sub(1, 6) == "button" then
                return "a_" .. p39;
            end;

            return "z_" .. p39;
        end;

        table.sort(Children, function(p40, p41) -- Line: 261
            local Name = p40.Name;
            local v42;

            if Name:sub(1, 5) == "label" then
                v42 = "b_" .. Name;
            elseif Name:sub(1, 6) == "button" then
                v42 = "a_" .. Name;
            else
                v42 = "z_" .. Name;
            end;

            local Name2 = p41.Name;
            local v43;

            if Name2:sub(1, 5) == "label" then
                v43 = "b_" .. Name2;
            elseif Name2:sub(1, 6) == "button" then
                v43 = "a_" .. Name2;
            else
                v43 = "z_" .. Name2;
            end;

            return v42 < v43;
        end);

        return Children;
    end;

    local u44 = {};
    UserInputService.InputBegan:Connect(function(p45, p46) -- Line: 268
        -- upvalues: u44 (copy)
        if p46 then
            return;
        end;

        u44[p45.KeyCode] = true;
    end);

    local function buildStackFolder(p47) -- Line: 275
        -- upvalues: u10 (ref), u37 (copy), sortedChildren (copy), u44 (copy), u11 (ref), u9 (ref), u6 (ref)
        if p47 == u10 then
            u37.SeparatorText({ "Server" });
        else
            u37.SeparatorText({ "Client" });
        end;

        for _, v in sortedChildren(p47) do
            u37.Tree({ v.Name }, {
                isUncollapsed = u37.State(true)
            });
            local u48 = v;
            local v49 = 0;

            for _, v2 in sortedChildren(v) do
                if v2.Name:sub(1, 5) == "label" then
                    if v49 > 0 then
                        u37.End();
                        v49 = 0;
                    end;

                    u37.Text({ v2.Value });
                elseif v2.Name:sub(1, 6) == "button" then
                    if v49 == 0 then
                        u37.SameLine();
                    elseif v49 == 4 then
                        u37.End();
                        u37.SameLine();
                        v49 = 0;
                    end;

                    v49 = v49 + 1;
                    local v50 = v2.Value == "Take ball" and Enum.KeyCode.Y;

                    if not v50 then
                        if v2.Value == "Reset Cooldowns" then
                            v50 = Enum.KeyCode.U;
                        else
                            v50 = false;
                        end;
                    end;

                    if v50 then
                        v50 = u44[v50];
                    end;

                    if u37.Button({ v2.Value }).clicked() or v50 then
                        if p47 == u10 then
                            u11:FireServer(u48.Name, v2.Name:sub(8));
                        elseif p47 == u9 then
                            task.spawn(function() -- Line: 309
                                -- upvalues: u6 (ref), u48 (copy), v2 (copy)
                                u6[u48.Name][v2.Name:sub(8)]();
                            end);
                        end;
                    end;
                end;
            end;

            if v49 > 0 then
                u37.End();
            end;

            u37.End();
        end;
    end;

    local u51 = false;
    u37:Connect(function() -- Line: 325
        -- upvalues: u9 (ref), u10 (ref), u37 (copy), u51 (ref), buildStackFolder (copy), u44 (copy)
        if u9 and u10 then
            u37.Window({ "Debug Window" }).Instance.Enabled = u51;
            buildStackFolder(u9);
            buildStackFolder(u10);
            u37.End();
            table.clear(u44);
        end;
    end);
    UserInputService.InputBegan:Connect(function(p52, p53) -- Line: 336
        -- upvalues: u51 (ref)
        if p53 then
            return;
        end;

        if p52.KeyCode == Enum.KeyCode.J then
            u51 = not u51;
        end;
    end);
end;

task.spawn(function() -- Line: 344
    -- upvalues: u3 (copy), RunService (copy), u1 (copy), initClient (copy)
    if u3 and (RunService:IsStudio() or table.find(u1, game.Players.LocalPlayer.UserId)) then
        task.spawn(initClient);
    end;
end);

return v15;