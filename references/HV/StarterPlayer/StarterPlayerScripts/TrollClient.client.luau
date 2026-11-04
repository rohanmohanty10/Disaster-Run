 

 

local Players = game:GetService("Players");
local SoundService = game:GetService("SoundService");
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local Trolls = ChickenOrHero:WaitForChild("Trolls");
local TrollShared = require(Trolls:WaitForChild("TrollShared"));
local LocalPlayer = Players.LocalPlayer;
local u1 = Trolls:WaitForChild(TrollShared.StateName, 120);
local v2 = Trolls:WaitForChild(TrollShared.RemoteName, 120);
local Client = Trolls:WaitForChild("Client", 120);

if not (u1 and (v2 and Client)) then
    return;
end;

local u3 = {};
local u4 = {
    player = LocalPlayer,
    state = u1,
    Shared = TrollShared,
    package = ChickenOrHero
};
local u5 = require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags")).awaitUIVersion();

function u4.toast(u6) -- Line: 27
    -- upvalues: u5 (copy), ChickenOrHero (copy)
    local success, result = pcall(function() -- Line: 28
        -- upvalues: u5 (ref), ChickenOrHero (ref), u6 (copy)
        if u5 == "NewGui" then
            require(ChickenOrHero:WaitForChild("Interface"):WaitForChild("Toasts")).show(u6);

            return;
        end;

        require(ChickenOrHero:WaitForChild("Presentation"):WaitForChild("ValleyToast")).show(u6, 2.5);
    end);

    if not success then
        warn("Troll toast:", result);
    end;
end;

function u4.font() -- Line: 42
    -- upvalues: u5 (copy), LocalPlayer (copy)
    if u5 == "NewGui" then
        for _, descendant in LocalPlayer:WaitForChild("PlayerGui"):GetDescendants() do
            if descendant.Name == "EscapeStatus" and descendant:IsA("TextLabel") then
                return descendant.FontFace;
            end;
        end;
    end;

    return Font.fromEnum(Enum.Font.GothamBold);
end;

function u4.exempt() -- Line: 53
    -- upvalues: TrollShared (copy), LocalPlayer (copy)
    return TrollShared.exempt(LocalPlayer);
end;

function u4.on(p7, p8) -- Line: 57
    -- upvalues: u3 (copy)
    u3[p7] = u3[p7] or {};
    table.insert(u3[p7], p8);
end;

function u4.sound(p9, p10, p11) -- Line: 63
    -- upvalues: SoundService (copy)
    local GameAudio = SoundService:FindFirstChild("GameAudio");

    for i in string.gmatch(p9, "[^/]+") do
        if GameAudio then
            GameAudio = GameAudio:FindFirstChild(i);
        end;
    end;

    if not (GameAudio and GameAudio:IsA("Sound")) then
        return nil;
    end;

    local u12 = GameAudio:Clone();

    if p11 then
        u12.Volume = p11;
    end;

    u12.Looped = false;
    u12.Parent = p10 or SoundService;
    u12:Play();
    u12.Ended:Once(function() -- Line: 78
        -- upvalues: u12 (copy)
        u12:Destroy();
    end);
    task.delay(10, function() -- Line: 81
        -- upvalues: u12 (copy)
        if u12.Parent then
            u12:Destroy();
        end;
    end);

    return u12;
end;

local function debugOn() -- Line: 90
    -- upvalues: u1 (copy)
    return u1:GetAttribute("Debug") == true;
end;

u1:GetAttributeChangedSignal("Debug"):Connect(function() -- Line: 93, Name: sayDebug
    -- upvalues: u1 (copy)
    if u1:GetAttribute("Debug") == true then
        warn("[Troll DEBUG] Debug mode is ON: trolls hit owners and admins too (you included). Test place and Studio only.");
    end;
end);

if u1:GetAttribute("Debug") == true then
    warn("[Troll DEBUG] Debug mode is ON: trolls hit owners and admins too (you included). Test place and Studio only.");
end;

v2.OnClientEvent:Connect(function(u13, u14) -- Line: 101
    -- upvalues: u3 (copy)
    for _, v in u3[u13] or {} do
        task.spawn(function() -- Line: 103
            -- upvalues: v (copy), u14 (copy), u13 (copy)
            local success, result = pcall(v, u14);

            if not success then
                warn("Troll " .. tostring(u13) .. ":", result);
            end;
        end);
    end;
end);

local function start(p15) -- Line: 112
    -- upvalues: u4 (copy)
    local success, result = pcall(require, p15);

    if not (success and (type(result) == "table" and type(result.start) == "function")) then
        warn("Troll client " .. p15.Name .. " didn\'t load:", result);

        return;
    end;

    local success2, result2 = pcall(result.start, u4);

    if not success2 then
        warn("Troll client " .. p15.Name .. " failed:", result2);
    end;
end;

for _, child in Client:GetChildren() do
    if child:IsA("ModuleScript") then
        task.spawn(start, child);
    end;
end;