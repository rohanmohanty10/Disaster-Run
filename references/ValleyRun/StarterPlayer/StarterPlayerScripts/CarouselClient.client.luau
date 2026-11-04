 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local ChickenOrHero = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero");
local Session = ChickenOrHero:WaitForChild("Game"):WaitForChild("Session");
local CarouselConfig = require(ChickenOrHero.Game:WaitForChild("CarouselConfig"));
local LocalPlayer = Players.LocalPlayer;
local u1 = nil;
local u2 = nil;
local u3 = {};
local u4 = {};
local u5 = {};
local u6 = {};
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;

local function stop() -- Line: 23
    -- upvalues: u7 (ref), u8 (ref), u9 (ref), u1 (ref), u2 (ref), u10 (ref), u3 (copy), u4 (copy), u5 (copy), u6 (copy)
    for _, v in { u7, u8, u9 } do
        v:Disconnect();
    end;

    u7 = nil;
    u8 = nil;
    u9 = nil;
    u1 = nil;
    u2 = nil;
    u10 = nil;
    table.clear(u3);
    table.clear(u4);
    table.clear(u5);
    table.clear(u6);
end;

local function rider(p11) -- Line: 37
    local v12 = (1 / 0);
    local v13 = nil;

    for _, child in p11:GetChildren() do
        if child:IsA("BasePart") then
            v12 = math.min(v12, child.Position.Y - child.Size.Y / 2);
        elseif child:IsA("Model") then
            v13 = child;
        end;
    end;

    if v12 < 40 then
        return v13 or p11;
    end;

    return nil;
end;

local function carryMine() -- Line: 51
    -- upvalues: u10 (ref), CarouselConfig (copy), LocalPlayer (copy), u1 (ref)
    local ServerTimeNow = workspace:GetServerTimeNow();
    local v14 = u10 and ((ServerTimeNow - u10) * CarouselConfig.rate() or 0) or 0;
    u10 = ServerTimeNow;

    if v14 <= 0 or v14 >= 0.5 then
        return;
    end;

    local Character = LocalPlayer.Character;
    local v15;

    if Character then
        v15 = Character:FindFirstChild("HumanoidRootPart");
    else
        v15 = Character;
    end;

    if not v15 or (v15.Anchored or Character:GetAttribute("Ragdolled")) then
        return;
    end;

    if CarouselConfig.onDeck(u1, v15.Position) then
        v15.CFrame = CarouselConfig.turn(u1, v14) * v15.CFrame;
    end;
end;

local function start(u16) -- Line: 68
    -- upvalues: u1 (ref), stop (copy), u2 (ref), CarouselConfig (copy), rider (copy), u3 (copy), u4 (copy), u5 (copy), u6 (copy), u9 (ref), u8 (ref), RunService (copy), carryMine (copy), u7 (ref)
    if u1 then
        stop();
    end;

    u1 = u16;
    u2 = CarouselConfig.axis(u16);
    local Horses = u16:FindFirstChild("Horses");
    local v17 = {};

    for _, v in Horses and Horses:GetChildren() or {} do
        local v18 = rider(v);

        if v18 then
            local v19 = CarouselConfig.ride(u16, v18:GetBoundingBox().Position);

            for _, descendant in v18:GetDescendants() do
                if descendant:IsA("BasePart") then
                    v17[descendant] = v19;
                end;
            end;
        end;
    end;

    for _, descendant in u16:GetDescendants() do
        if descendant:IsA("BasePart") then
            table.insert(u3, descendant);
            table.insert(u4, u2:ToObjectSpace(descendant.CFrame));
            u5[#u3] = v17[descendant] or false;
            u6[#u3] = descendant.CFrame;
        end;
    end;

    u9 = u16.AncestryChanged:Connect(function() -- Line: 95
        -- upvalues: u16 (copy), stop (ref)
        if not u16:IsDescendantOf(workspace) then
            stop();
        end;
    end);
    u8 = RunService.PreSimulation:Connect(carryMine);
    u7 = RunService.RenderStepped:Connect(function() -- Line: 101
        -- upvalues: u2 (ref), CarouselConfig (ref), u4 (ref), u5 (ref), u6 (ref), u3 (ref)
        local workspace_CurrentCamera = workspace.CurrentCamera;

        if not workspace_CurrentCamera or (workspace_CurrentCamera.CFrame.Position - u2.Position).Magnitude > 400 then
            return;
        end;

        local ServerTimeNow = workspace:GetServerTimeNow();
        local v20 = u2 * CFrame.Angles(0, CarouselConfig.angle(ServerTimeNow), 0);

        for i, v in u4 do
            local v21 = v20 * v;
            local v22 = u5[i];

            if v22 then
                local v23 = v22[1] + v22[2] * math.sin(ServerTimeNow * v22[3] + v22[4]);
                v21 = v21 + Vector3.new(0, v23, 0);
            end;

            u6[i] = v21;
        end;

        workspace:BulkMoveTo(u3, u6, Enum.BulkMoveMode.FireCFrameChanged);
    end);
end;

local u24 = false;

local function refresh() -- Line: 122
    -- upvalues: Session (copy), CarouselConfig (copy), u1 (ref), stop (copy), u24 (ref), start (copy)
    if Session:GetAttribute("ActiveMapId") ~= CarouselConfig.Map then
        if u1 then
            stop();
        end;

        return;
    end;

    if u1 or u24 then
        return;
    end;

    u24 = true;
    task.spawn(function() -- Line: 133
        -- upvalues: Session (ref), CarouselConfig (ref), u1 (ref), start (ref), u24 (ref)
        local v25 = os.clock() + 120;

        while Session:GetAttribute("ActiveMapId") == CarouselConfig.Map and (not u1 and os.clock() < v25) do
            local v26 = CarouselConfig.model();

            if v26 and v26:FindFirstChild("Horses") then
                start(v26);
                break;
            end;

            task.wait(1);
        end;

        u24 = false;
    end);
end;

Session:GetAttributeChangedSignal("ActiveMapId"):Connect(refresh);
workspace.ChildAdded:Connect(function(p27) -- Line: 149
    -- upvalues: CarouselConfig (copy), refresh (copy)
    if p27.Name == CarouselConfig.Map then
        refresh();
    end;
end);
task.spawn(function() -- Line: 154
    -- upvalues: refresh (copy)
    while true do
        task.wait(5);
        refresh();
    end;
end);
refresh();