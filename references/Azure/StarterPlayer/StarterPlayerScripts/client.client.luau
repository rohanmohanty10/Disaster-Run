 

 

game:GetService("ContentProvider");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TextChatService = game:GetService("TextChatService");
game:GetService("Teams");
local MarketplaceService = game:GetService("MarketplaceService");
local LocalPlayer = Players.LocalPlayer;

function shared.allvfxcheck() -- Line: 15
    -- upvalues: LocalPlayer (copy)
    local v1 = false;

    if LocalPlayer and (LocalPlayer:FindFirstChild("setting") and (not v1 and LocalPlayer.setting:FindFirstChild("NoVFXAtAll"))) then
        v1 = LocalPlayer.setting:FindFirstChild("NoVFXAtAll").Value;
    end;

    return v1;
end;

local CmdrClient = require(ReplicatedStorage:WaitForChild("CmdrClient"));
local starterPlayer = require(ReplicatedStorage.client.starterPlayer);
require(ReplicatedStorage.Part_Icles):Activate();
shared.nocustomreplication = true;
require(ReplicatedStorage:WaitForChild("packets"));
require(ReplicatedStorage:WaitForChild("Replicator")).start(ReplicatedStorage:WaitForChild("util"):WaitForChild("ReplicatorConfig"));
starterPlayer.new();
CmdrClient:SetActivationKeys({ Enum.KeyCode.F2, Enum.KeyCode.Quote });

if LocalPlayer.UserId == 5077795305 or LocalPlayer.UserId == 9823387274 then
    CmdrClient:SetActivationKeys({ Enum.KeyCode.F2 });
end;

TextChatService:WaitForChild("cmdr").Triggered:Connect(function(p2: userdata, p3: string) -- Line: 45
    -- upvalues: CmdrClient (copy)
    CmdrClient:Toggle();
end);
coroutine.wrap(function() -- Line: 49
    -- upvalues: MarketplaceService (copy), LocalPlayer (copy)
    local function manage(u4) -- Line: 51
        -- upvalues: MarketplaceService (ref), LocalPlayer (ref)
        if u4:IsA("TextButton") and u4:GetAttribute("ID") then
            u4.MouseButton1Click:Connect(function() -- Line: 53
                -- upvalues: MarketplaceService (ref), LocalPlayer (ref), u4 (copy)
                MarketplaceService:PromptProductPurchase(LocalPlayer, (tonumber(u4:GetAttribute("ID"))));
            end);
        end;
    end;

    local donator = workspace:WaitForChild("leaderboard"):WaitForChild("donator");
    local sufui = donator.sufui;
    sufui.ResetOnSpawn = false;
    sufui.Parent = LocalPlayer.PlayerGui;
    sufui.Adornee = donator;

    for _, child in sufui.Donations:GetChildren() do
        if child:IsA("TextButton") and child:GetAttribute("ID") then
            child.MouseButton1Click:Connect(function() -- Line: 53
                -- upvalues: MarketplaceService (ref), LocalPlayer (ref), child (copy)
                MarketplaceService:PromptProductPurchase(LocalPlayer, (tonumber(child:GetAttribute("ID"))));
            end);
        end;
    end;

    sufui.Donations.ChildAdded:Connect(function(u5) -- Line: 67
        -- upvalues: MarketplaceService (ref), LocalPlayer (ref)
        if u5:IsA("TextButton") and u5:GetAttribute("ID") then
            u5.MouseButton1Click:Connect(function() -- Line: 53
                -- upvalues: MarketplaceService (ref), LocalPlayer (ref), u5 (copy)
                MarketplaceService:PromptProductPurchase(LocalPlayer, (tonumber(u5:GetAttribute("ID"))));
            end);
        end;
    end);
end)();
local u6 = {};
local packets = require(ReplicatedStorage.packets);
local replication = require(ReplicatedStorage.client.replication);
local replicationForServer = require(ReplicatedStorage.client.replicationForServer);
local SignalValue = require(ReplicatedStorage.util.SignalValue);
ReplicatedStorage.ChildAdded:Connect(function(p7) -- Line: 97
    -- upvalues: replication (ref)
    if p7.Name == "replication" then
        replication = require(p7);
    end;
end);

local function destroySignals(p8) -- Line: 103
    -- upvalues: u6 (copy)
    for _, v in u6[p8] do
        v:Destroy();
    end;

    table.clear(u6[p8]);
end;

packets.bytenet_replication.listen(function(p9) -- Line: 112
    -- upvalues: replication (ref), RunService (copy)
    local name = p9.name;
    local content = p9.content;
    local v10 = replication[name];

    if v10 then
        if RunService:IsStudio() then
            v10(table.unpack(content));

            return;
        end;

        local success, result = pcall(v10, table.unpack(content));

        if not success then
            warn((`Error when attempting replication "{name}": {result}`));
        end;
    else
        warn((`{tostring(name)} does not exist`));
    end;
end);
print("init, replication event");
packets.bytenet_replication2.listen(function(p11) -- Line: 137
    -- upvalues: replication (ref), u6 (copy), destroySignals (copy), SignalValue (copy)
    local name = p11.name;
    local id = p11.id;
    local action = p11.action;
    local content = p11.content;
    local _ = replication[name];

    if action ~= 1 then
        if action == 2 then
            if not u6[id] then
                warn("effect doesn\'t exist");

                return;
            end;

            for i, v in content do
                u6[id][i].Value = v;
                u6[id][i].Changed:Fire(v);
            end;
        end;

        return;
    end;

    if not u6[id] then
        u6[id] = {};
        task.delay(240, destroySignals, id);
    end;

    for i, v in content do
        u6[id][i] = SignalValue.new(v);
    end;

    replication[name](u6[id]);
end);

function ReplicatedStorage.replicationForServerEvent2.OnClientInvoke(p12) -- Line: 171
    -- upvalues: replicationForServer (copy)
    if replicationForServer[p12[1]] then
        return replicationForServer[p12[1]](table.unpack(p12[2]));
    end;
end;